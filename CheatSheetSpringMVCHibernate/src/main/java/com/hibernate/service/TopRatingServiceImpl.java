package com.hibernate.service;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.repository.TopRatingRepository;
import com.hibernate.service.TopRatingService;
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
        // အချိန်ပေါ်မူတည်ပြီး Range တွက်ချက်ခြင်း (Default အနေနဲ့ လက်ရှိလကို ယူထားပါတယ်)
        int y = (year != null) ? year : LocalDateTime.now().getYear();
        int m = (month != null) ? month : LocalDateTime.now().getMonthValue();
        
        LocalDateTime start = LocalDateTime.of(y, m, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1).minusSeconds(1);
        
        return topRatingRepository.findTopRatedCheatsheets(start, end);
    }
}