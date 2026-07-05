package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.CategoryEntity;

public interface UserFollowedCategoryService {

    void follow(Long userId, Long categoryId);

    void unfollow(Long userId, Long categoryId);

    boolean isFollowing(Long userId, Long categoryId);

    long countFollowers(Long categoryId);
    List<CategoryEntity> findFollowedCategoriesByUserId(Long userId);
}