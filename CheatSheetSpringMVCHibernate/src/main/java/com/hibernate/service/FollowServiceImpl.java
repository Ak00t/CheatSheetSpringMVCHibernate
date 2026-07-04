package com.hibernate.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserFollowEntity;
import com.hibernate.repository.FollowRepository;

@Service
@Transactional 
public class FollowServiceImpl implements FollowService {
    @Autowired private FollowRepository followRepo;

    @Override
    public void toggleFollow(Long followerId, Long followingId) {
        UserFollowEntity exist = followRepo.findFollow(followerId, followingId);
        if (exist != null) followRepo.remove(exist);
        else {
            UserFollowEntity f = new UserFollowEntity();
            f.setFollowerId(followerId); f.setFollowingId(followingId); f.setCreatedAt(LocalDateTime.now());
            followRepo.save(f);
        }
    }
    @Override public boolean isFollowing(Long fid, Long tid) { return followRepo.findFollow(fid, tid) != null; }
}