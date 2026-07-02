package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.UserFollowEntity;
import com.hibernate.entity.ids.UserFollowId;

@Repository
public class UserFollowRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public boolean exists(Long followerId, Long followingId) {
        try (Session session = sessionFactory.openSession()) {
            UserFollowId id = new UserFollowId(followerId, followingId);
            return session.get(UserFollowEntity.class, id) != null;
        }
    }

    public void save(UserFollowEntity follow) {
        try (Session session = sessionFactory.openSession()) {
            Transaction tx = session.beginTransaction();
            session.save(follow);
            tx.commit();
        }
    }

    public void delete(Long followerId, Long followingId) {
        try (Session session = sessionFactory.openSession()) {
            Transaction tx = session.beginTransaction();
            UserFollowId id = new UserFollowId(followerId, followingId);
            UserFollowEntity follow = session.load(UserFollowEntity.class, id);
            session.delete(follow);
            tx.commit();
        }
    }
}