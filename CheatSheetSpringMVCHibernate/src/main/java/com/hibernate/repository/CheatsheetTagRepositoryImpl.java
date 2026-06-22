package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetTagRepositoryImpl implements CheatsheetTagRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void save(Long cheatsheetId, Long tagId) {

        sessionFactory.getCurrentSession()
                .createNativeQuery(
                        "INSERT INTO cheatsheet_tags (cheatsheet_id, tag_id) VALUES (:cheatsheetId, :tagId)")
                .setParameter("cheatsheetId", cheatsheetId)
                .setParameter("tagId", tagId)
                .executeUpdate();
    }
}