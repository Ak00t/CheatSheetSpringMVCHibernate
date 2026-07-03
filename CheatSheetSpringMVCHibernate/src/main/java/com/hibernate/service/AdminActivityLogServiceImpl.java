package com.hibernate.service;

import com.hibernate.entity.AuditLogEntity;
import com.hibernate.repository.AdminActivityLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AdminActivityLogServiceImpl implements AdminActivityLogService {

    @Autowired
    private AdminActivityLogRepository adminActivityLogRepository;

    @Override
    public void log(Integer adminUserId, String action, String tableName, int recordId, String description) {
        adminActivityLogRepository.save(action, tableName, recordId, description, adminUserId);
    }

    @Override
    public List<AuditLogEntity> getAllLogs() {
        return adminActivityLogRepository.findAll();
    }
}