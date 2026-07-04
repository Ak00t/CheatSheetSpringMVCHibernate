package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetMediaEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetMediaRepositoryImpl implements CheatsheetMediaRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void save(CheatsheetMediaEntity media) {
        sessionFactory
                .getCurrentSession()
                .save(media);
    }
}