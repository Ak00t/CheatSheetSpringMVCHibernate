package com.hibernate.service;

public interface UserFollowService {
    void toggleFollow(Long followerId, Long followingId);

	boolean isFollowing(Long currentUserId, Long id);
}