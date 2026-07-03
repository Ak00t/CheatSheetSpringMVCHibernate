package com.hibernate.repository;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.CollectionItemEntity;
import com.hibernate.entity.enums.CollectionVisibility;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CollectionRepositoryImpl implements CollectionRepository {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveCollection(CollectionEntity collection) {
        getCurrentSession().saveOrUpdate(collection);
        getCurrentSession().flush();
    }

    @Override
    public void saveCollectionItem(CollectionItemEntity item) {
        getCurrentSession().save(item);
        getCurrentSession().flush(); 
    }

    // 💡 🛑 Pagination စနစ်အတွက် findByUserId ကို Offset Limit ခံပြီး ရှာမည့်ပုံစံ
    @Override
    public List<CollectionEntity> findByUserId(Long userId, int offset, int limit) {
        String hql = "FROM CollectionEntity c WHERE c.user.id = :userId ORDER BY c.id DESC";
        Query<CollectionEntity> query = getCurrentSession().createQuery(hql, CollectionEntity.class);
        query.setParameter("userId", userId);
        query.setFirstResult(offset); 
        query.setMaxResults(limit);   
        return query.getResultList();
    }

    @Override
    public CollectionEntity findById(Long id) {
        return getCurrentSession().get(CollectionEntity.class, id);
    }

    @Override
    public boolean isItemInCollection(Long collectionId, Long cheatsheetId) {
        String hql = "SELECT count(ci) FROM CollectionItemEntity ci " +
                     "WHERE ci.collectionId = :collectionId AND ci.cheatsheetId = :cheatsheetId";
        Query<Long> query = getCurrentSession().createQuery(hql, Long.class);
        query.setParameter("collectionId", collectionId);
        query.setParameter("cheatsheetId", cheatsheetId);
        return query.uniqueResult() > 0;
    }

    @Override
    public void updateVisibility(Long collectionId, CollectionVisibility visibility) {
        String hql = "UPDATE CollectionEntity c SET c.visibility = :visibility WHERE c.id = :id";
        Query<?> query = getCurrentSession().createQuery(hql);
        query.setParameter("visibility", visibility);
        query.setParameter("id", collectionId);
        query.executeUpdate();
        
        getCurrentSession().flush(); 
    }
}