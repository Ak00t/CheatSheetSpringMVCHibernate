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
@Table(name = "user_activity_logs")
public class UserActivityLogEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private UserEntity user;

	@Column(name = "activity_type", length = 100, nullable = false)
	private String activityType;

	@Enumerated(EnumType.STRING)
	@Column(name = "reference_type", columnDefinition = "ENUM('USER','CHEATSHEET','COMMENT','CATEGORY','TAG','COLLECTION','REPORT')")
	private ReferenceType referenceType;

	@Column(name = "reference_id")
	private Long referenceId;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
