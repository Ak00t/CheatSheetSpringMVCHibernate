package com.hibernate.service;

import java.time.LocalDateTime;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hibernate.entity.BookmarkEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.repository.BookmarkRepository;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class BookmarkServiceImpl implements BookmarkService {

    private final BookmarkRepository bookmarkRepository;
    private final SessionFactory sessionFactory;
    @Override
    public void save(BookmarkEntity bookmark) {
        Session session = sessionFactory.getCurrentSession();
        session.save(bookmark);
        session.flush(); // 💡 🛑 အရေးကြီးဆုံး: Database ထဲကို ချက်ချင်း အတင်းအကျပ် ရေးခိုင်းလိုက်တာ ဖြစ်ပါတယ်
    }
    @Override
    public void toggleBookmark(Long userId, Long cheatsheetId) {
        
        // 💡 ၁။ Cheatsheet အရင်ဆွဲထုတ်ပြီး ရှိမရှိ စစ်မယ်
        CheatsheetEntity cheatsheet = sessionFactory.getCurrentSession().get(CheatsheetEntity.class, cheatsheetId);
        if (cheatsheet == null) {
            throw new RuntimeException("Cheatsheet context not found!");
        }

        if (bookmarkRepository.isBookmarked(userId, cheatsheetId)) {
            // 💡 ၂။ Bookmark ရှိပြီးသားဆိုရင် ဖျက်မယ်
            bookmarkRepository.delete(userId, cheatsheetId);
            
            // Cheatsheet table ထဲက count ကို လိုက်လျှော့ပေးမယ်
            int currentCount = cheatsheet.getBookmarkCount() != null ? cheatsheet.getBookmarkCount() : 0;
            cheatsheet.setBookmarkCount(Math.max(0, currentCount - 1));
            
        } else {
            // 💡 ၃။ Bookmark မရှိသေးရင် အသစ်သွင်းမယ်
            BookmarkEntity bookmark = new BookmarkEntity();
            
            // 🛑 အရေးကြီးဆုံးပြင်ဆင်ချက်: IdClass သုံးထားလို့ Primitive Fields တွေကိုပဲ တိုက်ရိုက် Assign လုပ်ပေးရပါမယ်
            bookmark.setUserId(userId);
            bookmark.setCheatsheetId(cheatsheetId);
            bookmark.setCreatedAt(LocalDateTime.now());
            
            bookmarkRepository.save(bookmark);
            
            // Cheatsheet table ထဲက count ကို လိုက်တိုးပေးမယ်
            int currentCount = cheatsheet.getBookmarkCount() != null ? cheatsheet.getBookmarkCount() : 0;
            cheatsheet.setBookmarkCount(currentCount + 1);
        }
        
        // Cheatsheet ရဲ့ Count တန်ဖိုးကို Database ထဲ Sync ပြန်လုပ်မယ်
        sessionFactory.getCurrentSession().update(cheatsheet);
    }

    @Override
    public boolean isBookmarked(Long userId, Long cheatsheetId) {
        return bookmarkRepository.isBookmarked(userId, cheatsheetId);
    }
}