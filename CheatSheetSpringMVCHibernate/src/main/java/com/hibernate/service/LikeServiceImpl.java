package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.LikeEntity;
import com.hibernate.entity.ids.LikeId;
import com.hibernate.repository.LikeRepository;

@Service
@Transactional
public class LikeServiceImpl implements LikeService{
	 
	
	@Autowired
	private LikeRepository likeRepo;
	
	@Override
	public void toggleLike(Long userId, Long cheatsheetId) {
		LikeId likeid = new LikeId(userId,cheatsheetId);
		if(likeRepo.exsits(likeid)) {
			likeRepo.delete(likeid);
		}else {
			LikeEntity like = new LikeEntity();
			like.setUserId(userId);
			like.setCheatsheetId(cheatsheetId);
			like.setCreatedAt(LocalDateTime.now());
			likeRepo.save(like);
		}
	}

	@Override
	@Transactional(readOnly = true)
	public boolean isLiked(Long userId, Long cheatsheetId) {
		
		return likeRepo.exsits(new LikeId(userId, cheatsheetId));
	}

	@Override
	public List<LikeEntity> getAlllike() {
		
		return likeRepo.getAlllike();
	}

}
