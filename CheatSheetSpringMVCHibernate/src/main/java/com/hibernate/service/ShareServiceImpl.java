package com.hibernate.service;

import com.hibernate.entity.ShareEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.enums.SharePlatform;
import com.hibernate.repository.ShareRepository;
import org.hibernate.Hibernate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor; // 👈 Lombok Import သေချာပါဝင်ပါစေ
import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor // 👈 🛑 ဒီမှာ တပ်လိုက်ပါပြီဗျာ
public class ShareServiceImpl implements ShareService {

    // 💡 🛑 အရေးကြီးဆုံးအချက်: @Autowired ဖြုတ်ပြီး 'private final' လို့ မဖြစ်မနေ ပြောင်းပေးရပါမယ်ဗျာ
    private final ShareRepository shareRepository;

    @Override
    public void saveShareLog(Long userId, Long cheatsheetId, String platformStr) {
        UserEntity user = new UserEntity();
        user.setId(userId);

        CheatsheetEntity sheets = new CheatsheetEntity();
        sheets.setId(cheatsheetId);

        ShareEntity share = new ShareEntity();
        share.setUser(user);
        share.setCheatsheet(sheets);
        share.setCreatedAt(LocalDateTime.now());
        
        try {
            share.setPlatform(SharePlatform.valueOf(platformStr.toUpperCase()));
        } catch (Exception e) {
            share.setPlatform(SharePlatform.LINK);
        }

        shareRepository.save(share);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ShareEntity> findSharesByUserId(Long userId) {
        List<ShareEntity> shares = shareRepository.findByUserId(userId);
        
        if (shares != null) {
            for (ShareEntity s : shares) {
                if (s.getCheatsheet() != null) {
                    Hibernate.initialize(s.getCheatsheet());
                    if (s.getCheatsheet().getCategory() != null) {
                        Hibernate.initialize(s.getCheatsheet().getCategory());
                    }
                    if (s.getCheatsheet().getUser() != null) {
                        Hibernate.initialize(s.getCheatsheet().getUser());
                    }
                }
            }
        }
        return shares;
    }
}