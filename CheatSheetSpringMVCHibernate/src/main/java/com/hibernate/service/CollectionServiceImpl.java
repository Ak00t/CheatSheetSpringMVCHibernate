package com.hibernate.service;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CollectionVisibility;
import com.hibernate.repository.CollectionRepository;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class CollectionServiceImpl implements CollectionService {

    @Autowired
    private CollectionRepository collectionRepository;

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
        
        // 💡 🛑 [LazyInitializationException ဖြေရှင်းချက်] - JSP မှာ .size() ခေါ်ရင် Error မတက်အောင် 
        // ၎င်းတို့အောက်က Lazy ဖြစ်နေတဲ့ items collection တွေကို Session မပိတ်ခင် ကြိုတင် Initialize လုပ်ပေးခြင်း
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
}