package com.hibernate.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.DTO.AdminAnalyticsDTO;
import com.hibernate.service.AdminAnalyticsService;

import java.time.Month;
import java.time.format.TextStyle;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminAnalyticsController {

    @Autowired
    private AdminAnalyticsService adminAnalyticsService;

    @GetMapping("/analytics")
    public String displayDashboardView(
            @RequestParam(value = "type", defaultValue = "MONTH") String type,
            @RequestParam(value = "year", required = false) Integer year,
            @RequestParam(value = "month", required = false) Integer month,
            @RequestParam(value = "week", required = false) Integer week,
            @RequestParam(value = "day", required = false) String day,
            HttpSession session, Model model) {
        
        // Login စစ်ဆေးခြင်း
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }

        // Dashboard Dropdown အတွက် လ (Months) Map ပြုလုပ်ခြင်း
        Map<Integer, String> englishMonths = new LinkedHashMap<>();
        for (int i = 1; i <= 12; i++) {
            englishMonths.put(i, Month.of(i).getDisplayName(TextStyle.FULL, Locale.ENGLISH));
        }
        model.addAttribute("monthsMap", englishMonths);

        // Analytics Data ကို Service မှ ဆွဲယူခြင်း
        AdminAnalyticsDTO structuredPayload = adminAnalyticsService.getCompiledAnalyticsDashboard(type, year, month, week, day);
        model.addAttribute("analytics", structuredPayload);
        
        // Filter parameters များကိုလည်း Model ထဲထည့်ပေးလိုက်ပါ (JSP မှာ အသုံးပြုရန်)
        model.addAttribute("currentType", type);
        model.addAttribute("currentYear", year);
        model.addAttribute("currentMonth", month);
        
        return "admin_analytics";
    }
}