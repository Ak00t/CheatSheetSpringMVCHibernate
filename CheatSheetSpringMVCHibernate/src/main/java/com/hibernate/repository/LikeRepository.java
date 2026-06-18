package com.hibernate.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hibernate.entity.LikeEntity;
import com.hibernate.entity.ids.LikeId;

public interface  LikeRepository {
	void save(LikeEntity like);
	void delete(LikeId likeId);
	boolean exsits(LikeId likeId);
	public List<LikeEntity> getAlllike();
}
