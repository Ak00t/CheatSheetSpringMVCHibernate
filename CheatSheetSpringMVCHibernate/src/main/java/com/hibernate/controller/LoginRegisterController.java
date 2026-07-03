package com.hibernate.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hibernate.DTO.LoginDTO;
import com.hibernate.DTO.RegisterDTO;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserLoginRegisterService;
import com.hibernate.service.AdminActivityLogService;

import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Setter
@Controller
@RequiredArgsConstructor
public class LoginRegisterController {

    private final UserLoginRegisterService userService;
    private final PasswordEncoder encoder;
    private final AdminActivityLogService adminActivityLogService;

    @GetMapping("/register")
    public ModelAndView showRegisterForm() {
        return new ModelAndView("register-form", "registerDto", new RegisterDTO());
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("registerDto") RegisterDTO registerDto, BindingResult result, Model model) {
        if (result.hasErrors()) return "register-form";

        if (!registerDto.getPassword().equals(registerDto.getConfirmPassword())) {
            result.rejectValue("confirmPassword", "error.registerDto", "Passwords do not match!");
            return "register-form";
        }

        UserEntity tempUser = new UserEntity();
        tempUser.setEmail(registerDto.getEmail());

        if (userService.checkEmail(tempUser)) {
            result.rejectValue("email", "error.registerDto", "Your Email has been registered. Please Login.");
            return "register-form";
        }

        String hashCodedpw = encoder.encode(registerDto.getPassword());
        UserEntity newUser = new UserEntity();
        newUser.setName(registerDto.getName());
        newUser.setEmail(registerDto.getEmail());
        newUser.setPassword(hashCodedpw);

        userService.registerUser(newUser);
        
        Integer registeredId = (newUser.getId() != null) ? newUser.getId().intValue() : 0;
        
        adminActivityLogService.log(
            null, 
            "NOTI", 
            "users", 
            registeredId, 
            "A new user '" + newUser.getName() + "' has successfully registered."
        );

        return "redirect:/login?success=true";
    }

    @GetMapping("/login")
    public ModelAndView loginForm(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("currentUser");

        if (user == null) {
            return new ModelAndView("login", "loginDto", new LoginDTO());
        }
        if (user.getRole() != null && "ADMIN".equals(user.getRole().name())) {
            return new ModelAndView("redirect:/admindashboard");
        }

        return new ModelAndView("redirect:/home");
    }

    @PostMapping("/login")
    public String processLogin(@Valid @ModelAttribute("loginDto") LoginDTO loginDto, BindingResult result, HttpSession session) {
        if (result.hasErrors()) {
            return "login";
        }

        UserEntity user = userService.findByEmail(loginDto.getEmail());

        if (user == null || !encoder.matches(loginDto.getPassword(), user.getPassword())) {
            result.rejectValue("email", "error.loginDto", "Invalid email or password authentication.");
            return "login";
        }

        session.setAttribute("currentUser", user);

        if (user.getRole() != null && "ADMIN".equals(user.getRole().name())) {
            int userId = user.getId().intValue(); 
            
            adminActivityLogService.log(
                userId, 
                "LOGIN", 
                "users", 
                userId, 
                "Admin successfully authenticated via login form."
            );
            
            return "redirect:/admindashboard";
        }

        int regularUserId = user.getId().intValue();
        adminActivityLogService.log(
            regularUserId,
            "LOGIN",
            "users",
            regularUserId,
            "User '" + user.getName() + "' successfully logged in."
        );

        return "redirect:/home";
    }
}