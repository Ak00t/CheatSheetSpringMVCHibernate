package com.hibernate.controller;
	
	
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;
import com.hibernate.service.UserProfileService;

import java.io.File;
import java.io.IOException;

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
    @Autowired
    private UserProfileRepository userRepository;
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
    	UserEntity user = userRepository.findById(id);
        
        if (!profileImg.isEmpty()) {
            try {
                // ဖိုင်သိမ်းမည့် လမ်းကြောင်း
                String uploadDir = "C:/uploads/profiles/";
                String fileName = profileImg.getOriginalFilename();
                File dest = new File(uploadDir + fileName);
                
                // ဖိုင်တွဲမရှိရင် အလိုလိုဖန်တီးပေးခြင်း
                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }
                
                profileImg.transferTo(dest); // ဤနေရာတွင် ဖိုင်ကို စက်ထဲသို့ သိမ်းပေးပါသည်
                user.setProfileImg(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        user.setName(name);
        user.setBio(bio);
        userRepository.updateProfile(user);
        userService.updateProfile(id, name, bio, profileImg);
        return "redirect:/profile/" + id;
    }
 // UserProfileController.java
    @GetMapping("/view/{id}")
    public String viewProfileDetail(@PathVariable Long id, Model model) {
        model.addAttribute("profileUser", userService.getUserProfile(id));
        return "profile-detail"; // profile detail ကို ပြမယ့် jsp နာမည်
    }
    
    
}