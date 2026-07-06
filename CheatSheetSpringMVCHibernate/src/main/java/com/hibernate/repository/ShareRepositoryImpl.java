package com.hibernate.repository;

import com.hibernate.entity.ShareEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import lombok.RequiredArgsConstructor; // 👈 Lombok Import
import java.util.List;

@Repository
@RequiredArgsConstructor 
public class ShareRepositoryImpl implements ShareRepository {

    
    private final SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(ShareEntity share) {
        getCurrentSession().save(share);
        getCurrentSession().flush(); 
    }

    @Override
    public List<ShareEntity> findByUserId(Long userId) {
        String hql = "FROM ShareEntity s WHERE s.user.id = :userId ORDER BY s.id DESC";
        return getCurrentSession()
                .createQuery(hql, ShareEntity.class)
                .setParameter("userId", userId)
                .getResultList();
    }
    @Override
    public ShareEntity findById(Long id) {
        return getCurrentSession().get(ShareEntity.class, id);
    }

    @Override
    public void delete(ShareEntity share) {
        getCurrentSession().delete(share);
        getCurrentSession().flush(); 
    }
}