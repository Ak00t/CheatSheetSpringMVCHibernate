package com.hibernate.service;

public interface LikeService {
    void toggleLike(Long userId, Long cheatsheetId);
    boolean isLiked(Long userId, Long cheatsheetId);
    Integer countLikes(Long cheatsheetId);
}
