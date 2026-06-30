package com.hibernate.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.hibernate.entity.NotificationEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.NotificationService;

import lombok.RequiredArgsConstructor;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalHeaderAdvice {

	private final NotificationService notiService;

	@ModelAttribute("unreadNotifications")
	public List<NotificationEntity> populateUnreadNotifications(HttpSession session) {
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {
			// Fetch unread items from DB (e.g., status = 'UNREAD' or isRead = false)
			return notiService.findUnreadByUserId(currentUser.getId());
		}
		return null;
	}
}