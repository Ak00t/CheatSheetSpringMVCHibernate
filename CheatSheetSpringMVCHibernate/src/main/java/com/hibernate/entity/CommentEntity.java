package com.hibernate.entity;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.hibernate.entity.enums.CommentStatus;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "comments")
public class CommentEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "cheatsheet_id", nullable = false)
	private CheatsheetEntity cheatsheet;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", nullable = false)
	private UserEntity user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_comment_id")
	private CommentEntity parentComment;

	@OneToMany(mappedBy = "parentComment", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CommentEntity> replies;

	@Column(columnDefinition = "TEXT", nullable = false)
	private String content;

	@Column(name = "language_code", length = 10)
	private String languageCode;

	@Column(name = "like_count")
	private Integer likeCount = 0;

	@Column(name = "reply_count")
	private Integer replyCount = 0;

	@Column(name = "report_count")
	private Integer reportCount = 0;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('ACTIVE','HIDDEN','DELETED') DEFAULT 'ACTIVE'")
	private CommentStatus status = CommentStatus.ACTIVE;

	@CreationTimestamp
	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;

	@UpdateTimestamp
	@Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	private LocalDateTime updatedAt;

	@OneToMany(mappedBy = "comment", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CommentTranslationEntity> translations;

	@Transient
	public String getRelativeTime() {
		if (this.createdAt == null) {
			return "";
		}

		LocalDateTime now = LocalDateTime.now();
		Duration duration = Duration.between(this.createdAt, now);

		long seconds = duration.getSeconds();
		if (seconds < 60) {
			return seconds <= 0 ? "1s ago" : seconds + "s ago";
		}

		long minutes = duration.toMinutes();
		if (minutes < 60) {
			return minutes + "m ago";
		}

		long hours = duration.toHours();
		if (hours < 24) {
			return hours + "h ago";
		}

		long days = duration.toDays();
		if (days < 7) {
			return days + "d ago";
		}

		long weeks = days / 7;
		if (weeks < 4) {
			return weeks + "w ago";
		}

		long months = days / 30;
		if (months < 12) {
			return months + "mo ago";
		}

		return (months / 12) + "y ago";
	}
}
