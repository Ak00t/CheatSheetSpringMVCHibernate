package com.hibernate.service;

import java.time.LocalDateTime;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.repository.DashboardRepository;
import com.hibernate.service.DashboardService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DashboardServiceImpl implements DashboardService {

    private final DashboardRepository dashboardRepository;

    @Override
    public long getTotalUsersCount() {
        return dashboardRepository.getTotalUsersCount();
    }

    @Override
    public long getTotalCheatsheetsCount() {
        return dashboardRepository.getTotalCheatsheetsCount();
    }

    @Override
    public long getPendingReportsCount() {
        return dashboardRepository.getPendingReportsCount();
    }

    @Override
    public long getBannedContentsCount() {
        return dashboardRepository.getBannedContentsCount();
    }

    @Override
    public long getTodayNewUsersCount(LocalDateTime startOfDay) {
        return dashboardRepository.getTodayNewUsersCount(startOfDay);
    }

    @Override
    public long getTodayNewCheatsheetsCount(LocalDateTime startOfDay) {
        return dashboardRepository.getTodayNewCheatsheetsCount(startOfDay);
    }

    @Override
    public long getTodayNewReportsCount(LocalDateTime startOfDay) {
        return dashboardRepository.getTodayNewReportsCount(startOfDay);
    }
}