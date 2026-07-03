package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.LikeEntity;
import com.hibernate.entity.ids.LikeId;

@Repository
public class LikeRepositoryImpl implements LikeRepository {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(LikeEntity like) {
        sessionFactory.getCurrentSession().save(like);
    }

    @Override
    public void delete(Long userId, Long cheatsheetId) {
        Session session = sessionFactory.getCurrentSession();
        LikeId id = new LikeId(userId, cheatsheetId);
        LikeEntity like = session.get(LikeEntity.class, id);
        if (like != null) session.delete(like);
    }

    @Override
    public boolean exists(Long userId, Long cheatsheetId) {
        return sessionFactory.getCurrentSession().get(LikeEntity.class, new LikeId(userId, cheatsheetId)) != null;
    }

    @Override
    public Integer countLikes(Long cheatsheetId) {
        String hql = "SELECT COUNT(l) FROM LikeEntity l WHERE l.cheatsheetId = :cid";
        Long count = (Long) sessionFactory.getCurrentSession().createQuery(hql)
                .setParameter("cid", cheatsheetId).uniqueResult();
        return count != null ? count.intValue() : 0;
    }
}