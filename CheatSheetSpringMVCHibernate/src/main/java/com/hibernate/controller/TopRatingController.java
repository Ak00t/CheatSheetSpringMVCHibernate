package com.hibernate.controller;

import com.hibernate.service.TopRatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/admin/cheatsheets") 
public class TopRatingController {

    @Autowired
    private TopRatingService topRatingService;

    @GetMapping("/top-views")
    public String showList(
            @RequestParam(defaultValue = "MONTH") String type,
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            Model model) {
        
        // Fallback to current runtime parameters if request context boundaries are absent
        int selectedYear = (year != null) ? year : LocalDateTime.now().getYear();
        int selectedMonth = (month != null) ? month : LocalDateTime.now().getMonthValue();
        
        // Fetch and bind the strictly filtered database list directly to the architecture model
        model.addAttribute("topRatingList", topRatingService.getTopRatingList(type, selectedYear, selectedMonth, null, null));
        
        // Synchronize and retain timeframe state variables for the frontend view layer
        model.addAttribute("currentYear", selectedYear);
        model.addAttribute("currentMonth", selectedMonth);
        
        return "toprating_list"; 
    }
}