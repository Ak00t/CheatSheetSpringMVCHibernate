
package com.hibernate.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserLoginRegisterService;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Setter
@Controller
@RequiredArgsConstructor
public class LoginRegisterController {

    public final UserLoginRegisterService userService;
    public final PasswordEncoder encoder;

	
	@PostMapping("/register")
	public String registerUser(@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("confirmPassword") String confirmPassword,
			HttpSession session, HttpServletRequest request) {

		String referer = request.getHeader("Referer");
		String redirectUrl = (referer != null) ? "redirect:" + referer : "redirect:/home";

		// Clean up previous query flags to prevent endless redirect loops
		redirectUrl = redirectUrl.replaceAll("[?&]regError=true", "").replaceAll("[?&]regSuccess=true", "");
		String joinChar = redirectUrl.contains("?") ? "&" : "?";

		// 1. Validate Passwords Match
		if (!password.equals(confirmPassword)) {
			session.setAttribute("regErrorMessage", "Passwords do not match!");
			return redirectUrl + joinChar + "regError=true&prevName=" + name + "&prevEmail=" + email;
		}

		// 2. Validate Email Uniqueness
		UserEntity tempUser = new UserEntity();
		tempUser.setEmail(email);
		if (userService.checkEmail(tempUser)) {
			session.setAttribute("regErrorMessage", "This Email is already registered. Please Login.");
			return redirectUrl + joinChar + "regError=true&prevName=" + name;
		}

		// 3. Save User Flow
		UserEntity newUser = new UserEntity();
		newUser.setName(name);
		newUser.setEmail(email);
		newUser.setPassword(encoder.encode(password));
		userService.registerUser(newUser);

		// Clean session data on success
		session.removeAttribute("regErrorMessage");

		return "redirect:/home?regSuccess=true";
	}

	

}
	

	
