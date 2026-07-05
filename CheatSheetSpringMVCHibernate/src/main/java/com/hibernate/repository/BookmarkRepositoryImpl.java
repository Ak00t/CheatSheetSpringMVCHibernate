package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import com.hibernate.entity.BookmarkEntity;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BookmarkRepositoryImpl implements BookmarkRepository {
    private final SessionFactory sessionFactory;

    @Override
    public void save(BookmarkEntity bookmark) {
        Session session = sessionFactory.getCurrentSession();
        session.save(bookmark);
        session.flush(); 
    }

    @Override
    public void delete(Long userId, Long cheatsheetId) {
       
        String hql = "DELETE FROM BookmarkEntity b WHERE b.userId = :userId AND b.cheatsheetId = :cheatsheetId";
        sessionFactory.getCurrentSession().createQuery(hql)
                .setParameter("userId", userId)
                .setParameter("cheatsheetId", cheatsheetId)
                .executeUpdate();
        sessionFactory.getCurrentSession().flush();
    }

    @Override
    public boolean isBookmarked(Long userId, Long cheatsheetId) {
        String hql = "SELECT COUNT(b) FROM BookmarkEntity b WHERE b.userId = :userId AND b.cheatsheetId = :cheatsheetId";
        Long count = (Long) sessionFactory.getCurrentSession().createQuery(hql)
                .setParameter("userId", userId)
                .setParameter("cheatsheetId", cheatsheetId)
                .uniqueResult();
        return count > 0;
    }
}