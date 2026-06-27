package com.hibernate.repository;

import java.math.BigDecimal;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.RatingEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RatingRepositoryImpl implements RatingRepository {
    private final SessionFactory sessionFactory;

    @Override
    public void save(RatingEntity rating) {
        sessionFactory.getCurrentSession().save(rating);
    }

    @Override
    public BigDecimal getAverageRating(Long cheatsheetId) {
        // ROUND(AVG(rating), 2) နဲ့ဆိုရင် 2 နေရာထိပဲ ယူပါမယ်
        String sql = "SELECT COALESCE(ROUND(AVG(rating), 2), 0) FROM ratings WHERE cheatsheet_id = :cheatsheetId";
        
        Object result = sessionFactory.getCurrentSession()
                .createNativeQuery(sql)
                .setParameter("cheatsheetId", cheatsheetId)
                .uniqueResult();
        
        // Result က Number ဖြစ်ရင် BigDecimal ပြောင်းမယ်
        if (result instanceof Number) {
            return BigDecimal.valueOf(((Number) result).doubleValue());
        }
        return BigDecimal.ZERO;
    }
}