package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.service.CategoryService;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor


public class HomeController {

    private final CategoryService categoryService;
    private final CheatsheetService cheatsheetService;
    private final UserService userService;
    
    

	/*
	 * @GetMapping("/") public String home(Model model) {
	 * 
	 * model.addAttribute( "parentCategories",
	 * categoryService.findParentCategories());
	 * 
	 * return "home"; }
	 */
    
    
    @RequestMapping("/")
    public String home(Model model) {

        // Parent Categories
        model.addAttribute(
                "parentCategories",
                categoryService.findParentCategories());

        // Statistics
        model.addAttribute(
                "totalCheatsheets",
                cheatsheetService.countPublicCheatsheets());

        model.addAttribute(
                "totalCategories",
                categoryService.countActiveCategories());

        model.addAttribute(
                "totalUsers",
                userService.countActiveUsers());

        // Home Lists
        model.addAttribute(
                "popularCheatsheets",
                cheatsheetService.findPopularCheatsheets(6));

        model.addAttribute(
                "recentCheatsheets",
                cheatsheetService.findRecentCheatsheets(6));

        model.addAttribute(
                "topContributors",
                userService.findTopContributors(5));

        return "home";
    }
    
    
}