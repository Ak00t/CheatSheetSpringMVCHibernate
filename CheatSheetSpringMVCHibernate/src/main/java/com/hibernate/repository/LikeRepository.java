package com.hibernate.repository;

import com.hibernate.entity.LikeEntity;

public interface LikeRepository {
    void save(LikeEntity like);
    void delete(Long userId, Long cheatsheetId);
    boolean exists(Long userId, Long cheatsheetId);
    Integer countLikes(Long cheatsheetId);
}