package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.UserFollowEntity;

public interface FollowRepository {
    UserFollowEntity findFollow(Long followerId, Long followingId);
    void save(UserFollowEntity follow);
    void remove(UserFollowEntity follow);
    List<?> getFollowersData(Long currentUserId);
    List<?> getFollowingData(Long currentUserId);
}
