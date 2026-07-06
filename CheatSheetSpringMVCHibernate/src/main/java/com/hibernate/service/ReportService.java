package com.hibernate.service;

public interface ReportService {
    void saveReport(Long userId, Long targetId, String reason, String description);
    boolean isContentReportedByUser(Long userId, Long targetId);
}
