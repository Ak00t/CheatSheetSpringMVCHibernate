package com.hibernate.entity;

import java.math.BigDecimal;
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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.PublishStatus;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "cheatsheets")
public class CheatsheetEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private UserEntity user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "category_id")
	private CategoryEntity category;

	@Column(length = 200, nullable = false)
	private String title;

	@Column(length = 220, nullable = false, unique = true)
	private String slug;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('PUBLIC','PRIVATE','UNLISTED') DEFAULT 'PUBLIC'")
	private CheatsheetVisibility visibility = CheatsheetVisibility.PUBLIC;

	@Enumerated(EnumType.STRING)
	@Column(name = "publish_status", columnDefinition = "ENUM('DRAFT','PUBLISHED','ARCHIVED') DEFAULT 'DRAFT'")
	private PublishStatus publishStatus = PublishStatus.DRAFT;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('ACTIVE','HIDDEN','DELETED','REPORTED') DEFAULT 'ACTIVE'")
	private ContentStatus status = ContentStatus.ACTIVE;

	@Column(name = "theme_color", length = 30)
	private String themeColor;

	@Column(name = "view_count")
	private Integer viewCount = 0;

	@Column(name = "like_count")
	private Integer likeCount = 0;

	@Column(name = "bookmark_count")
	private Integer bookmarkCount = 0;

	@Column(name = "comment_count")
	private Integer commentCount = 0;

	@Column(name = "share_count")
	private Integer shareCount = 0;

	@Column(name = "rating_avg", precision = 3, scale = 2)
	private BigDecimal ratingAvg = BigDecimal.ZERO;

	@Column(name = "report_count")
	private Integer reportCount = 0;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;

	@Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	private LocalDateTime updatedAt;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CheatsheetSectionEntity> sections;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CheatsheetMediaEntity> mediaList;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CheatsheetNoteEntity> notes;

	@ManyToMany
	@JoinTable(name = "cheatsheet_tags", joinColumns = @JoinColumn(name = "cheatsheet_id"), inverseJoinColumns = @JoinColumn(name = "tag_id"))
	private List<TagEntity> tags;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<BookmarkEntity> bookmarks;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<LikeEntity> likes;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL)
	private List<ShareEntity> shares;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<RatingEntity> ratings;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CommentEntity> comments;

	@OneToMany(mappedBy = "cheatsheet", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CollectionItemEntity> collectionItems;
}
