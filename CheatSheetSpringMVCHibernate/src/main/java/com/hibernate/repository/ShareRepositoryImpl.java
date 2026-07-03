package com.hibernate.repository;

import com.hibernate.entity.ShareEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import lombok.RequiredArgsConstructor; // 👈 Lombok Import
import java.util.List;

@Repository
@RequiredArgsConstructor // 👈 🛑 `@RequiredArgsConstructor` ကို ဖြည့်စွက်လိုက်ပါပြီ
public class ShareRepositoryImpl implements ShareRepository {

    // 💡 🛑 @Autowired ကို ဖြုတ်ပြီး private final SessionFactory ဟု ပြောင်းလဲခြင်း
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
}