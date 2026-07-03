package com.hibernate.repository;

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
    @Override public void remove(UserFollowEntity follow) { sessionFactory.getCurrentSession().delete(follow); }
}
