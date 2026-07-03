package com.hibernate.service;

import java.time.LocalDateTime;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.ReportEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.ReportReason;
import com.hibernate.entity.enums.ReviewStatus;
import com.hibernate.entity.enums.TargetType;
import com.hibernate.repository.ReportRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {
    private final ReportRepository reportRepository;
    private final SessionFactory sessionFactory;

    @Override
    public void saveReport(Long userId, Long targetId, String reason, String description) {
        ReportEntity report = new ReportEntity();
        
        // Relationship များဆက်သွယ်ပေးခြင်း
        UserEntity user = sessionFactory.getCurrentSession().get(UserEntity.class, userId);
        report.setReporterUser(user);
        report.setTargetId(targetId);
        report.setTargetType(TargetType.CHEATSHEET);
        report.setReason(ReportReason.valueOf(reason));
        report.setDescription(description);
        report.setStatus(ReviewStatus.PENDING);
        report.setCreatedAt(LocalDateTime.now());
        
        reportRepository.save(report);
    }
}
