package com.hibernate.repository;


import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserEntity;
@Repository
@Transactional
public class UserProfileRepositoryImpl implements UserProfileRepository {
    
    @Autowired
    private SessionFactory sessionFactory;
    @Autowired
    private UserProfileRepository userRepository;
    @Override
    public UserEntity findById(Long id) {
        return sessionFactory.getCurrentSession().get(UserEntity.class, id);
    }

    @Override
    public void updateProfile(UserEntity user) {
        sessionFactory.getCurrentSession().update(user);
    }
}