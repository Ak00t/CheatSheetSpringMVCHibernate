package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.ReportEntity;
import com.hibernate.DTO.AdminReportTargetPreviewDTO;
import com.hibernate.entity.BanEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.WarningEntity;
import com.hibernate.entity.enums.BanStatus;
import com.hibernate.entity.enums.CommentStatus;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.entity.enums.TargetType;
import com.hibernate.entity.enums.UserStatus;
import com.hibernate.repository.AdminReportRepository;
import com.hibernate.repository.CheatsheetRepository;
import com.hibernate.repository.CommentsRepository;

@Service
@Transactional

public class AdminReportServiceImpl implements AdminReportService {

	private final AdminReportRepository adminReportRepository;
	private final SessionFactory sessionFactory;
	private final CommentsRepository commentRepository;
	private final CheatsheetRepository cheatsheetRepository;

	@Autowired
	public AdminReportServiceImpl(AdminReportRepository adminReportRepository, SessionFactory sessionFactory,
			CommentsRepository commentRepository, CheatsheetRepository cheatsheetRepository) {
		this.commentRepository = commentRepository;
		this.cheatsheetRepository = cheatsheetRepository;
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
	@Transactional(readOnly = true)
	public List<ReportEntity> getReportHistory() {
		return adminReportRepository.findAllReportHistory();
	}

	@Override
	@Transactional(readOnly = true)
	public Map<Long, AdminReportTargetPreviewDTO> getTargetPreviews(List<ReportEntity> reports) {
		Map<Long, AdminReportTargetPreviewDTO> previews = new LinkedHashMap<>();
		if (reports == null) {
			return previews;
		}

		for (ReportEntity report : reports) {
			previews.put(report.getId(), buildTargetPreview(report));
		}
		return previews;
	}

	@Override
	public void handleReportAction(Long reportId, String actionType, String warningMessage, UserEntity loggedInAdmin) {
		ReportEntity report = adminReportRepository.findById(reportId);
		if (report == null || report.getStatus() != ReviewStatus.PENDING) {
			return;
		}

		TargetType target = report.getTargetType();
		Long targetId = report.getTargetId();
		String normalizedAction = actionType == null ? "" : actionType.trim().toUpperCase();
		boolean requiresTargetOwner = "BAN".equals(normalizedAction) || "WARNING".equals(normalizedAction);

		if (requiresTargetOwner && resolveTargetOwnerId(target, targetId) == null) {
			return;
		}

		if ("BAN".equals(normalizedAction)) {
			executeBanLogic(report, target, targetId, loggedInAdmin);
			report.setStatus(ReviewStatus.RESOLVED);
		} else if ("WARNING".equals(normalizedAction)) {
			executeWarningLogic(report, target, targetId, warningMessage, loggedInAdmin);
			report.setStatus(ReviewStatus.REVIEWED);
		} else if ("REJECT".equals(normalizedAction)) {
			report.setStatus(ReviewStatus.REJECTED);
		} else {
			return;
		}

		report.setReviewedBy(loggedInAdmin);
		report.setReviewedAt(LocalDateTime.now());
		adminReportRepository.update(report);
	}

	private void executeBanLogic(ReportEntity report, TargetType targetType, Long targetId, UserEntity loggedInAdmin) {
		Long targetUserId = resolveTargetOwnerId(targetType, targetId);

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

		if (targetUserId == null || hasActiveBan(targetType, targetId)) {
			return;
		}

		UserEntity targetUser = getCurrentSession().get(UserEntity.class, targetUserId);
		if (targetUser == null) {
			return;
		}

		if (targetUser.getStatus() != UserStatus.BANNED) {
			targetUser.setStatus(UserStatus.BANNED);
			getCurrentSession().update(targetUser);
		}

		BanEntity ban = new BanEntity();
		ban.setUser(targetUser);
		ban.setTargetType(targetType);
		ban.setTargetId(targetId);
		ban.setReason(buildActionReason(report, "Ban action issued by admin"));
		ban.setStatus(BanStatus.ACTIVE);
		ban.setBannedBy(loggedInAdmin);
		ban.setBannedAt(LocalDateTime.now());
		getCurrentSession().save(ban);
	}

	private void executeWarningLogic(ReportEntity report, TargetType targetType, Long targetId, String message,
			UserEntity loggedInAdmin) {
		Long userIdToWarn = resolveTargetOwnerId(targetType, targetId);
		if (userIdToWarn == null) {
			return;
		}

		UserEntity warnedUser = getCurrentSession().get(UserEntity.class, userIdToWarn);
		if (warnedUser == null) {
			return;
		}

		WarningEntity warning = new WarningEntity();
		warning.setUser(warnedUser);
		warning.setTargetType(targetType);
		warning.setTargetId(targetId);
		warning.setReasonText(buildActionReason(report, message));
		warning.setWarningCount(getNextWarningCount(userIdToWarn));
		warning.setCreatedBy(loggedInAdmin);
		getCurrentSession().save(warning);

		Long referenceId = targetId;
		if (targetType == TargetType.COMMENT) {
			Long cheatsheetId = commentRepository.getCheatsheetIdByCommentId(targetId);
			if (cheatsheetId != null) {
				referenceId = cheatsheetId;
			}
		}

		getCurrentSession()
				.createNativeQuery(
						"INSERT INTO notifications (user_id, title, message,reference_id, type, created_at,actor_user_id,reference_type) VALUES (:userId, 'Report Warning', :msg, :id,'REPORT', NOW(),:aId,:type)")
					.setParameter("userId", userIdToWarn)
					.setParameter("msg", buildActionReason(report, message))
					.setParameter("id", referenceId)
					.setParameter("aId", loggedInAdmin.getId())
					.setParameter("type", targetType.toString())
					.executeUpdate();
	}

	private Long resolveTargetOwnerId(TargetType targetType, Long targetId) {
		if (targetType == TargetType.USER) {
			UserEntity targetUser = getCurrentSession().get(UserEntity.class, targetId);
			return targetUser == null ? null : targetUser.getId();
		}

		if (targetType == TargetType.CHEATSHEET) {
			return (Long) getCurrentSession()
					.createQuery("SELECT c.user.id FROM CheatsheetEntity c WHERE c.id = :id")
						.setParameter("id", targetId)
						.uniqueResult();
		}

		if (targetType == TargetType.COMMENT) {
			return (Long) getCurrentSession()
					.createQuery("SELECT c.user.id FROM CommentEntity c WHERE c.id = :id")
						.setParameter("id", targetId)
						.uniqueResult();
		}

		return null;
	}

	private boolean hasActiveBan(TargetType targetType, Long targetId) {
		Long count = (Long) getCurrentSession()
				.createQuery(
						"SELECT COUNT(b) FROM BanEntity b WHERE b.targetType = :targetType AND b.targetId = :targetId AND b.status = :status")
					.setParameter("targetType", targetType)
					.setParameter("targetId", targetId)
					.setParameter("status", BanStatus.ACTIVE)
					.uniqueResult();
		return count != null && count > 0;
	}

	private Integer getNextWarningCount(Long userId) {
		Long count = (Long) getCurrentSession()
				.createQuery("SELECT COUNT(w) FROM WarningEntity w WHERE w.user.id = :userId")
					.setParameter("userId", userId)
					.uniqueResult();
		return count == null ? 1 : count.intValue() + 1;
	}

	private String buildActionReason(ReportEntity report, String message) {
		if (message != null && !message.trim().isEmpty()) {
			return message.trim();
		}

		StringBuilder reason = new StringBuilder();
		if (report.getReason() != null) {
			reason.append(report.getReason());
		}
		if (report.getDescription() != null && !report.getDescription().trim().isEmpty()) {
			if (reason.length() > 0) {
				reason.append(" - ");
			}
			reason.append(report.getDescription().trim());
		}
		if (reason.length() == 0) {
			reason.append("Administrative action triggered by report #").append(report.getId());
		}
		return reason.toString();
	}

	private AdminReportTargetPreviewDTO buildTargetPreview(ReportEntity report) {
		AdminReportTargetPreviewDTO preview = new AdminReportTargetPreviewDTO();
		TargetType targetType = report.getTargetType();
		Long targetId = report.getTargetId();

		if (targetType == TargetType.USER) {
			UserEntity targetUser = getCurrentSession().get(UserEntity.class, targetId);
			if (targetUser != null) {
				preview.setUser(targetUser);
				preview.setDisplayLabel(targetUser.getName());
				preview.setDisplaySubtitle(targetUser.getEmail());
				return preview;
			}
		}

		if (targetType == TargetType.COMMENT) {
			CommentEntity comment = commentRepository.selectCommentById(targetId);
			if (comment != null) {
				preview.setComment(comment);
				preview.setDisplayLabel(truncate(comment.getContent(), 90));
				preview.setDisplaySubtitle("Comment by " + comment.getUser().getName());
				return preview;
			}
		}

		if (targetType == TargetType.CHEATSHEET) {
			try {
				CheatsheetEntity cheatsheet = cheatsheetRepository.findDetailsById(targetId);
				if (cheatsheet != null) {
					preview.setCheatsheet(cheatsheet);
					preview.setDisplayLabel(cheatsheet.getTitle());
					preview.setDisplaySubtitle(cheatsheet.getDescription());
					return preview;
				}
			} catch (RuntimeException ex) {
				// Leave the preview in fallback mode if the target cheatsheet has been removed.
			}
		}

		preview.setDisplayLabel(targetType != null ? targetType.name() : "TARGET");
		preview.setDisplaySubtitle("Target preview unavailable");
		return preview;
	}

	private String truncate(String value, int maxLength) {
		if (value == null) {
			return "";
		}
		String trimmed = value.trim();
		if (trimmed.length() <= maxLength) {
			return trimmed;
		}
		return trimmed.substring(0, Math.max(0, maxLength - 3)) + "...";
	}
}
