package com.hibernate.repository;

import org.hibernate.Session;
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
        Session session = sessionFactory.getCurrentSession();
        
        if (report != null && report.getReporterUser() != null) {
            Long reporterId = report.getReporterUser().getId();
            Long targetId = report.getTargetId();
            
            // 💡 🔑 အရေးကြီးဆုံးအချက်: တိုင်ကြားတဲ့အရာဟာ CHEATSHEET ဖြစ်မှသာ ပိုင်ရှင်စစ်ဆေးမှုကို လုပ်ဆောင်မည်
            if (report.getTargetType() == com.hibernate.entity.enums.TargetType.CHEATSHEET) {
                String hql = "SELECT c.user.id FROM CheatsheetEntity c WHERE c.id = :cheatsheetId";
                Long ownerId = session.createQuery(hql, Long.class)
                                      .setParameter("cheatsheetId", targetId)
                                      .uniqueResult();
                
                if (ownerId != null && ownerId.longValue() == reporterId.longValue()) {
                    throw new RuntimeException("Permission Denied: You cannot report your own cheat sheet.");
                }
            }
        }
        
        // စစ်ဆေးမှု ကင်းလွတ်မှသာ တခြားသူတွေရဲ့ Report များကို ပုံမှန်အတိုင်း ဒေတာဘေ့စ်ထဲ သိမ်းဆည်းခွင့်ပေးမည်
        session.save(report);
        session.flush(); 
    }
    
}
