package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.hibernate.entity.UserEntity;

@Repository
public class AdminProfileRepositoryImpl implements AdminProfileRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public UserEntity findById(Long id) {
        return sessionFactory.getCurrentSession().get(UserEntity.class, id);
    }

    @Override
    public void update(UserEntity user) {
        sessionFactory.getCurrentSession().update(user);
    }
}