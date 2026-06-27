package com.hibernate.repository;

import java.time.LocalDateTime;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.enums.BanStatus;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.repository.DashboardRepository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DashboardRepositoryImpl implements DashboardRepository {

    private final SessionFactory sessionFactory;

    // Helper method using getCurrentSession instead of openSession
    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public long getTotalUsersCount() {
        String hql = "SELECT COUNT(u) FROM UserEntity u";
        return (long) getSession().createQuery(hql).uniqueResult();
    }

    @Override
    public long getTotalCheatsheetsCount() {
        String hql = "SELECT COUNT(c) FROM CheatsheetEntity c";
        return (long) getSession().createQuery(hql).uniqueResult();
    }

    @Override
    public long getPendingReportsCount() {
        String hql = "SELECT COUNT(r) FROM ReportEntity r WHERE r.status = :status";
        return (long) getSession()
                .createQuery(hql)
                .setParameter("status", ReviewStatus.PENDING)
                .uniqueResult();
    }

    @Override
    public long getBannedContentsCount() {
        String hql = "SELECT COUNT(b) FROM BanEntity b WHERE b.status = :status";
        return (long) getSession()
                .createQuery(hql)
                .setParameter("status", BanStatus.ACTIVE)
                .uniqueResult();
    }

    @Override
    public long getTodayNewUsersCount(LocalDateTime startOfDay) {
        String hql = "SELECT COUNT(u) FROM UserEntity u WHERE u.createdAt >= :startOfDay";
        return (long) getSession()
                .createQuery(hql)
                .setParameter("startOfDay", startOfDay)
                .uniqueResult();
    }

    @Override
    public long getTodayNewCheatsheetsCount(LocalDateTime startOfDay) {
        String hql = "SELECT COUNT(c) FROM CheatsheetEntity c WHERE c.createdAt >= :startOfDay";
        return (long) getSession()
                .createQuery(hql)
                .setParameter("startOfDay", startOfDay)
                .uniqueResult();
    }

    @Override
    public long getTodayNewReportsCount(LocalDateTime startOfDay) {
        String hql = "SELECT COUNT(r) FROM ReportEntity r WHERE r.createdAt >= :startOfDay";
        return (long) getSession()
                .createQuery(hql)
                .setParameter("startOfDay", startOfDay)
                .uniqueResult();
    }
}