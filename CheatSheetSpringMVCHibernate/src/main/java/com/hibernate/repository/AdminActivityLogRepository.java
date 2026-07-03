package com.hibernate.repository;

import com.hibernate.entity.AuditLogEntity;
import java.util.List;

public interface AdminActivityLogRepository {
    void save(String action, String tableName, int recordId, String description, Integer adminUserId);
    List<AuditLogEntity> findAll();
}