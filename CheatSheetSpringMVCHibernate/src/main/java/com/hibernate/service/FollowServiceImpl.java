package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserFollowEntity;
import com.hibernate.repository.FollowRepository;

@Service
@Transactional 
public class FollowServiceImpl implements FollowService {
    @Autowired private FollowRepository followRepo;
    @Autowired private SessionFactory sessionFactory;
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
    
    
    @Override
    public List<?> findFollowersData(Long currentUserId) {
        return followRepo.getFollowersData(currentUserId);
    }

    @Override
    public List<?> findFollowingData(Long currentUserId) {
        return followRepo.getFollowingData(currentUserId);
    }
    
    @Override
    public long getFollowersCount(Long userId) {
       
        String sql = "SELECT COUNT(*) FROM user_follows WHERE following_id = :userId";
        
        java.math.BigInteger count = (java.math.BigInteger) sessionFactory.getCurrentSession()
                .createNativeQuery(sql)
                .setParameter("userId", userId)
                .getSingleResult();
                
        return count.longValue();
    }

    @Override
    public long getFollowingCount(Long userId) {
        String sql = "SELECT COUNT(*) FROM user_follows WHERE follower_id = :userId";
        
        java.math.BigInteger count = (java.math.BigInteger) sessionFactory.getCurrentSession()
                .createNativeQuery(sql)
                .setParameter("userId", userId)
                .getSingleResult();
                
        return count.longValue();
    }

}