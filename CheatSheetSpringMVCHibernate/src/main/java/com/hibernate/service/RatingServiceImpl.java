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
        
        // ၁။ Rating ရှိပြီးသားလား စစ်ဆေးခြင်း
        String hql = "FROM RatingEntity r WHERE r.user.id = :userId AND r.cheatsheet.id = :cheatsheetId";
        RatingEntity rating = (RatingEntity) session.createQuery(hql)
                .setParameter("userId", userId)
                .setParameter("cheatsheetId", cheatsheetId)
                .uniqueResult();

        if (rating != null) {
            rating.setRating(score);
            session.update(rating);
        } else {
            RatingEntity newRating = new RatingEntity();
            newRating.setRating(score);
            newRating.setCheatsheet(session.get(CheatsheetEntity.class, cheatsheetId));
            newRating.setUser(session.get(UserEntity.class, userId));
            session.save(newRating);
        }
        
        // အရေးကြီး: Database ကို တန်းပြီး commit/flush လုပ်မှ Average အမှန်ရမှာပါ
        session.flush(); 

        // ၂။ Average ပြန်တွက်ခြင်း
        BigDecimal newAvg = ratingRepository.getAverageRating(cheatsheetId);
        
        // ၃။ Cheatsheet ထဲသို့ Update လုပ်ခြင်း
        CheatsheetEntity sheet = session.get(CheatsheetEntity.class, cheatsheetId);
        if (sheet != null) {
            sheet.setRatingAvg(newAvg);
            session.update(sheet); // explicitly update
        }
    }
}