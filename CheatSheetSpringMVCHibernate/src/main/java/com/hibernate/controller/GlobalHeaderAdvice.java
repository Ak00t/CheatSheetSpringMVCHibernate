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
		String uri = request.getServletPath();

		if (uri.startsWith("/admindashboard") || uri.startsWith("/admin")) {
			return null;
		}
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {
			return notiService.findUnreadByUserId(currentUser.getId());
		}
		return null;
	}

	@ModelAttribute("readNotificationsHistory")
	public List<NotificationEntity> populateReadNotifications(HttpSession session) {
		String uri = request.getRequestURI();
		if (uri.startsWith("/admindashboard") || uri.startsWith("/admin")) {
			return null;
		}
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {

			return notiService.findReadByUserId(currentUser.getId());
		}
		return null;
	}

	/*
	 * @ModelAttribute("reportNotifications") public List<NotificationEntity>
	 * populateReportNotifications(HttpSession session) { String uri =
	 * request.getServletPath();
	 * 
	 * // Match ONLY paths starting with /admin or /admindashboard if
	 * (uri.startsWith("/admin") || uri.startsWith("/admindashboard")) { UserEntity
	 * currentUser = (UserEntity) session.getAttribute("currentUser");
	 * 
	 * // Double-check security role context before loading data if (currentUser !=
	 * null && "ADMIN".equals(currentUser.getRole())) {
	 * System.err.println("failed to load report notifications for user: "); return
	 * notiService.findUnreadByUserId(currentUser.getId()); } } return null; }
	 */

}