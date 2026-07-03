package com.hibernate.service;

import java.time.LocalDateTime;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.LikeEntity;
import com.hibernate.repository.LikeRepository;



@Service
@Transactional
public class LikeServiceImpl implements LikeService {
    @Autowired
    private LikeRepository likeRepository;
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void toggleLike(Long userId, Long cheatsheetId) {
        if (likeRepository.exists(userId, cheatsheetId)) {
            likeRepository.delete(userId, cheatsheetId);
        } else {
            LikeEntity like = new LikeEntity();
            like.setUserId(userId);
            like.setCheatsheetId(cheatsheetId);
            like.setCreatedAt(LocalDateTime.now());
            likeRepository.save(like);
        }
        // Auto update count in database
        CheatsheetEntity sheet = sessionFactory.getCurrentSession().get(CheatsheetEntity.class, cheatsheetId);
        sheet.setLikeCount(likeRepository.countLikes(cheatsheetId));
    }

    @Override
    public boolean isLiked(Long userId, Long cheatsheetId) {
        return likeRepository.exists(userId, cheatsheetId);
    }

    @Override
    public Integer countLikes(Long cheatsheetId) {
        return likeRepository.countLikes(cheatsheetId);
    }
}