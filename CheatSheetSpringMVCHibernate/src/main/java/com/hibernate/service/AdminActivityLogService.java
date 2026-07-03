package com.hibernate.service;

import com.hibernate.entity.AuditLogEntity;
import java.util.List;

public interface AdminActivityLogService {
    void log(Integer adminUserId, String action, String tableName, int recordId, String description);
    List<AuditLogEntity> getAllLogs();
}