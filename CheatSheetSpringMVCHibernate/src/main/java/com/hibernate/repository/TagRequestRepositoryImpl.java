package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.TagRequestEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class TagRequestRepositoryImpl
        implements TagRequestRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void save(TagRequestEntity tagRequest) {

        sessionFactory
                .getCurrentSession()
                .save(tagRequest);
    }

    @Override
    public List<TagRequestEntity> findAll() {

        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "from TagRequestEntity",
                        TagRequestEntity.class)
                .list();
    }

    @Override
    public TagRequestEntity findById(Long id) {

        return sessionFactory
                .getCurrentSession()
                .get(TagRequestEntity.class, id);
    }

    @Override
    public void update(TagRequestEntity tagRequest) {

        sessionFactory
                .getCurrentSession()
                .update(tagRequest);
    }
}