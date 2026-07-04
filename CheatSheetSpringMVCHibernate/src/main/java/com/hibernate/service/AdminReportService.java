package com.hibernate.service;

import com.hibernate.entity.ReportEntity;
import com.hibernate.entity.UserEntity;
import java.util.List;

public interface AdminReportService {
    List<ReportEntity> getPendingReports();
    void handleReportAction(Long reportId, String actionType, String warningMessage, UserEntity loggedInAdmin);
    
}