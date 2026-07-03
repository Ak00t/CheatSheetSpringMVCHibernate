package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.UserStatus;
import java.util.List;

@Repository
public class UserManagementRepositoryImpl implements UserManagementRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @SuppressWarnings("unchecked")
    public List<UserEntity> findUsersWithPagination(int offset, int size) {
        String hql = "FROM UserEntity u ORDER BY u.id DESC";
        Query<UserEntity> query = sessionFactory.getCurrentSession().createQuery(hql, UserEntity.class);
        query.setFirstResult(offset * size);
        query.setMaxResults(size);
        return query.getResultList();
    }

    @Override
    public long getTotalUsersCount() {
        String hql = "SELECT COUNT(u.id) FROM UserEntity u";
        Query<Long> query = sessionFactory.getCurrentSession().createQuery(hql, Long.class);
        return query.getSingleResult();
    }

    @Override
    public void updateUserStatus(Long userId, UserStatus status) {
        String hql = "UPDATE UserEntity u SET u.status = :status WHERE u.id = :userId";
        sessionFactory.getCurrentSession().createQuery(hql)
                      .setParameter("status", status)
                      .setParameter("userId", userId)
                      .executeUpdate();
    }

    @Override
    public void deleteUser(Long userId) {
        String hql = "DELETE FROM UserEntity u WHERE u.id = :userId";
        sessionFactory.getCurrentSession().createQuery(hql)
                      .setParameter("userId", userId)
                      .executeUpdate();
    }

    // ✅ FIX: User ID ကို အသုံးပြုပြီး ၎င်းတင်ထားသော Cheatsheets များကို HQL ဖြင့် ရှာဖွေခြင်း
    @Override
    @SuppressWarnings("unchecked")
    public List<CheatsheetEntity> findCheatsheetsByUserId(Long userId) {
        String hql = "FROM CheatsheetEntity c WHERE c.user.id = :userId ORDER BY c.id DESC";
        return sessionFactory.getCurrentSession()
                             .createQuery(hql, CheatsheetEntity.class)
                             .setParameter("userId", userId)
                             .getResultList();
    }

    // ✅ FIX: User ID ကို အသုံးပြုပြီး သက်ဆိုင်ရာ User Object တစ်ခုလုံးကို ဆွဲထုတ်ခြင်း
    @Override
    public UserEntity findUserById(Long userId) {
        String hql = "FROM UserEntity u WHERE u.id = :userId";
        return sessionFactory.getCurrentSession()
                             .createQuery(hql, UserEntity.class)
                             .setParameter("userId", userId)
                             .uniqueResult();
    }
}