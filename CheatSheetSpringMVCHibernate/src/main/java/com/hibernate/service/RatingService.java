package com.hibernate.service;

public interface RatingService {
    void addRating(Long userId, Long cheatsheetId, Integer rating);
}
