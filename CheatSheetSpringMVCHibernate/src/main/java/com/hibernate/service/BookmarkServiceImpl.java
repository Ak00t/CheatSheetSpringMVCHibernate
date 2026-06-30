package com.hibernate.service;

import java.time.LocalDateTime;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.BookmarkEntity;
import com.hibernate.repository.BookmarkRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class BookmarkServiceImpl implements BookmarkService {

    private final BookmarkRepository bookmarkRepository;
    private final SessionFactory sessionFactory;

    @Override
    public void toggleBookmark(Long userId, Long cheatsheetId) {
        if (bookmarkRepository.isBookmarked(userId, cheatsheetId)) {
            // အကယ်၍ Bookmark လုပ်ထားပြီးသားဆိုရင် ဖျက်ထုတ်လိုက်ပါ
            bookmarkRepository.delete(userId, cheatsheetId);
        } else {
            // Bookmark မလုပ်ရသေးရင် အသစ်ဆောက်ပါ
            BookmarkEntity bookmark = new BookmarkEntity();
            bookmark.setUserId(userId);
            bookmark.setCheatsheetId(cheatsheetId);
            bookmark.setCreatedAt(LocalDateTime.now());
            
            bookmarkRepository.save(bookmark);
        }
    }

    @Override
    public boolean isBookmarked(Long userId, Long cheatsheetId) {
        return bookmarkRepository.isBookmarked(userId, cheatsheetId);
    }
}