package com.hibernate.repository;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import com.hibernate.entity.CheatsheetEntity;


@Repository
public class AdminCheatsheetRepositoryImpl implements AdminCheatsheetRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<CheatsheetEntity> getAllCheatsheets() {
        String jpql = "SELECT c FROM CheatsheetEntity c JOIN FETCH c.user JOIN FETCH c.category";
        return entityManager.createQuery(jpql, CheatsheetEntity.class).getResultList();
    }

    @Override
    public void deleteCheatsheet(Long id) {
        CheatsheetEntity cheatsheet = entityManager.find(CheatsheetEntity.class, id);
        if (cheatsheet != null) {
            entityManager.remove(cheatsheet);
        }
    }
}