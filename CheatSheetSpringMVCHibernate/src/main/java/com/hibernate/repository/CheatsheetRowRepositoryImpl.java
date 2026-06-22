package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetRowEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetRowRepositoryImpl
        implements CheatsheetRowRepository {

    private final SessionFactory sessionFactory;

    @Override
    public Long save(CheatsheetRowEntity row) {

        return (Long) sessionFactory
                .getCurrentSession()
                .save(row);

    }

}