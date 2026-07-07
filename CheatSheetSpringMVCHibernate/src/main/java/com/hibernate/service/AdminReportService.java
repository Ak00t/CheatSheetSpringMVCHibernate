package com.hibernate.service;

import java.util.List;
import java.util.Map;

import com.hibernate.DTO.AdminReportTargetPreviewDTO;
import com.hibernate.entity.ReportEntity;
import com.hibernate.entity.UserEntity;


public interface AdminReportService {
    List<ReportEntity> getPendingReports();
    List<ReportEntity> getReportHistory();
    Map<Long, AdminReportTargetPreviewDTO> getTargetPreviews(List<ReportEntity> reports);
    void handleReportAction(Long reportId, String actionType, String warningMessage, UserEntity loggedInAdmin);
    
}
