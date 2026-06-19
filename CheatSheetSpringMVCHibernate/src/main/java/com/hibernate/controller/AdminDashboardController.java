package com.hibernate.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.service.DashboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminDashboardController {

    private final DashboardService dashboardService;

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();

        // Adding metrics to model one by one to match the new granular service structure
        model.addAttribute("totalUsers", dashboardService.getTotalUsersCount());
        model.addAttribute("totalCheatsheets", dashboardService.getTotalCheatsheetsCount());
        model.addAttribute("pendingReports", dashboardService.getPendingReportsCount());
        model.addAttribute("bannedContents", dashboardService.getBannedContentsCount());

        model.addAttribute("newUsersToday", dashboardService.getTodayNewUsersCount(startOfToday));
        model.addAttribute("newCheatsheetsToday", dashboardService.getTodayNewCheatsheetsCount(startOfToday));
        model.addAttribute("newReportsToday", dashboardService.getTodayNewReportsCount(startOfToday));

        return "admin-dashboard";
    }
}