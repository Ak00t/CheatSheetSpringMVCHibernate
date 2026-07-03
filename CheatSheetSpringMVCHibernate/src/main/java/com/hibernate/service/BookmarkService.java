package com.hibernate.service;

import com.hibernate.entity.BookmarkEntity;

public interface BookmarkService {
    void toggleBookmark(Long userId, Long cheatsheetId);
    boolean isBookmarked(Long userId, Long cheatsheetId);
	void save(BookmarkEntity bookmark);
}