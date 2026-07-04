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
	private final javax.servlet.http.HttpServletRequest request;

	@ModelAttribute("unreadNotifications")
	public List<NotificationEntity> populateUnreadNotifications(HttpSession session) {
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {
			return notiService.findUnreadByUserId(currentUser.getId());
		}
		return null;
	}

	@ModelAttribute("readNotificationsHistory")
	public List<NotificationEntity> populateReadNotifications(HttpSession session) {
		if (request.getRequestURI().startsWith("/admindashboard")) {
			return null;
		}
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {

			return notiService.findReadByUserId(currentUser.getId());
		}
		return null;
	}
}