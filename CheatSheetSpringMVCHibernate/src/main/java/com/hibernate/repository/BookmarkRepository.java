package com.hibernate.repository;

import com.hibernate.entity.BookmarkEntity;

public interface BookmarkRepository {
    void save(BookmarkEntity bookmark);
    void delete(Long userId, Long cheatsheetId);
    boolean isBookmarked(Long userId, Long cheatsheetId);
}
