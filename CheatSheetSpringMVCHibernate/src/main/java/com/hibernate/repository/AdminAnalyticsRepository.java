package com.hibernate.repository;

import java.util.List;
import com.hibernate.DTO.AdminAnalyticsDTO;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;

public interface AdminAnalyticsRepository {
    AdminAnalyticsDTO fetchFilteredAnalyticsData(String type, Integer year, Integer month, Integer week, String day);
    Long findMaxViewsByCriteria(String type, Integer year, Integer month, Integer week, String day);
    List<CheatsheetEntity> findTopViewedCheatsheets(String type, Integer year, Integer month, Integer week, String day);
    List<UserEntity> findUsersByPeriod(String type, Integer year, Integer month, Integer week, String day);
}