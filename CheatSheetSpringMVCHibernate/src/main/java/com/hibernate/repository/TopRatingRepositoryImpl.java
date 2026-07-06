package com.hibernate.repository;

import com.hibernate.entity.CheatsheetEntity;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class TopRatingRepositoryImpl implements TopRatingRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<CheatsheetEntity> findTopRatedCheatsheets(LocalDateTime start, LocalDateTime end) {
        String jpql = "SELECT c FROM CheatsheetEntity c JOIN FETCH c.user WHERE c.createdAt BETWEEN :start AND :end ORDER BY c.ratingAvg DESC";
        TypedQuery<CheatsheetEntity> query = entityManager.createQuery(jpql, CheatsheetEntity.class);
        query.setParameter("start", start);
        query.setParameter("end", end);
        return query.getResultList();
    }

    @Override
    public List<CheatsheetEntity> findAllCheatsheets() {
        // Fetch all items smoothly without any date range boundary restrictions
        String jpql = "SELECT c FROM CheatsheetEntity c JOIN FETCH c.user ORDER BY c.ratingAvg DESC";
        TypedQuery<CheatsheetEntity> query = entityManager.createQuery(jpql, CheatsheetEntity.class);
        return query.getResultList();
    }
}