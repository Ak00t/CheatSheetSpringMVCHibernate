package com.hibernate.repository;

import com.hibernate.entity.ReportEntity;
import java.util.List;

public interface AdminReportRepository {
    List<ReportEntity> findAllPendingReports();
    List<ReportEntity> findAllReportHistory();
    ReportEntity findById(Long id);
    void update(ReportEntity report);
}
