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

import com.hibernate.entity.enums.BanStatus;
import com.hibernate.entity.enums.TargetType;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "bans")
public class BanEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private UserEntity user;

	@Enumerated(EnumType.STRING)
	@Column(name = "target_type", columnDefinition = "ENUM('USER','CHEATSHEET','COMMENT','CATEGORY','TAG')")
	private TargetType targetType;

	@Column(name = "target_id")
	private Long targetId;

	@Column(columnDefinition = "TEXT")
	private String reason;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('ACTIVE','LIFTED') DEFAULT 'ACTIVE'")
	private BanStatus status = BanStatus.ACTIVE;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "banned_by")
	private UserEntity bannedBy;

	@Column(name = "banned_at")
	private LocalDateTime bannedAt;

	@Column(name = "lifted_at")
	private LocalDateTime liftedAt;
}
