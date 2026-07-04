package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetSectionEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetSectionRepositoryImpl
        implements CheatsheetSectionRepository {

    private final SessionFactory sessionFactory;

    @Override
    public Long save(CheatsheetSectionEntity section) {

        return (Long) sessionFactory
                .getCurrentSession()
                .save(section);

    }

}