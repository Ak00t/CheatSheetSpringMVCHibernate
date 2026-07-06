package com.hibernate.service;

import com.hibernate.entity.CollectionEntity;
import java.util.List;

public interface CollectionService {
    CollectionEntity createCollection(Long userId, String name, String visibilityStr);
    
    List<CollectionEntity> getCollectionsByInterface(Long userId, int page, int pageSize);
    
    String addItemToCollection(Long collectionId, Long cheatsheetId);
    
    void updateCollectionVisibility(Long collectionId, String visibilityStr);
    
    CollectionEntity findById(Long id);
    void deleteCollection(Long collectionId);
    void updateCollectionName(Long collectionId, String name);
}