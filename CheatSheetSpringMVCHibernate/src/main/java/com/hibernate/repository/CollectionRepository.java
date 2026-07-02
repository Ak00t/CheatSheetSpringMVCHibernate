package com.hibernate.repository;



import java.util.List;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.UserEntity;
public interface CollectionRepository {
    void save(CollectionEntity collection);
    void addItem(CollectionItemEntity item);
    List<CollectionEntity> findByUserId(Long userId);
}