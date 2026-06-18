package com.hibernate.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hibernate.DTO.RegisterDTO;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserLoginRegisterService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginRegisterController {

	public final UserLoginRegisterService userService;

	@GetMapping("/register")
	public ModelAndView showRegisterForm(Model model) {
		ModelAndView mv = new ModelAndView("register-form", "registerDto", new RegisterDTO());
		return mv;
	}

	// 2. Handle Form Submission
	@PostMapping("/register")
	public String registerUser(@Valid @ModelAttribute("registerDto") RegisterDTO registerDto, BindingResult result,
			Model model) {

		if (result.hasErrors()) {
			return "register-form";
		}

		// Step 2: Custom Validation - Check if passwords match
		if (!registerDto.getPassword().equals(registerDto.getConfirmPassword())) {
			result.rejectValue("confirmPassword", "error.registerDto", "Passwords do not match!");
			return "register-form";
		}

		// Step 3: Database Check - Check if email already exists
		// We temporarily map the email to a generic UserEntity for your checkEmail
		// method
		UserEntity tempUser = new UserEntity();
		tempUser.setEmail(registerDto.getEmail());

		if (userService.checkEmail(tempUser)) {
			// Your fixed checkEmail method returns true if email exists
			result.rejectValue("email", "error.registerDto", "Your Email has been registered. Please Login.");
			return "register-form";
		}

		// Step 4: Map DTO data to actual Entity and Save
		UserEntity newUser = new UserEntity();
		newUser.setName(registerDto.getName());
		newUser.setEmail(registerDto.getEmail());
		newUser.setPassword(registerDto.getPassword()); // Recommended: Encrypt this (e.g., BCrypt)
		// If your UserEntity has a name field, you can add it to the DTO and map it
		// here too.

		userService.registerUser(newUser); // Assuming your service has a save method

		// Redirect to login page upon successful registration
		return "redirect:/login?success=true";
	}

}
