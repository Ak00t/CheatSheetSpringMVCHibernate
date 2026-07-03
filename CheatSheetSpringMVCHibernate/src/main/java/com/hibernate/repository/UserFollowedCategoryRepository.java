package com.hibernate.repository;

public interface UserFollowedCategoryRepository {

    void follow(Long userId, Long categoryId);

    void unfollow(Long userId, Long categoryId);

    boolean isFollowing(Long userId, Long categoryId);

    long countFollowers(Long categoryId);
}