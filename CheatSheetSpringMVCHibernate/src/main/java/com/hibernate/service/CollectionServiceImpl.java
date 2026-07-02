package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CollectionVisibility;
import com.hibernate.entity.ids.CollectionItemId;
import com.hibernate.repository.CollectionItemRepository;
import com.hibernate.repository.CollectionRepository;

@Service
@Transactional
public class CollectionServiceImpl implements CollectionService {

    @Autowired
    private CollectionRepository collectionRepository;

 // CollectionServiceImpl.java အတွင်း
    @Override
    public void createNewPlaylist(Long userId, String name) {
        CollectionEntity collection = new CollectionEntity();
        collection.setName(name);
        
        // အရေးကြီး: User ကို ဒီနေရာမှာ ရှာပြီး set လုပ်ပေးပါ
        UserEntity user = new UserEntity(); 
        user.setId(userId); // ဒါမှမဟုတ် repository ကနေ findById နဲ့ ရှာပါ
        collection.setUser(user); 
        
        // Visibility ကိုလည်း default တစ်ခုခု သတ်မှတ်ပေးပါ
        collection.setVisibility(CollectionVisibility.PRIVATE);
        
        collectionRepository.save(collection);
    }

    @Override
    public void addToPlaylist(Long collectionId, Long cheatsheetId) {
        CollectionItemEntity item = new CollectionItemEntity();
        item.setCollectionId(collectionId);
        item.setCheatsheetId(cheatsheetId);
        item.setCreatedAt(LocalDateTime.now());
        collectionRepository.addItem(item);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CollectionEntity> getCollections(Long userId) {
        return collectionRepository.findByUserId(userId);
    }
}