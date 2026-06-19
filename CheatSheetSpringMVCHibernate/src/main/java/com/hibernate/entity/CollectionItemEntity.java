package com.hibernate.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.hibernate.entity.ids.CollectionItemId;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "collection_items")
@IdClass(CollectionItemId.class)
public class CollectionItemEntity {

	@Id
	@Column(name = "collection_id")
	private Long collectionId;

	@Id
	@Column(name = "cheatsheet_id")
	private Long cheatsheetId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "collection_id", insertable = false, updatable = false)
	private CollectionEntity collection;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cheatsheet_id", insertable = false, updatable = false)
	private CheatsheetEntity cheatsheet;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
