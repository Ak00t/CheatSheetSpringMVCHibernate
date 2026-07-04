package com.hibernate.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.ReferenceType;
import com.hibernate.repository.UserProfileRepository;
import com.hibernate.service.FollowService;
import com.hibernate.service.NotificationService;

@Controller
@RequestMapping("/follow")
public class FollowController {
	@Autowired
	private FollowService followService;
	@Autowired
	private UserProfileRepository userRepo;
	@Autowired
	private NotificationService notiService;
	// User အချက်အလက်ရယူရန်

	@PostMapping("/toggle")
	@ResponseBody
	public ResponseEntity<?> toggle(@RequestParam Long followingId, Principal principal) {
		System.out.println("Follow လုပ်မယ့် ID: " + followingId);
		Long currentId = userRepo.findByEmail(principal.getName()).getId();
		String currentuserName = userRepo.findByEmail(principal.getName()).getName();
		UserEntity targetUserToNotify = userRepo.findById(followingId);
		String notificationMessage = "";
		notificationMessage = currentuserName + " have  follow you!";
		followService.toggleFollow(currentId, followingId);
		if (targetUserToNotify != null && !currentId.equals(targetUserToNotify.getId())) {
			notiService
					.createAndSendNotification("You have a new follower!", notificationMessage, "FOLLOW",
							ReferenceType.USER, currentId, targetUserToNotify.getId(), followingId);
		}
		return ResponseEntity.ok().build();
	}
}