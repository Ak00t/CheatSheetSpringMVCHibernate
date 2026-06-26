package com.hibernate.service;

import java.math.BigDecimal;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.RatingEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.RatingRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class RatingServiceImpl implements RatingService {
    private final RatingRepository ratingRepository;
    private final SessionFactory sessionFactory;

    @Override
    public void addRating(Long userId, Long cheatsheetId, Integer score) {
        Session session = sessionFactory.getCurrentSession();
        
        // ၁။ အရင်ဆုံး ဒီ User က ဒီ Cheatsheet ကို Rating ပေးထားပြီးသားလား စစ်မယ်
        String hql = "FROM RatingEntity r WHERE r.user.id = :userId AND r.cheatsheet.id = :cheatsheetId";
        RatingEntity existingRating = (RatingEntity) session.createQuery(hql)
                .setParameter("userId", userId)
                .setParameter("cheatsheetId", cheatsheetId)
                .uniqueResult();

        if (existingRating != null) {
            // Rating ရှိပြီးသားဆိုရင် Update လုပ်မယ်
            existingRating.setRating(score);
            session.update(existingRating);
        } else {
            // မရှိသေးရင် အသစ်ဆောက်မယ်
            RatingEntity newRating = new RatingEntity();
            newRating.setRating(score);
            newRating.setCheatsheet((CheatsheetEntity) session.get(CheatsheetEntity.class, cheatsheetId));
            newRating.setUser((UserEntity) session.get(UserEntity.class, userId));
            session.save(newRating);
        }

        // ၂။ Average ပြန်တွက်ပြီး update လုပ်ပေးခြင်း (အပေါ်က logic အတိုင်း)
        BigDecimal newAvg = ratingRepository.getAverageRating(cheatsheetId);
        CheatsheetEntity sheet = (CheatsheetEntity) session.get(CheatsheetEntity.class, cheatsheetId);
        sheet.setRatingAvg(newAvg);
    }
}