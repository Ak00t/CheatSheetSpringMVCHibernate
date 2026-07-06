package com.hibernate.service;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.repository.TopRatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class TopRatingServiceImpl implements TopRatingService {
    
    @Autowired
    private TopRatingRepository topRatingRepository;

    @Override
    public List<CheatsheetEntity> getTopRatingList(String type, Integer year, Integer month, Integer week, String day) {
        // Fallback to the current system year and month if parameters are null
        int y = (year != null) ? year : LocalDateTime.now().getYear();
        int m = (month != null) ? month : LocalDateTime.now().getMonthValue();
        
        // Calculate the boundary for the exact targeted month (e.g., July 2026)
        LocalDateTime start = LocalDateTime.of(y, m, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1).minusSeconds(1);
        
        // This query uses BETWEEN and will correctly return only the 3 items for July
        return topRatingRepository.findTopRatedCheatsheets(start, end);
    }
}