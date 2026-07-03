package com.hibernate.repository;

import java.math.BigDecimal;

import com.hibernate.entity.RatingEntity;

public interface RatingRepository {
    void save(RatingEntity rating);
    BigDecimal getAverageRating(Long cheatsheetId);
}