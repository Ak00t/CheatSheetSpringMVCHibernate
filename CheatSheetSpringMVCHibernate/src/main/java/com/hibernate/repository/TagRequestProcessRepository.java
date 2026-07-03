package com.hibernate.repository;

import com.hibernate.entity.TagRequestEntity;
import com.hibernate.entity.enums.TagRequestStatus;
import java.util.List;

public interface TagRequestProcessRepository {
    List<TagRequestEntity> findByStatus(TagRequestStatus status);
    TagRequestEntity findById(Long id);
    void update(Object entity);
    void save(Object entity);
}