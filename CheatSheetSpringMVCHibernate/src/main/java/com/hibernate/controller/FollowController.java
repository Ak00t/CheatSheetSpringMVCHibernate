package com.hibernate.controller;

import java.security.Principal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hibernate.repository.UserProfileRepository;
import com.hibernate.service.FollowService;

@Controller 
@RequestMapping("/follow")
public class FollowController {
    @Autowired private FollowService followService;
    @Autowired private UserProfileRepository userRepo; 

	
    @PostMapping("/toggle")
    @ResponseBody
    public ResponseEntity<?> toggle(@RequestParam("followingId") Long followingId, Authentication auth) {
        // 🔐 Security Check: Login မဝင်ထားရင် 401 Unauthorized ပြန်မယ်
        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getName())) {
            return ResponseEntity.status(401).body("Please log in first.");
        }

        System.out.println("Follow လုပ်မယ့် ID: " + followingId);
        
        
        var currentUser = userRepo.findByEmail(auth.getName());
        if (currentUser == null) {
            
            currentUser = userRepo.findByUsername(auth.getName());
        }

        if (currentUser == null) {
            return ResponseEntity.status(404).body("Current user session not found.");
        }

        Long currentId = currentUser.getId();
        
        // 🚫 ကိုယ့်ကိုယ်ကို Follow ပြန်လုပ်လို့မရအောင် ကာကွယ်ခြင်း
        if (currentId.equals(followingId)) {
            return ResponseEntity.badRequest().body("You cannot follow yourself.");
        }

        followService.toggleFollow(currentId, followingId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/my-followers")
    @ResponseBody
    public ResponseEntity<?> getMyFollowers() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
            return ResponseEntity.status(401).body("Unauthorized");
        }
        
        var userEntity = userRepo.findByEmail(auth.getName());
        if (userEntity == null) {
            return ResponseEntity.status(404).body("User not found");
        }
        
        
        List<?> followersList = followService.findFollowersData(userEntity.getId());
        return ResponseEntity.ok(followersList);
    }

    @GetMapping("/my-following")
    @ResponseBody
    public ResponseEntity<?> getMyFollowing() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
            return ResponseEntity.status(401).body("Unauthorized");
        }
        
        var userEntity = userRepo.findByEmail(auth.getName());
        if (userEntity == null) {
            return ResponseEntity.status(404).body("User not found");
        }
        
        
        List<?> followingList = followService.findFollowingData(userEntity.getId());
        return ResponseEntity.ok(followingList);
    }

    @GetMapping("/followers-view")
    public String showFollowersPage() {
        return "my-followers"; 
    }

    @GetMapping("/following-view")
    public String showFollowingPage() {
        return "my-following"; 
    }
}