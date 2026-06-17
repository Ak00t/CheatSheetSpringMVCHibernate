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

import com.hibernate.entity.enums.SharePlatform;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "shares")
public class ShareEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private UserEntity user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cheatsheet_id", nullable = false)
	private CheatsheetEntity cheatsheet;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('FACEBOOK','MESSENGER','TELEGRAM','VIBER','LINK','OTHER')")
	private SharePlatform platform;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
