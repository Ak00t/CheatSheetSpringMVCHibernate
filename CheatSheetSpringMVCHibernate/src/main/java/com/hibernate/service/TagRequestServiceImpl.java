package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.TagRequestEntity;
import com.hibernate.repository.TagRequestRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class TagRequestServiceImpl
        implements TagRequestService {

    private final TagRequestRepository tagRequestRepository;

    @Override
    public void save(TagRequestEntity tagRequest) {
        tagRequestRepository.save(tagRequest);
    }

    @Override
    public List<TagRequestEntity> findAll() {
        return tagRequestRepository.findAll();
    }

    @Override
    public TagRequestEntity findById(Long id) {
        return tagRequestRepository.findById(id);
    }

    @Override
    public void update(TagRequestEntity tagRequest) {
        tagRequestRepository.update(tagRequest);
    }
}