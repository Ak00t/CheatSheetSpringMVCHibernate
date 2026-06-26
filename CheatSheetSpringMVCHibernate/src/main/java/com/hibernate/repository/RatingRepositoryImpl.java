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
        String sql = "SELECT AVG(rating) FROM ratings WHERE cheatsheet_id = :cheatsheetId";
        
        // createSQLQuery အစား createNativeQuery ကို သုံးပါ
        Object result = sessionFactory.getCurrentSession()
                .createNativeQuery(sql) 
                .setParameter("cheatsheetId", cheatsheetId)
                .uniqueResult();
        
        // Hibernate ၏ NativeQuery မှရသော result သည် အများအားဖြင့် Double သို့မဟုတ် BigDecimal ဖြစ်တတ်သည်
        if (result == null) {
            return BigDecimal.ZERO;
        } else if (result instanceof Double) {
            return BigDecimal.valueOf((Double) result);
        } else {
            return (BigDecimal) result;
        }
    }
}