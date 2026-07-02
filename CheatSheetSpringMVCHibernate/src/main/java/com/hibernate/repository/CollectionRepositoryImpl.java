package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.UserEntity;

@Repository
public class CollectionRepositoryImpl implements CollectionRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(CollectionEntity collection) {
        try {
            sessionFactory.getCurrentSession().save(collection);
            // Error တက်မတက် သိရအောင် Log ထုတ်ကြည့်ပါ
            System.out.println("Collection saved successfully: " + collection.getName());
        } catch (Exception e) {
            e.printStackTrace(); // ဒီနေရာမှာ ဘာကြောင့်မဝင်တာလဲဆိုတဲ့ error ကို console မှာ ပြပါလိမ့်မယ်
        }
    }

    @Override
    public void addItem(CollectionItemEntity item) {
        sessionFactory.getCurrentSession().save(item);
    }

    @Override
    public List<CollectionEntity> findByUserId(Long userId) {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM CollectionEntity c WHERE c.user.id = :userId", CollectionEntity.class)
            .setParameter("userId", userId)
            .getResultList();
    }
}