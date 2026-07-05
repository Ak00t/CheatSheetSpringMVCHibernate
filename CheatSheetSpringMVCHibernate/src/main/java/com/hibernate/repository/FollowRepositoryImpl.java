package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.UserFollowEntity;

@Repository 
public class FollowRepositoryImpl implements FollowRepository {
    @Autowired private SessionFactory sessionFactory;

    @Override
    public UserFollowEntity findFollow(Long followerId, Long followingId) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM UserFollowEntity WHERE followerId = :fid AND followingId = :tid", UserFollowEntity.class)
            .setParameter("fid", followerId).setParameter("tid", followingId).uniqueResult();
    }
    @Override public void save(UserFollowEntity follow) { sessionFactory.getCurrentSession().save(follow); }
    
    @Override public void remove(UserFollowEntity follow) { sessionFactory.getCurrentSession().delete(follow); 
    }
    @Override
    public List<?> getFollowersData(Long currentUserId) {
        return sessionFactory.getCurrentSession()
            .createQuery("SELECT new map(f.follower.id as id, f.follower.name as name, f.follower.email as email, f.follower.profileImg as profileImg) " +
                         "FROM UserFollowEntity f " +
                         "WHERE f.followingId = :myId", Object.class)
            .setParameter("myId", currentUserId)
            .getResultList();
    }

    @Override
    public List<?> getFollowingData(Long currentUserId) {
        return sessionFactory.getCurrentSession()
            .createQuery("SELECT new map(f.following.id as id, f.following.name as name, f.following.email as email, f.following.profileImg as profileImg) " +
                         "FROM UserFollowEntity f " +
                         "WHERE f.followerId = :myId", Object.class)
            .setParameter("myId", currentUserId)
            .getResultList();
    }
}
