package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.service.CategoryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor


public class HomeController {

    private final CategoryService categoryService;

    @GetMapping("/")
    public String home(Model model) {

        model.addAttribute(
                "parentCategories",
                categoryService.findParentCategories());

        return "home";
    }
}