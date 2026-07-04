package com.hibernate.service;

public interface FollowService {
    void toggleFollow(Long followerId, Long followingId);
    boolean isFollowing(Long followerId, Long followingId);
}
