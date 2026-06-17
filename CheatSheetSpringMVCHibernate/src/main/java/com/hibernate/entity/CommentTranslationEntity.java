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

import com.hibernate.entity.enums.TranslatedBy;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "comment_translations")
public class CommentTranslationEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "comment_id", nullable = false)
	private CommentEntity comment;

	@Column(name = "source_language", length = 10)
	private String sourceLanguage;

	@Column(name = "target_language", length = 10)
	private String targetLanguage;

	@Column(name = "translated_text", columnDefinition = "TEXT")
	private String translatedText;

	@Enumerated(EnumType.STRING)
	@Column(name = "translated_by", columnDefinition = "ENUM('AI','USER')")
	private TranslatedBy translatedBy;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
