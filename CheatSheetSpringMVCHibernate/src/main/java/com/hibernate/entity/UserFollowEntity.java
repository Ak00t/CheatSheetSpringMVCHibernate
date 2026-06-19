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

import com.hibernate.entity.ids.UserFollowId;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "user_follows")
@IdClass(UserFollowId.class)
public class UserFollowEntity {

	@Id
	@Column(name = "follower_id")
	private Long followerId;

	@Id
	@Column(name = "following_id")
	private Long followingId;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "follower_id", insertable = false, updatable = false)
	private UserEntity follower;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "following_id", insertable = false, updatable = false)
	private UserEntity following;

	@Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime createdAt;
}
