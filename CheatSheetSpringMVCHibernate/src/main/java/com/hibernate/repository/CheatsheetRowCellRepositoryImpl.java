package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetRowCellEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetRowCellRepositoryImpl
        implements CheatsheetRowCellRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void save(CheatsheetRowCellEntity cell) {

        sessionFactory
            .getCurrentSession()
            .save(cell);

    }

}