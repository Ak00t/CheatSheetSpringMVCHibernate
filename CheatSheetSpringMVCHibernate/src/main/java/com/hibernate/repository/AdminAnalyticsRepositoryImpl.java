package com.hibernate.repository;

import com.hibernate.DTO.AdminAnalyticsDTO;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AdminAnalyticsRepositoryImpl implements AdminAnalyticsRepository {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public AdminAnalyticsDTO fetchFilteredAnalyticsData(String type, Integer year, Integer month, Integer week, String day) {
        AdminAnalyticsDTO analyticsDTO = new AdminAnalyticsDTO();
        var currentSession = sessionFactory.getCurrentSession();
        Map<String, LocalDateTime> boundaries = getBoundaries(type, year, month, week, day);
        LocalDateTime start = boundaries.get("start");
        LocalDateTime end = boundaries.get("end");

        analyticsDTO.setFilterType(type != null ? type.toUpperCase() : "MONTH");
        analyticsDTO.setDateRangeString(start.toLocalDate().format(DateTimeFormatter.ofPattern("dd MMMM yyyy")) + " - " + end.toLocalDate().format(DateTimeFormatter.ofPattern("dd MMMM yyyy")));

        analyticsDTO.setNewUsers(currentSession.createQuery("SELECT COUNT(u) FROM UserEntity u WHERE u.createdAt BETWEEN :start AND :end", Long.class).setParameter("start", start).setParameter("end", end).uniqueResult());
        analyticsDTO.setNewCheatsheets(currentSession.createQuery("SELECT COUNT(c) FROM CheatsheetEntity c WHERE c.createdAt BETWEEN :start AND :end", Long.class).setParameter("start", start).setParameter("end", end).uniqueResult());
        analyticsDTO.setNewComments(currentSession.createQuery("SELECT COUNT(cm) FROM CommentEntity cm WHERE cm.createdAt BETWEEN :start AND :end", Long.class).setParameter("start", start).setParameter("end", end).uniqueResult());
        analyticsDTO.setPendingReports(currentSession.createQuery("SELECT COUNT(r) FROM ReportEntity r WHERE r.status = com.hibernate.entity.enums.ReviewStatus.PENDING AND r.createdAt BETWEEN :start AND :end", Long.class).setParameter("start", start).setParameter("end", end).uniqueResult());
        
        Long sumViews = currentSession.createQuery("SELECT SUM(c.viewCount) FROM CheatsheetEntity c WHERE c.createdAt BETWEEN :start AND :end", Long.class).setParameter("start", start).setParameter("end", end).uniqueResult();
        Long sumLikes = currentSession.createQuery("SELECT SUM(c.likeCount) FROM CheatsheetEntity c WHERE c.createdAt BETWEEN :start AND :end", Long.class).setParameter("start", start).setParameter("end", end).uniqueResult();
        analyticsDTO.setTotalViews(sumViews != null ? sumViews : 0L);
        analyticsDTO.setTotalLikes(sumLikes != null ? sumLikes : 0L);
        analyticsDTO.setMaxViews(findMaxViewsByCriteria(type, year, month, week, day));

        return analyticsDTO;
    }

    @Override
    public Long findMaxViewsByCriteria(String type, Integer year, Integer month, Integer week, String day) {
        Map<String, LocalDateTime> bounds = getBoundaries(type, year, month, week, day);
        Object result = sessionFactory.getCurrentSession().createQuery("SELECT MAX(c.viewCount) FROM CheatsheetEntity c WHERE c.createdAt BETWEEN :start AND :end").setParameter("start", bounds.get("start")).setParameter("end", bounds.get("end")).uniqueResult();
        return (result instanceof Integer) ? ((Integer) result).longValue() : (result instanceof Long ? (Long) result : 0L);
    }

    @Override
    public List<CheatsheetEntity> findTopViewedCheatsheets(String type, Integer year, Integer month, Integer week, String day) {
        Map<String, LocalDateTime> bounds = getBoundaries(type, year, month, week, day);
        return sessionFactory.getCurrentSession()
                .createQuery("FROM CheatsheetEntity c WHERE c.createdAt BETWEEN :start AND :end ORDER BY c.viewCount DESC", CheatsheetEntity.class)
                .setParameter("start", bounds.get("start"))
                .setParameter("end", bounds.get("end"))
                .setMaxResults(10)
                .list();
    }

    @Override
    public List<UserEntity> findUsersByPeriod(String type, Integer year, Integer month, Integer week, String day) {
        Map<String, LocalDateTime> bounds = getBoundaries(type, year, month, week, day);
        
        // SQL Query တွင် parameters များကို သေချာထည့်ပါ
        return sessionFactory.getCurrentSession()
                .createQuery("FROM UserEntity u WHERE u.createdAt >= :start AND u.createdAt <= :end", UserEntity.class)
                .setParameter("start", bounds.get("start"))
                .setParameter("end", bounds.get("end"))
                .list();
    }

    private Map<String, LocalDateTime> getBoundaries(String type, Integer year, Integer month, Integer week, String day) {
        LocalDate today = LocalDate.now();
        String t = (type == null) ? "MONTH" : type.toUpperCase();
        
        LocalDate start, end;

        // 💡 ပြင်ဆင်ချက်- TYPE က DAY ဖြစ်နေရင် day parameter ကို သေချာပေါက် အရင် parse လုပ်ပြီး သုံးခိုင်းပါတယ်
        if ("DAY".equals(t) && day != null && !day.isEmpty()) {
            LocalDate parsedDate = LocalDate.parse(day);
            start = parsedDate;
            end = parsedDate;
        } else {
            int y = (year != null && year > 0) ? year : today.getYear();
            int m = (month != null && month >= 1 && month <= 12) ? month : today.getMonthValue();
            int w = (week != null) ? week : 1;
            
            switch (t) {
                case "WEEK": 
                    start = LocalDate.of(y, m, 1).plusWeeks(w - 1).with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY)); 
                    end = start.plusDays(6); 
                    break;
                case "YEAR": 
                    start = LocalDate.of(y, 1, 1); 
                    end = LocalDate.of(y, 12, 31); 
                    break;
                case "MONTH": 
                default: 
                    start = LocalDate.of(y, m, 1); 
                    end = start.with(java.time.temporal.TemporalAdjusters.lastDayOfMonth());
            }
        }
        
        Map<String, LocalDateTime> map = new HashMap<>();
        map.put("start", LocalDateTime.of(start, java.time.LocalTime.MIN));
        map.put("end", LocalDateTime.of(end, java.time.LocalTime.MAX));
        return map;
    }
}