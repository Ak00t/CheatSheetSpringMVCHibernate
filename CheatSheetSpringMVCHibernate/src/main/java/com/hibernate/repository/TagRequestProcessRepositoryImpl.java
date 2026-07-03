package com.hibernate.repository;

import com.hibernate.entity.TagRequestEntity;
import com.hibernate.entity.enums.TagRequestStatus;
import com.hibernate.repository.TagRequestProcessRepository;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class TagRequestProcessRepositoryImpl implements TagRequestProcessRepository {

    @Autowired private SessionFactory sessionFactory;

    @Override
    public List<TagRequestEntity> findByStatus(TagRequestStatus status) {
        return sessionFactory.getCurrentSession()
                // JOIN FETCH သုံးပြီး data တွေကို တစ်ခါတည်း ဆွဲထုတ်ပါမယ်
                .createQuery("FROM TagRequestEntity t JOIN FETCH t.category JOIN FETCH t.requestedBy WHERE t.status = :status", TagRequestEntity.class)
                .setParameter("status", status)
                .getResultList();
    }

    @Override
    public TagRequestEntity findById(Long id) {
        // ID နဲ့ ရှာတဲ့အခါမှာလည်း JOIN FETCH သုံးထားမှ အဆင်ပြေပါတယ်
        return sessionFactory.getCurrentSession()
                .createQuery("FROM TagRequestEntity t JOIN FETCH t.category JOIN FETCH t.requestedBy WHERE t.id = :id", TagRequestEntity.class)
                .setParameter("id", id)
                .uniqueResult();
    }

    @Override
    public void update(Object entity) {
        sessionFactory.getCurrentSession().update(entity);
    }

    @Override
    public void save(Object entity) {
        sessionFactory.getCurrentSession().save(entity);
    }
}