package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.TagRequestEntity;

public interface TagRequestService {

    void save(TagRequestEntity tagRequest);

    List<TagRequestEntity> findAll();

    TagRequestEntity findById(Long id);

    void update(TagRequestEntity tagRequest);
}