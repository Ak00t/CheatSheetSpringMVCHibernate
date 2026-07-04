package com.hibernate.service;

import com.hibernate.entity.CollectionEntity;
import java.util.List;

public interface CollectionService {
    // 💡 🛑 createPlaylist အစား createCollection သို့ ပြောင်းလဲပါသည်
    CollectionEntity createCollection(Long userId, String name, String visibilityStr);
    
    // 💡 🛑 getPlaylistsByInterface အစား getCollectionsByInterface သို့ ပြောင်းလဲပါသည်
    List<CollectionEntity> getCollectionsByInterface(Long userId, int page, int pageSize);
    
    // 💡 🛑 addItemToPlaylist အစား addItemToCollection သို့ ပြောင်းလဲပါသည်
    String addItemToCollection(Long collectionId, Long cheatsheetId);
    
    // 💡 🛑 updatePlaylistVisibility အစား updateCollectionVisibility သို့ ပြောင်းလဲပါသည်
    void updateCollectionVisibility(Long collectionId, String visibilityStr);
    
    CollectionEntity findById(Long id);
}