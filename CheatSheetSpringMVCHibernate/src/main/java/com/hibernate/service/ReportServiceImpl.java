package com.hibernate.service;

import java.time.LocalDateTime;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hibernate.entity.CheatsheetEntity;
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
    @Transactional
    public void saveReport(Long userId, Long targetId, String reason, String description) {
        // ၁။ Target ရှာဖွေခြင်း
        CheatsheetEntity cheatsheet = sessionFactory.getCurrentSession().get(CheatsheetEntity.class, targetId);
        if (cheatsheet == null) {
            throw new RuntimeException("Target Cheatsheet not found!");
        }

        // ၂။ ကိုယ့်ဘာသာ Report တင်ခြင်းကို Service Layer မှာ စိတ်ချရဆုံး primitive value ချင်း ယှဉ်စစ်ခြင်း
        if (cheatsheet.getUser() != null && cheatsheet.getUser().getId().longValue() == userId.longValue()) {
            throw new RuntimeException("You cannot report your own cheat sheet!");
        }
        if (isContentReportedByUser(userId, targetId)) {
            throw new IllegalStateException("ALREADY_REPORTED");
        }

        // ၃။ တိုင်ကြားသူ User ကို ဆွဲထုတ်ခြင်း
        UserEntity user = sessionFactory.getCurrentSession().get(UserEntity.class, userId);
        
        ReportEntity report = new ReportEntity();
        report.setReporterUser(user);
        report.setTargetId(targetId);
        report.setTargetType(TargetType.CHEATSHEET); // 🔑 🛑 ဒီလိုင်းလေး မဖြစ်မနေ ပါရပါမယ် (Repository Check ကို ဖြတ်ကျော်နိုင်ရန်)
        report.setReason(ReportReason.valueOf(reason));
        report.setDescription(description);
        report.setStatus(ReviewStatus.PENDING);
        report.setCreatedAt(LocalDateTime.now());
        
        // ၄။ Repository သို့ ပို့၍ သိမ်းဆည်းခြင်း
        reportRepository.save(report);

        // ၅။ Counter Update လုပ်ခြင်း (Null Safe ဖြစ်အောင် စစ်ဆေးပါသည်)
        int currentCount = cheatsheet.getReportCount() != null ? cheatsheet.getReportCount() : 0;
        cheatsheet.setReportCount(currentCount + 1);
        sessionFactory.getCurrentSession().update(cheatsheet);
    }
    @Override
    @Transactional(readOnly = true)
    public boolean isContentReportedByUser(Long userId, Long targetId) {
        String hql = "SELECT COUNT(r.id) FROM ReportEntity r " +
                     "WHERE r.reporterUser.id = :userId " +
                     "AND r.targetId = :targetId " +
                     "AND r.targetType = com.hibernate.entity.enums.TargetType.CHEATSHEET";
                     
        Long count = sessionFactory.getCurrentSession()
                .createQuery(hql, Long.class)
                .setParameter("userId", userId)
                .setParameter("targetId", targetId)
                .uniqueResult();
                
        return count != null && count > 0;
    }
}