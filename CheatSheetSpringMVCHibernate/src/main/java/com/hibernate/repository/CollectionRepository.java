package com.hibernate.repository;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.enums.CollectionVisibility;

import java.util.List;

public interface CollectionRepository {
  
    void saveCollection(CollectionEntity collection);
    void saveCollectionItem(CollectionItemEntity item);
    List<CollectionEntity> findByUserId(Long userId, int offset, int limit);
    CollectionEntity findById(Long id);
    boolean isItemInCollection(Long collectionId, Long cheatsheetId);
    void updateVisibility(Long collectionId, CollectionVisibility visibility);
    void updateName(Long collectionId, String name);
}