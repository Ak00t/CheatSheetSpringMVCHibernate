package com.hibernate.service;

import java.util.List;

public interface FollowService {
    void toggleFollow(Long followerId, Long followingId);
    boolean isFollowing(Long followerId, Long followingId);

    List<?> findFollowersData(Long currentUserId);
    List<?> findFollowingData(Long currentUserId);

    long getFollowersCount(Long userId);
    long getFollowingCount(Long userId);
}
