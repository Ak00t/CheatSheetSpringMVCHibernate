package com.hibernate.controller;
	
	
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;

import com.hibernate.service.UserProfileService;

import java.io.File;
import java.io.IOException;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
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
                  // Dynamic Path: user.home/app_uploads/profiles/
                  String userHome = System.getProperty("user.home");
                  String uploadDir = userHome + File.separator + "app_uploads" + File.separator + "profiles" + File.separator;
                  
                  File dir = new File(uploadDir);
                  if (!dir.exists()) {
                      dir.mkdirs(); // ဖိုင်တွဲမရှိရင် အလိုလိုဖန်တီးပေးခြင်း
                  }
                  
                  // File နာမည်ကို Unique ဖြစ်အောင် Timestamp ထည့်ခြင်း (အကြံပြုချက်)
                  String fileName = System.currentTimeMillis() + "_" + profileImg.getOriginalFilename();
                  File dest = new File(uploadDir + fileName);
                  
                  profileImg.transferTo(dest);
                  user.setProfileImg(fileName);
              } catch (IOException e) {
                  e.printStackTrace();
              }
          }
          
          user.setName(name);
          user.setBio(bio);
          userRepository.updateProfile(user);
          // userService.updateProfile(id, name, bio, profileImg); // ဒီ code ထပ်နေတယ်ဆိုရင် ပြန်စစ်ပါ
          return "redirect:/profile/" + id;
      }
 // UserProfileController.java
    @GetMapping("/view/{id}")
    public String viewProfileDetail(@PathVariable Long id, Model model) {
        model.addAttribute("profileUser", userService.getUserProfile(id));
        return "profile-detail"; // profile detail ကို ပြမယ့် jsp နာမည်
    }
    
    
}