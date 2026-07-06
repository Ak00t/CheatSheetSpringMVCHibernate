package com.hibernate.service;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CollectionVisibility;
import com.hibernate.repository.CollectionRepository;

import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 👈 Spring Transaction စစ်စစ်
import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional 
public class CollectionServiceImpl implements CollectionService {

    @Autowired
    private CollectionRepository collectionRepository;
    
    @Autowired 
    private SessionFactory sessionFactory;
    
    @Override
    public CollectionEntity createCollection(Long userId, String name, String visibilityStr) {
        UserEntity user = new UserEntity();
        user.setId(userId);

        CollectionEntity collection = new CollectionEntity();
        collection.setUser(user);
        collection.setName(name);
        
        try {
            if (visibilityStr != null) {
                collection.setVisibility(CollectionVisibility.valueOf(visibilityStr.toUpperCase()));
            }
        } catch (IllegalArgumentException e) {
            collection.setVisibility(CollectionVisibility.PRIVATE); 
        }
        
        collectionRepository.saveCollection(collection);
        return collection;
    }

    @Override
    public List<CollectionEntity> getCollectionsByInterface(Long userId, int page, int pageSize) {
        int offset = (page - 1) * pageSize; 
        List<CollectionEntity> collections = collectionRepository.findByUserId(userId, offset, pageSize);
        if (collections != null) {
            for (CollectionEntity col : collections) {
                if (col.getItems() != null) {
                    Hibernate.initialize(col.getItems()); 
                }
            }
        }
        return collections;
    }

    @Override
    public String addItemToCollection(Long collectionId, Long cheatsheetId) {
        if (collectionRepository.isItemInCollection(collectionId, cheatsheetId)) {
            return "Item already added!";
        }

        CollectionItemEntity item = new CollectionItemEntity();
        item.setCollectionId(collectionId);     
        item.setCheatsheetId(cheatsheetId);     
        item.setCreatedAt(LocalDateTime.now()); 

        collectionRepository.saveCollectionItem(item);
        return "Success";
    }

    @Override
    public void updateCollectionVisibility(Long collectionId, String visibilityStr) {
        try {
            CollectionVisibility visibility = CollectionVisibility.valueOf(visibilityStr.toUpperCase());
            collectionRepository.updateVisibility(collectionId, visibility);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid visibility status!");
        }
    }

    @Override
    @Transactional(readOnly = true)
    public CollectionEntity findById(Long id) {
        CollectionEntity collection = collectionRepository.findById(id);
        if (collection != null && collection.getItems() != null) {
            Hibernate.initialize(collection.getItems());
            if (collection.getUser() != null) {
                Hibernate.initialize(collection.getUser());
            }
        }
        return collection;
    }

    
    @Override
    @Transactional
    public void deleteCollection(Long collectionId) {
        org.hibernate.Session session = sessionFactory.getCurrentSession();
        
        
        String deleteItemsHql = "delete from CollectionItemEntity i where i.collectionId = :collectionId";
        session.createQuery(deleteItemsHql)
               .setParameter("collectionId", collectionId)
               .executeUpdate();
               
        
        CollectionEntity collection = session.get(CollectionEntity.class, collectionId);
        if (collection != null) {
            session.delete(collection);
        }
        
       
        session.flush(); 
    }
    @Override
    public void updateCollectionName(Long collectionId, String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new RuntimeException("Collection name cannot be empty!");
        }
        collectionRepository.updateName(collectionId, name.trim());
    }
}