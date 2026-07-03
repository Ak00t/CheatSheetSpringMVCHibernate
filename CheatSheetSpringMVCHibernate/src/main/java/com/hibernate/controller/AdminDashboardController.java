package com.hibernate.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.AdminProfileService;
import com.hibernate.service.DashboardService;

import lombok.RequiredArgsConstructor;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/admindashboard") 
@RequiredArgsConstructor
public class AdminDashboardController {

    private final DashboardService dashboardService;
    private final AdminProfileService adminService; 

    @GetMapping("") 
    public String showDashboard(HttpSession session, Model model) {
        
        // Check if the user session exists
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

        if (!isAdmin) {
            return "redirect:/home"; 
        }

        // Refresh user profile metadata from DB on every dashboard load
        UserEntity freshUserData = adminService.getAdminProfile(currentUser.getId());
        session.setAttribute("currentUser", freshUserData);

        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();

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