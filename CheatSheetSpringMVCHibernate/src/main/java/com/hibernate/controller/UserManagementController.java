package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.service.UserManagementService;
import lombok.RequiredArgsConstructor;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/usermanagement")
@RequiredArgsConstructor
public class UserManagementController {

    private final UserManagementService userManagementService;

    @GetMapping("/list")
    public String showUserList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<UserEntity> userList = userManagementService.getUsersByPage(page - 1, size);
        long totalUsers = userManagementService.getTotalUsersCount();
        int totalPages = (int) Math.ceil((double) totalUsers / size);

        model.addAttribute("users", userList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", size);

        return "user-management-list"; 
    }

    @GetMapping("/profile/{id}")
    public String viewUserProfile(@PathVariable("id") Long userId, HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        UserEntity targetUser = userManagementService.getUserById(userId);
        List<CheatsheetEntity> userCheatsheets = userManagementService.getCheatsheetsByUserId(userId);

        model.addAttribute("targetUser", targetUser);
        model.addAttribute("userCheatsheets", userCheatsheets);

        return "user-profile-view"; 
    }

    @PostMapping("/ban/{id}")
    public String banUser(@PathVariable("id") Long userId) {
        userManagementService.banUser(userId);
        return "redirect:/usermanagement/list";
    }

    @PostMapping("/unban/{id}")
    public String unbanUser(@PathVariable("id") Long userId) {
        userManagementService.unbanUser(userId);
        return "redirect:/usermanagement/list";
    }

    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long userId) {
        userManagementService.removeUser(userId);
        return "redirect:/usermanagement/list";
    }
}