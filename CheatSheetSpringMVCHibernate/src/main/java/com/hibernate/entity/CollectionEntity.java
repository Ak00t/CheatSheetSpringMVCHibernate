package com.hibernate.entity;

import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore; // 💡 ဒီကောင်ကို Import လုပ်ပါ
import com.hibernate.entity.enums.CollectionVisibility;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "collections")
public class CollectionEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	@JsonIgnore // 💡 ဖြည့်ရန်: Playlist ယူတဲ့အခါ User Object ကြီး တစ်ခါတည်း ပါမလာအောင် တားတာ
	private UserEntity user;

	@Column(length = 150, nullable = false)
	private String name;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Enumerated(EnumType.STRING)
	@Column(columnDefinition = "ENUM('PUBLIC','PRIVATE','UNLISTED') DEFAULT 'PRIVATE'")
	private CollectionVisibility visibility = CollectionVisibility.PRIVATE;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;

	@OneToMany(mappedBy = "collection", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnore // 💡 ဖြည့်ရန်: JSON ပြောင်းတဲ့အခါ Items တွေကို လိုက်မပတ်အောင် ကာကွယ်တာ (Infinite Loop Trigger)
	private List<CollectionItemEntity> items;
}