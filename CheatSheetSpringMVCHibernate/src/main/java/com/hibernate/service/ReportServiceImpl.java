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
    public void saveReport(Long userId, Long targetId, String reason, String description) {
        // ၁။ သက်ဆိုင်ရာ Cheatsheet ကို အရင်ဆွဲထုတ်ပြီး ရှိမရှိ စစ်မယ်
        CheatsheetEntity cheatsheet = sessionFactory.getCurrentSession().get(CheatsheetEntity.class, targetId);
        if (cheatsheet == null) {
            throw new RuntimeException("Target Cheatsheet not found!");
        }

        // ၂။ Report Entity ဆောက်ပြီး Data ဖြည့်မယ်
        ReportEntity report = new ReportEntity();
        UserEntity user = sessionFactory.getCurrentSession().get(UserEntity.class, userId);
        
        report.setReporterUser(user);
        report.setTargetId(targetId);
        report.setTargetType(TargetType.CHEATSHEET);
        report.setReason(ReportReason.valueOf(reason));
        report.setDescription(description);
        report.setStatus(ReviewStatus.PENDING);
        report.setCreatedAt(LocalDateTime.now());
        
        // Report table ထဲ သိမ်းမယ်
        reportRepository.save(report);

        // 💡 ၃။ (အသစ်ထည့်သွင်းချက်) cheatsheets table ထဲက report_count ကိုပါ (+1) လိုက်တိုးပေးပါမည်
        int currentReportCount = cheatsheet.getReportCount() != null ? cheatsheet.getReportCount() : 0;
        cheatsheet.setReportCount(currentReportCount + 1);
        
        // Cheatsheet ဇယားကိုပါ update လုပ်ပေးမယ်
        sessionFactory.getCurrentSession().update(cheatsheet);
    }
}