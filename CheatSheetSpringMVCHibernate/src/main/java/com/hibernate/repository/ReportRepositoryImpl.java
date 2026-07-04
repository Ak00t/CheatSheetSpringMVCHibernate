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
        session.save(report);
        session.flush(); // 💡 🛑 Database ထဲကို ချက်ချင်း အတင်းအကျပ် သွားရေးခိုင်းလိုက်တာ ဖြစ်ပါတယ်
    }
}
