package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.TagRequestEntity;

public interface TagRequestRepository {

    void save(TagRequestEntity tagRequest);

    List<TagRequestEntity> findAll();

    TagRequestEntity findById(Long id);

    void update(TagRequestEntity tagRequest);
}