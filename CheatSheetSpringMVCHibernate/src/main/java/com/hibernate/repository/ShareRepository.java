package com.hibernate.repository;

import com.hibernate.entity.ShareEntity;
import java.util.List;

public interface ShareRepository {
    void save(ShareEntity share);
    List<ShareEntity> findByUserId(Long userId);
    ShareEntity findById(Long id);
    void delete(ShareEntity share);
}