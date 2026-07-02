package com.hibernate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserFollowService;
import com.hibernate.service.UserProfileService;

import java.security.Principal;

@RestController
@RequestMapping("/follow")
public class FollowController {

    @Autowired
    private UserFollowService followService;
    @Autowired
    private UserProfileService userService; 
    // Service မှ ပြန်လာမည့် Logic အတိုင်း toggle လုပ်ပေးခြင်း
    @PostMapping("/toggle")
    @ResponseBody // Ajax request အတွက် ထည့်ပေးရပါမယ်
    public ResponseEntity<String> toggleFollow(@RequestParam Long followingId, Principal principal) {
        Long followerId = getCurrentUserId(principal);
        
        // Validation ကို အရင်စစ်ပါ
        if (followerId.equals(followingId)) {
            return ResponseEntity.badRequest().body("Cannot follow yourself");
        }
        
        followService.toggleFollow(followerId, followingId);
        return ResponseEntity.ok("Success");
    }

    // Helper method: SecurityContext ထဲမှ User ID ကို ထုတ်ယူရန်
    private Long getCurrentUserId(Principal principal) {
        // သင့် project ၏ custom UserDetails သို့မဟုတ် Security implementation ပေါ်မူတည်၍ ပြင်ဆင်ပါ
        // ဥပမာ - return ((CustomUserDetails) ((Authentication) principal).getPrincipal()).getId();
        return 1L; // ဥပမာအနေဖြင့် 1 ဟု သတ်မှတ်ထားသည်
    }
    @GetMapping("/profile/{id}")
    public String viewProfile(@PathVariable Long id, Model model, Principal principal) {
        // ... user details ရယူပါ ...
    	UserEntity user = userService.findById(id);
    	Long currentUserId = getCurrentUserId(principal);
        // လက်ရှိ Login ဝင်ထားသူက ဒီ profile ပိုင်ရှင်ကို follow လုပ်ထားလား စစ်ဆေးပါ
        boolean isFollowing = followService.isFollowing(currentUserId, id);
        
        model.addAttribute("user", user);
        model.addAttribute("isFollowing", isFollowing);
        return "profilePage";
    }
}