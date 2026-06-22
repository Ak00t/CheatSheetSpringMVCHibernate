package com.hibernate.controller;
	
	
import com.hibernate.service.UserProfileService;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
	
@Controller
@RequestMapping("/profile")
public class UserProfileController {
	
    @Autowired
    private UserProfileService userService;
    
    @GetMapping("/{id}")
    public String viewProfile(@PathVariable Long id, Model model) {
        model.addAttribute("user", userService.getUserProfile(id));
        return "profile";
    }
    
    @PostMapping("/update")
    public String updateProfile(@RequestParam("id") Long id,
                                @RequestParam("name") String name,
                                @RequestParam("bio") String bio,
                                @RequestParam("profileImg") MultipartFile profileImg) {
        userService.updateProfile(id, name, bio, profileImg);
        return "redirect:/profile/" + id;
    }
}