package com.hibernate.DTO;

import lombok.Getter;
import lombok.Setter;
import java.util.Map;

@Getter
@Setter
public class AdminAnalyticsDTO {
    // Selected Filter Information
    private String filterType; // "DAY", "WEEK", "MONTH", "YEAR"
    private int selectedYear;
    private int selectedMonth;
    private int selectedWeek;
    private String selectedDay; // "YYYY-MM-DD"
    private String dateRangeString; 

    // Analytics Counter Metrics
    private long newUsers;
    private long newCheatsheets;
    private long newComments;
    private long pendingReports;
    private long totalViews;
    private long totalLikes;
    
    // Added New Field for Maximum Views
    private Long maxViews; 

    // Content Category Breakdown
    private Map<String, Long> categoryDistribution;
}