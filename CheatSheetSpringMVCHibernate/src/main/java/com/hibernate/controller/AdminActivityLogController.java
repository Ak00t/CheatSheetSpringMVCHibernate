package com.hibernate.controller;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.AdminActivityLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AdminActivityLogController {

    @Autowired
    private AdminActivityLogService adminActivityLogService;

    // Injecting your existing standard services for data processing
    // @Autowired
    // private UserService userService;
    // @Autowired
    // private CheatsheetService cheatsheetService;

    // 1. View All System Notifications Stream
    @GetMapping("/admin/activity-logs")
    public String viewLogs(Model model) {
        model.addAttribute("adminActivityLogs", adminActivityLogService.getAllLogs());
        return "admin-activity-logs";
    }

    // 2. User/Admin Profile Picture Update Notification
    @PostMapping("/user/update-avatar")
    public String updateAvatar(@RequestParam int userId, @RequestParam String imagePath, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        
        // [Execution Block]: Your existing pure JDBC code to update image path
        // userService.updateAvatar(userId, imagePath);

        adminActivityLogService.log(
            userId, 
            "NOTI", 
            "users", 
            userId, 
            "User '" + currentUser.getName() + "' changed their profile picture."
        );
        return "redirect:/profile";
    }

    // 3. User/Admin Password Change Notification
    @PostMapping("/user/change-password")
    public String changePassword(@RequestParam int userId, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        
        // [Execution Block]: Your existing pure JDBC code to update credentials
        // userService.updatePassword(userId, newPassword);

        adminActivityLogService.log(
            userId, 
            "NOTI", 
            "users", 
            userId, 
            "User '" + currentUser.getName() + "' updated their account password."
        );
        return "redirect:/profile";
    }

    // 4. Administrative Ban Actions Notification (Who banned whom)
    @PostMapping("/admin/user/ban")
    public String banUser(@RequestParam int targetUserId, HttpSession session) {
        UserEntity currentAdmin = (UserEntity) session.getAttribute("currentUser");
        int adminId = currentAdmin.getId().intValue();
        
        // [Execution Block]: Your existing pure JDBC execution statement
        // userService.banUserById(targetUserId);
        
        // Query target username from service to append directly into the message string
        String targetUsername = "TargetUser"; // userService.findNameById(targetUserId); 

        adminActivityLogService.log(
            adminId, 
            "NOTI", 
            "users", 
            targetUserId, 
            "Admin '" + currentAdmin.getName() + "' banned user '" + targetUsername + "'."
        );
        return "redirect:/admin/dashboard";
    }

    // 5. User Cheatsheet Submission Notification (Who uploaded what)
    @PostMapping("/cheatsheet/upload")
    public String uploadCheatsheet(@RequestParam String title, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        int userId = currentUser.getId().intValue();
        
        // [Execution Block]: Save and return generated structural database row primary ID
        int generatedId = 1; // cheatsheetService.saveAndReturnId(title, userId);

        adminActivityLogService.log(
            userId, 
            "NOTI", 
            "cheatsheets", 
            generatedId, 
            "User '" + currentUser.getName() + "' uploaded a new cheat sheet: '" + title + "'."
        );
        return "redirect:/home";
    }
}