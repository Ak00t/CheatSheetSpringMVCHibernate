package com.hibernate.entity;

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

import com.hibernate.entity.enums.CategoryStatus;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "categories")
public class CategoryEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id")
	private CategoryEntity parent;

	@OneToMany(mappedBy = "parent")
	private List<CategoryEntity> children;

	@Column(length = 100, nullable = false)
	private String name;

	@Column(length = 120, nullable = false, unique = true)
	private String slug;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'")
	private CategoryStatus status = CategoryStatus.ACTIVE;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;

	@OneToMany(mappedBy = "category")
	private List<TagEntity> tags;

	@OneToMany(mappedBy = "category")
	private List<CheatsheetEntity> cheatsheets;

	@OneToMany(mappedBy = "category", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<UserFollowedCategoryEntity> followedByUsers;
}
