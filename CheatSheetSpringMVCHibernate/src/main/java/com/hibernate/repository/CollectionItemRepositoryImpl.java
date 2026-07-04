package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.ids.CollectionItemId;

@Repository
public class CollectionItemRepositoryImpl implements CollectionItemRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(CollectionItemEntity item) {
        sessionFactory.getCurrentSession().saveOrUpdate(item);
    }

    @Override
    public void delete(CollectionItemEntity item) {
        sessionFactory.getCurrentSession().delete(item);
    }

    @Override
    public CollectionItemEntity findById(CollectionItemId id) {
        return sessionFactory.getCurrentSession().get(CollectionItemEntity.class, id);
    }
    @Override
    public List<CollectionItemEntity> findByCollectionId(Long collectionId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM CollectionItemEntity WHERE collectionId = :cid", CollectionItemEntity.class)
                .setParameter("cid", collectionId)
                .list();
    }
    
}
