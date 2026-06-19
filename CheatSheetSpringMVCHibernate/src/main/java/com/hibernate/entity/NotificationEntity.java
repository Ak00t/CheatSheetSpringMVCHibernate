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

import com.hibernate.entity.enums.ReferenceType;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "notifications")
public class NotificationEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private UserEntity user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "actor_user_id")
	private UserEntity actorUser;

	@Column(columnDefinition = "ENUM('LIKE','COMMENT','FOLLOW','RATING','REPORT','SYSTEM')", nullable = false)
	private String type;

	@Column(length = 200, nullable = false)
	private String title;

	@Column(columnDefinition = "TEXT")
	private String message;

	@Enumerated(EnumType.STRING)
	@Column(name = "reference_type", columnDefinition = "ENUM('USER','CHEATSHEET','COMMENT','CATEGORY','TAG','COLLECTION','REPORT')")
	private ReferenceType referenceType;

	@Column(name = "reference_id")
	private Long referenceId;

	@Column(name = "is_read", columnDefinition = "TINYINT(1) DEFAULT 0")
	private Boolean isRead = false;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
