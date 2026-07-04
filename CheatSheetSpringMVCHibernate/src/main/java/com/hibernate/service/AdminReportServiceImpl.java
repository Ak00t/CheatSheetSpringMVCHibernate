package com.hibernate.service;

import com.hibernate.entity.ReportEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.entity.enums.TargetType;
import com.hibernate.repository.AdminReportRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class AdminReportServiceImpl implements AdminReportService {

    private final AdminReportRepository adminReportRepository;
    private final SessionFactory sessionFactory;

    @Autowired
    public AdminReportServiceImpl(AdminReportRepository adminReportRepository, SessionFactory sessionFactory) {
        this.adminReportRepository = adminReportRepository;
        this.sessionFactory = sessionFactory;
    }

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    @Transactional(readOnly = true)
    public List<ReportEntity> getPendingReports() {
        return adminReportRepository.findAllPendingReports();
    }

    @Override
    public void handleReportAction(Long reportId, String actionType, String warningMessage, UserEntity loggedInAdmin) {
        ReportEntity report = adminReportRepository.findById(reportId);
        if (report == null) {
            return;
        }

        TargetType target = report.getTargetType();
        Long targetId = report.getTargetId();

        if ("BAN".equalsIgnoreCase(actionType)) {
            executeBanLogic(target, targetId);
            report.setStatus(ReviewStatus.RESOLVED);
        } else if ("WARNING".equalsIgnoreCase(actionType)) {
            executeWarningLogic(target, targetId, warningMessage);
            report.setStatus(ReviewStatus.REVIEWED);
        } else if ("REJECT".equalsIgnoreCase(actionType)) {
            report.setStatus(ReviewStatus.REJECTED);
        }

        report.setReviewedBy(loggedInAdmin);
        report.setReviewedAt(LocalDateTime.now());
        adminReportRepository.update(report);
    }

    private void executeBanLogic(TargetType targetType, Long targetId) {
        if (targetType == TargetType.USER) {
            getCurrentSession()
                .createQuery("UPDATE UserEntity u SET u.isBanned = true WHERE u.id = :id")
                .setParameter("id", targetId)
                .executeUpdate();
        } else if (targetType == TargetType.CHEATSHEET) {
            getCurrentSession()
                .createQuery("UPDATE CheatsheetEntity c SET c.status = 'BANNED' WHERE c.id = :id")
                .setParameter("id", targetId)
                .executeUpdate();
        } else if (targetType == TargetType.COMMENT) {
            getCurrentSession()
                .createQuery("DELETE FROM CommentEntity c WHERE c.id = :id")
                .setParameter("id", targetId)
                .executeUpdate();
        }
    }

    private void executeWarningLogic(TargetType targetType, Long targetId, String message) {
        Long userIdToWarn = targetId;
        
        if (targetType == TargetType.CHEATSHEET) {
            userIdToWarn = (Long) getCurrentSession()
                .createQuery("SELECT c.user.id FROM CheatsheetEntity c WHERE c.id = :id")
                .setParameter("id", targetId)
                .uniqueResult();
        } else if (targetType == TargetType.COMMENT) {
            userIdToWarn = (Long) getCurrentSession()
                .createQuery("SELECT c.user.id FROM CommentEntity c WHERE c.id = :id")
                .setParameter("id", targetId)
                .uniqueResult();
        }

        if (userIdToWarn != null) {
            getCurrentSession().createNativeQuery(
                "INSERT INTO notifications (user_id, title, message, type, created_at) VALUES (:userId, 'Report Warning', :msg, 'WARN', NOW())")
                .setParameter("userId", userIdToWarn)
                .setParameter("msg", message)
                .executeUpdate();
        }
    }
}