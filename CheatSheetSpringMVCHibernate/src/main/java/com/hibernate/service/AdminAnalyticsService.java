package com.hibernate.service;

import java.util.List;
import com.hibernate.DTO.AdminAnalyticsDTO;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;

public interface AdminAnalyticsService {
    AdminAnalyticsDTO getCompiledAnalyticsDashboard(String type, Integer year, Integer month, Integer week, String day);
    Long getHighestViewCount(String type, Integer year, Integer month, Integer week, String day);
    List<CheatsheetEntity> getTopViewedCheatsheets(String type, Integer year, Integer month, Integer week, String day);
    List<UserEntity> getUsersByPeriod(String type, Integer year, Integer month, Integer week, String day);
}