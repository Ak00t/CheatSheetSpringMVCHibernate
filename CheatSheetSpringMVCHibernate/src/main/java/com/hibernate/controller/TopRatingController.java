package com.hibernate.controller;

import com.hibernate.service.TopRatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        
        model.addAttribute("topRatingList", topRatingService.getTopRatingList(type, year, month, null, null));
        
       
        return "toprating_list"; 
    }
}