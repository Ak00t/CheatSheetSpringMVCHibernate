package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.UserEntity;

public interface CollectionService {
    void createNewPlaylist(Long userId, String name);
    void addToPlaylist(Long collectionId, Long cheatsheetId);
    List<CollectionEntity> getCollections(Long userId);
}