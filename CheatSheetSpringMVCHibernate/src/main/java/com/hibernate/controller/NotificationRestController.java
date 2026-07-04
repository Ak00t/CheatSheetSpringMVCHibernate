package com.hibernate.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.hibernate.service.NotificationService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notification")
@RequiredArgsConstructor
public class NotificationRestController {

	private final NotificationService notiService;

	@PostMapping("/read")
	public ResponseEntity<Void> markAsRead(@RequestParam("id") Long id) {
		// Change status to READ in the database
		notiService.markAsRead(id);
		return ResponseEntity.ok().build();
	}

	@PostMapping("/read-all")
	public ResponseEntity<Void> markAllAsRead(
			@SessionAttribute(value = "currentUser", required = false) com.hibernate.entity.UserEntity user) {
		if (user != null) {
			notiService.markAllAsReadByUserId(user.getId());
		}
		return ResponseEntity.ok().build();
	}
}