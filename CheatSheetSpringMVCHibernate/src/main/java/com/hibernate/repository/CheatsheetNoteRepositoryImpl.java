package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetNoteEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetNoteRepositoryImpl
        implements CheatsheetNoteRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void save(CheatsheetNoteEntity note) {

        sessionFactory
            .getCurrentSession()
            .save(note);

    }

}