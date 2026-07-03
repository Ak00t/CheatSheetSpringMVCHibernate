package com.hibernate.repository;

import com.hibernate.entity.CheatsheetEntity;
import java.time.LocalDateTime;
import java.util.List;

public interface TopRatingRepository {
    List<CheatsheetEntity> findTopRatedCheatsheets(LocalDateTime start, LocalDateTime end);
}