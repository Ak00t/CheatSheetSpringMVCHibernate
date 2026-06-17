package com.hibernate.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.hibernate.entity.enums.ReportReason;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.entity.enums.TargetType;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "reports")
public class ReportEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "reporter_user_id", nullable = false)
	private UserEntity reporterUser;

	@Enumerated(EnumType.STRING)
	@Column(name = "target_type", columnDefinition = "ENUM('USER','CHEATSHEET','COMMENT','CATEGORY','TAG')", nullable = false)
	private TargetType targetType;

	@Column(name = "target_id", nullable = false)
	private Long targetId;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('SPAM','ABUSE','COPYRIGHT','INAPPROPRIATE','OTHER')", nullable = false)
	private ReportReason reason;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('PENDING','REVIEWED','REJECTED','RESOLVED') DEFAULT 'PENDING'")
	private ReviewStatus status = ReviewStatus.PENDING;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "reviewed_by")
	private UserEntity reviewedBy;

	@Column(name = "reviewed_at")
	private LocalDateTime reviewedAt;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
