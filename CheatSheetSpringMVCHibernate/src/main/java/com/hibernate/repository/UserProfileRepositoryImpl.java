package com.hibernate.repository;


import org.hibernate.Session;
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

    @Override
    public UserEntity findByUsername(String username) {
        // Session ကိုဖွင့်ပြီး Query ထုတ်ခြင်း
        Session session = sessionFactory.getCurrentSession();
        try {
            // HQL (Hibernate Query Language) ကိုသုံးခြင်း
            String hql = "FROM UserEntity WHERE email = :username";
            return (UserEntity) session.createQuery(hql)
                                       .setParameter("username", username)
                                       .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }}