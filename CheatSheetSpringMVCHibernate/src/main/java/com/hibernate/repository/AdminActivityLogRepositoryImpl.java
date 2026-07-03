package com.hibernate.repository;

import com.hibernate.entity.AuditLogEntity;
import com.hibernate.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class AdminActivityLogRepositoryImpl implements AdminActivityLogRepository {

    @Autowired
    private DataSource dataSource;

    @Override
    public void save(String action, String tableName, int recordId, String description, Integer adminUserId) {
        String sql = "INSERT INTO audit_logs (action, created_at, description, record_id, table_name, admin_user_id) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, action);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, description);
            ps.setInt(4, recordId);
            ps.setString(5, tableName);
            
            if (adminUserId == null || adminUserId <= 0) {
                ps.setNull(6, java.sql.Types.INTEGER);
            } else {
                ps.setInt(6, adminUserId);
            }
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            throw new RuntimeException("Database error in save log: " + e.getMessage(), e);
        }
    }

    @Override
    public List<AuditLogEntity> findAll() {
        List<AuditLogEntity> logs = new ArrayList<>();
        String sql = "SELECT a.*, u.name FROM audit_logs a LEFT JOIN users u ON a.admin_user_id = u.id ORDER BY a.created_at DESC";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                AuditLogEntity log = new AuditLogEntity();
                log.setId(rs.getLong("id"));
                log.setAction(rs.getString("action"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    log.setCreatedAt(timestamp.toLocalDateTime());
                }
                
                log.setDescription(rs.getString("description"));
                log.setRecordId(rs.getLong("record_id"));
                log.setTableName(rs.getString("table_name"));
                
                int adminUserId = rs.getInt("admin_user_id");
                if (!rs.wasNull()) {
                    UserEntity adminUser = new UserEntity();
                    adminUser.setId((long) adminUserId);
                    adminUser.setName(rs.getString("name"));
                    log.setAdminUser(adminUser);
                }
                
                logs.add(log);
            }
            
        } catch (Exception e) {
            throw new RuntimeException("Database error in find all logs: " + e.getMessage(), e);
        }
        return logs;
    }
}