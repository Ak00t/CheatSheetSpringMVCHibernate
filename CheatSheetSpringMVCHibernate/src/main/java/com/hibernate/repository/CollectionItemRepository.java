package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.ids.CollectionItemId;

public interface CollectionItemRepository {
    void save(CollectionItemEntity item);
    void delete(CollectionItemEntity item);
    CollectionItemEntity findById(CollectionItemId id);
	List<CollectionItemEntity> findByCollectionId(Long collectionId);
}