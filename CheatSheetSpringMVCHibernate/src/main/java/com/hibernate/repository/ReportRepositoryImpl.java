package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.ReportEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReportRepositoryImpl implements ReportRepository {
    private final SessionFactory sessionFactory;

    @Override
    public void save(ReportEntity report) {
        sessionFactory.getCurrentSession().save(report);
    }
}
