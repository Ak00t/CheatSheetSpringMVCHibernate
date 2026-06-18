package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.LikeEntity;

public interface LikeService {
	void toggleLike(Long userId,Long cheatsheetId);
	boolean isLiked(Long userId, Long cheatsheetId);
	public List<LikeEntity> getAlllike();
}
