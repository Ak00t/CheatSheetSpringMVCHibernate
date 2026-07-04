package com.hibernate.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.hibernate.service.PasswordResetService;

@Controller
public class PasswordResetController {

	@Autowired
	private PasswordResetService resetService;

	// Show request form
	@GetMapping("/forgot-password")
	public String showForgotPasswordForm() {
		return "forgot-password-form"; // forgot-password-form.jsp
	}

	// Handle email submission
	@PostMapping("/forgot-password")
	public String processForgotPassword(HttpServletRequest request, @RequestParam("email") String email, Model model) {
		try {
			String token = resetService.generateResetToken(email);

			// Spring automatically detects your domain, port, and deployment context path
			String resetLink = ServletUriComponentsBuilder
					.fromCurrentContextPath()
						.path("/reset-password")
						.queryParam("token", token)
						.toUriString();

			resetService.sendResetEmail(email, resetLink);
			model.addAttribute("message", "We have sent a reset password link to your email.");
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
		}
		return "forgot-password-form";
	}

	// Process landing link containing parameters
	@GetMapping("/reset-password")
	public String showResetPasswordForm(@RequestParam("token") String token, Model model) {
		model.addAttribute("token", token);
		return "reset-password-form"; // reset-password-form.jsp
	}

	// Update form password mutation
	@PostMapping("/reset-password")
	public String processResetPassword(@RequestParam("token") String token, @RequestParam("password") String password,
			Model model) {
		try {
			resetService.updatePassword(token, password);
			model.addAttribute("message", "Your password has been successfully updated! You can now log in.");
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
			model.addAttribute("token", token);
			return "reset-password-form";
		}
		return "redirect:/?resetSuccess=true";
	}
}