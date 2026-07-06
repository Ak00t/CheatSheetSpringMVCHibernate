package com.hibernate.repository;

import com.hibernate.entity.ReportEntity;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.repository.AdminReportRepository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class AdminReportRepositoryImpl implements AdminReportRepository {

    private final SessionFactory sessionFactory;

    @Autowired
    public AdminReportRepositoryImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<ReportEntity> findAllPendingReports() {
        return getCurrentSession()
                .createQuery("FROM ReportEntity r JOIN FETCH r.reporterUser WHERE r.status = :status")
                .setParameter("status", ReviewStatus.PENDING)
                .list();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<ReportEntity> findAllReportHistory() {
        return getCurrentSession()
                .createQuery(
                        "FROM ReportEntity r "
                                + "LEFT JOIN FETCH r.reporterUser "
                                + "LEFT JOIN FETCH r.reviewedBy "
                                + "WHERE r.status <> :status "
                                + "ORDER BY r.reviewedAt DESC, r.id DESC")
                .setParameter("status", ReviewStatus.PENDING)
                .list();
    }

    @Override
    public ReportEntity findById(Long id) {
        return getCurrentSession().get(ReportEntity.class, id);
    }

    @Override
    public void update(ReportEntity report) {
        getCurrentSession().update(report);
    }
}
