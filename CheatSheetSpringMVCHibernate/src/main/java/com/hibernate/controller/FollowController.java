package com.hibernate.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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
    @Autowired private UserProfileRepository userRepo; // User အချက်အလက်ရယူရန်

    @PostMapping("/toggle")
    @ResponseBody
    public ResponseEntity<?> toggle(@RequestParam Long followingId, Principal principal) {
    	System.out.println("Follow လုပ်မယ့် ID: " + followingId);
    	Long currentId = userRepo.findByEmail(principal.getName()).getId();
        followService.toggleFollow(currentId, followingId);
        return ResponseEntity.ok().build();
    }
}