package com.hibernate.service;

import com.hibernate.entity.ShareEntity;
import java.util.List;

public interface ShareService {
    void saveShareLog(Long userId, Long cheatsheetId, String platformStr);
    List<ShareEntity> findSharesByUserId(Long userId);
    boolean deleteLogIfOwner(Long logId, Long userId);
	
}