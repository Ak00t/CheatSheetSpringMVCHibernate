package com.hibernate.controller;

import com.hibernate.service.UserListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/users")
public class UserListController {

    @Autowired
    private UserListService userListService;

    @GetMapping("/list")
    public String showUserList(
            @RequestParam(defaultValue = "MONTH") String type,
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer week,
            @RequestParam(required = false) String day,
            Model model) {
        
       
        model.addAttribute("users", userListService.getUsersByPeriod(type, year, month, week, day));
        return "user_list";
    }
}