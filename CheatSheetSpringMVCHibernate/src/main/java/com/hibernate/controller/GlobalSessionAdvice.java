package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserLoginRegisterService;

import lombok.RequiredArgsConstructor;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalSessionAdvice {
	private final UserLoginRegisterService userService;

	@ModelAttribute
	public void handleRememberMeSession(HttpSession session) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		if (auth != null && auth.isAuthenticated() && !auth.getName().equals("anonymousUser")) {
			if (session.getAttribute("currentUser") == null) {
				String email = auth.getName();
				UserEntity user = userService.findByEmail(email);
				session.setAttribute("currentUser", user);
			}
		}

	}
}
