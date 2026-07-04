package com.hibernate.repository;

import com.hibernate.entity.ReportEntity;
import java.util.List;

public interface AdminReportRepository {
    List<ReportEntity> findAllPendingReports();
    ReportEntity findById(Long id);
    void update(ReportEntity report);
}