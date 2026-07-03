package com.hibernate.repository;

import com.hibernate.entity.UserEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class UserListRepositoryImpl implements UserListRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<UserEntity> findUsersByDateRange(LocalDateTime start, LocalDateTime end) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM UserEntity u WHERE u.createdAt BETWEEN :start AND :end", UserEntity.class)
                .setParameter("start", start)
                .setParameter("end", end)
                .list();
    }
}