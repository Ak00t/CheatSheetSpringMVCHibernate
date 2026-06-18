package com.hibernate.controller;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/profile")
public class UserProfileController {

    @Autowired
    private UserProfileService profileService;

   
    @GetMapping("/{id}")
    public String showProfile(@PathVariable Long id, Model model) {
        UserEntity user = profileService.getUserProfile(id);
        model.addAttribute("user", user); 
        return "profile"; 
    }

   
    @PostMapping("/update")
    public String updateProfile(@RequestParam Long id, 
                                @RequestParam String name, 
                                @RequestParam String bio,
                                @RequestParam String profileImg) {
    	if (profileImg == null || profileImg.isEmpty()) {
    	
    	}
        profileService.updateProfile(id, name, bio, profileImg);
        return "redirect:/profile/" + id; 
    }
}