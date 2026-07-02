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

	@ModelAttribute("readNotificationsHistory")
	public List<NotificationEntity> populateReadNotifications(HttpSession session) {
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {
			// Make sure to add this method to your NotificationService / Repo layers
			// e.g., return notificationRepository.findReadByUserId(currentUser.getId());
			System.out
					.println("Read notifications for user " + currentUser.getId() + ": "
							+ notiService.findReadByUserId(currentUser.getId()));

			return notiService.findReadByUserId(currentUser.getId());
		}
		System.out.println("error: currentUser is null in populateReadNotifications");
		return null;
	}
}