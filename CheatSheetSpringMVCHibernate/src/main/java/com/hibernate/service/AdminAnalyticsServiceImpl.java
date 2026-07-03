package com.hibernate.service;

import com.hibernate.DTO.AdminAnalyticsDTO;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.AdminAnalyticsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class AdminAnalyticsServiceImpl implements AdminAnalyticsService {

    @Autowired
    private AdminAnalyticsRepository adminAnalyticsRepository;

    @Override
    @Transactional(readOnly = true)
    public AdminAnalyticsDTO getCompiledAnalyticsDashboard(String type, Integer year, Integer month, Integer week, String day) {
        AdminAnalyticsDTO dto = adminAnalyticsRepository.fetchFilteredAnalyticsData(type, year, month, week, day);
        dto.setMaxViews(adminAnalyticsRepository.findMaxViewsByCriteria(type, year, month, week, day));
        return dto;
    }

    @Override
    @Transactional(readOnly = true)
    public Long getHighestViewCount(String type, Integer year, Integer month, Integer week, String day) {
        return adminAnalyticsRepository.findMaxViewsByCriteria(type, year, month, week, day);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CheatsheetEntity> getTopViewedCheatsheets(String type, Integer year, Integer month, Integer week, String day) {
        return adminAnalyticsRepository.findTopViewedCheatsheets(type, year, month, week, day);
    }

    @Override
    @Transactional(readOnly = true)
    public List<UserEntity> getUsersByPeriod(String type, Integer year, Integer month, Integer week, String day) {
        List<UserEntity> users = adminAnalyticsRepository.findUsersByPeriod(type, year, month, week, day);
        
       
        System.out.println("DEBUG: Found users count: " + (users != null ? users.size() : "null"));
        
        return users;
    }
}