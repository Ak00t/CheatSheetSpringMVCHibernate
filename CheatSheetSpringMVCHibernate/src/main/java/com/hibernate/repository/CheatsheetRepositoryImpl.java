package com.hibernate.repository;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import com.hibernate.entity.CheatsheetEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetRepositoryImpl implements CheatsheetRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void save(CheatsheetEntity cheatsheet) {
        sessionFactory.getCurrentSession().save(cheatsheet);
    }

    @Override
    public void update(CheatsheetEntity cheatsheet) {
        sessionFactory.getCurrentSession().update(cheatsheet);
    }

    @Override
    public void delete(CheatsheetEntity cheatsheet) {
        sessionFactory.getCurrentSession().delete(cheatsheet);
    }

    @Override
    public CheatsheetEntity findById(Long id) {
        return sessionFactory.getCurrentSession().get(CheatsheetEntity.class, id);
    }

    @Override
    public List<CheatsheetEntity> findAll() {
        // Optimizing with JOIN FETCH to retrieve user account names dynamically without Lazy errors
        return sessionFactory.getCurrentSession()
                .createQuery("FROM CheatsheetEntity c LEFT JOIN FETCH c.user WHERE c.status = 'ACTIVE' ORDER BY c.createdAt DESC", CheatsheetEntity.class)
                .list();
    }
}