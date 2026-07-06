package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.ReportEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CommentStatus;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.entity.enums.TargetType;
import com.hibernate.entity.enums.UserStatus;
import com.hibernate.repository.AdminReportRepository;
import com.hibernate.repository.CommentsRepository;

@Service
@Transactional

public class AdminReportServiceImpl implements AdminReportService {

	private final AdminReportRepository adminReportRepository;
	private final SessionFactory sessionFactory;
	private final CommentsRepository commentRepository;

	@Autowired
	public AdminReportServiceImpl(AdminReportRepository adminReportRepository, SessionFactory sessionFactory,
			CommentsRepository commentRepository) {
		this.commentRepository = commentRepository;
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
			executeWarningLogic(target, targetId, warningMessage, loggedInAdmin.getId());
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
					.createQuery("UPDATE UserEntity u SET u.status = :status WHERE u.id = :id")
						.setParameter("status", UserStatus.BANNED)
						.setParameter("id", targetId)
						.executeUpdate();
		} else if (targetType == TargetType.CHEATSHEET) {
			getCurrentSession()
					.createQuery("UPDATE CheatsheetEntity c SET c.status = :status WHERE c.id = :id")
						.setParameter("status", ContentStatus.REPORTED)
						.setParameter("id", targetId)
						.executeUpdate();
		} else if (targetType == TargetType.COMMENT) {
			getCurrentSession()
					.createQuery("UPDATE CommentEntity c SET c.status=:status WHERE c.id = :id")
						.setParameter("status", CommentStatus.DELETED)
						.setParameter("id", targetId)
						.executeUpdate();
		}
	}

	private void executeWarningLogic(TargetType targetType, Long targetId, String message, Long adminId) {
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
			targetId = commentRepository.getCheatsheetIdByCommentId(targetId);
		}

		if (userIdToWarn != null) {
			getCurrentSession()
					.createNativeQuery(
							"INSERT INTO notifications (user_id, title, message,reference_id, type, created_at,actor_user_id,reference_type) VALUES (:userId, 'Report Warning', :msg, :id,'REPORT', NOW(),:aId,:type)")
						.setParameter("userId", userIdToWarn)
						.setParameter("msg", message)
						.setParameter("id", targetId)
						.setParameter("aId", adminId)
						.setParameter("type", targetType.toString())
						.executeUpdate();
		}
	}
}