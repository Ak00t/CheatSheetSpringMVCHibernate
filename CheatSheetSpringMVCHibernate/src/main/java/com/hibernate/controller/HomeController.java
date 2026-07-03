package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    
    
	/*
	 * @RequestMapping("/") public String home(Model model) {
	 * 
	 * // Parent Categories model.addAttribute( "parentCategories",
	 * categoryService.findParentCategories());
	 * 
	 * // Statistics model.addAttribute( "totalCheatsheets",
	 * cheatsheetService.countPublicCheatsheets());
	 * 
	 * model.addAttribute( "totalCategories",
	 * categoryService.countActiveCategories());
	 * 
	 * model.addAttribute( "totalUsers", userService.countActiveUsers());
	 * 
	 * // Home Lists model.addAttribute( "popularCheatsheets",
	 * cheatsheetService.findPopularCheatsheets(6));
	 * 
	 * model.addAttribute( "recentCheatsheets",
	 * cheatsheetService.findRecentCheatsheets(6));
	 * 
	 * model.addAttribute( "topContributors", userService.findTopContributors(5));
	 * 
	 * return "home"; }
	 */
    
    
    @RequestMapping("/")
    public String home(
            @RequestParam(defaultValue = "0") int categoryPage,
            Model model) {

        int categorySize = 6;

        model.addAttribute(
                "parentCategories",
                categoryService.findParentCategoriesWithPagination(
                        categoryPage,
                        categorySize));

        long totalParentCategories =
                categoryService.countParentCategories();

        int totalCategoryPages =
                (int) Math.ceil((double) totalParentCategories / categorySize);

        model.addAttribute("categoryPage", categoryPage);
        model.addAttribute("totalCategoryPages", totalCategoryPages);

        model.addAttribute(
                "totalCheatsheets",
                cheatsheetService.countPublicCheatsheets());

        model.addAttribute(
                "totalCategories",
                categoryService.countActiveCategories());

        model.addAttribute(
                "totalUsers",
                userService.countActiveUsers());

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