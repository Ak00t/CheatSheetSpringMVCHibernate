package com.hibernate.service;

import com.hibernate.entity.UserEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.*;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@Service
public class UserListServiceImpl implements UserListService {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional(readOnly = true)
    public List<UserEntity> getUsersByPeriod(String type, Integer year, Integer month, Integer week, String day) {
        // အရေးကြီးချက် - Dashboard ကနေ ဘာမှမပို့ရင်ပဲ Default ကို သုံးပါ
        LocalDate today = LocalDate.now();
        int y = (year != null && year > 0) ? year : today.getYear();
        int m = (month != null && month >= 1 && month <= 12) ? month : today.getMonthValue();
        
        LocalDateTime start, end;

        if ("DAY".equals(type) && day != null && !day.isEmpty()) {
            LocalDate d = LocalDate.parse(day);
            start = d.atStartOfDay();
            end = d.atTime(LocalTime.MAX);
        } else if ("WEEK".equals(type)) {
            // Week တွက်ချက်ခြင်း
            start = LocalDate.of(y, m, 1).plusWeeks((week != null && week > 0 ? week : 1) - 1)
                    .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)).atStartOfDay();
            end = start.plusDays(6).with(LocalTime.MAX);
        } else if ("YEAR".equals(type)) {
            start = LocalDateTime.of(y, 1, 1, 0, 0);
            end = LocalDateTime.of(y, 12, 31, 23, 59, 59);
        } else { // MONTH
            start = LocalDateTime.of(y, m, 1, 0, 0);
            end = LocalDate.of(y, m, 1).with(TemporalAdjusters.lastDayOfMonth()).atTime(LocalTime.MAX);
        }

        System.out.println("DEBUG: Query Start: " + start + " | End: " + end);

        return sessionFactory.getCurrentSession()
            .createQuery("FROM UserEntity u WHERE u.createdAt BETWEEN :start AND :end", UserEntity.class)
            .setParameter("start", start)
            .setParameter("end", end)
            .list();
    }
}