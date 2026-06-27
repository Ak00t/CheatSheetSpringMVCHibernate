package com.hibernate.service;

public interface BookmarkService {
    void toggleBookmark(Long userId, Long cheatsheetId);
    boolean isBookmarked(Long userId, Long cheatsheetId);
}