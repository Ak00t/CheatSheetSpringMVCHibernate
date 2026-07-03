package com.hibernate.service;

import java.time.LocalDateTime;

public interface DashboardService {
    public long getTotalUsersCount();
    public long getTotalCheatsheetsCount();
    public long getPendingReportsCount();
    public long getBannedContentsCount();
    public long getTodayNewUsersCount(LocalDateTime startOfDay);
    public long getTodayNewCheatsheetsCount(LocalDateTime startOfDay);
    public long getTodayNewReportsCount(LocalDateTime startOfDay);
}