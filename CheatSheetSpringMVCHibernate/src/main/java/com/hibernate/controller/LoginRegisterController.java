/*
 * package com.hibernate.controller;
 * 
 * import javax.validation.Valid;
 * 
 * import org.springframework.security.crypto.password.PasswordEncoder; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.validation.BindingResult; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.servlet.ModelAndView;
 * 
 * import com.hibernate.DTO.LoginDTO; import com.hibernate.DTO.RegisterDTO;
 * import com.hibernate.entity.UserEntity; import
 * com.hibernate.service.UserLoginRegisterService;
 * 
 * import lombok.RequiredArgsConstructor;
 * 
 * @Controller
 * 
 * @RequiredArgsConstructor public class LoginRegisterController {
 * 
 * public final UserLoginRegisterService userService; public final
 * PasswordEncoder encoder;
 * 
 * @GetMapping("/register") public ModelAndView showRegisterForm() {
 * ModelAndView mv = new ModelAndView("register-form", "registerDto", new
 * RegisterDTO()); return mv; }
 * 
 * // 2. Handle Form Submission
 * 
 * @PostMapping("/register") public String
 * registerUser(@Valid @ModelAttribute("registerDto") RegisterDTO registerDto,
 * BindingResult result, Model model) {
 * 
 * if (result.hasErrors()) { return "register-form"; }
 * 
 * if (!registerDto.getPassword().equals(registerDto.getConfirmPassword())) {
 * result.rejectValue("confirmPassword", "error.registerDto",
 * "Passwords do not match!"); return "register-form"; }
 * 
 * UserEntity tempUser = new UserEntity();
 * tempUser.setEmail(registerDto.getEmail());
 * 
 * if (userService.checkEmail(tempUser)) { result.rejectValue("email",
 * "error.registerDto", "Your Email has been registered. Please Login."); return
 * "register-form"; }
 * 
 * String hashCodedpw = encoder.encode(registerDto.getPassword()); UserEntity
 * newUser = new UserEntity(); newUser.setName(registerDto.getName());
 * newUser.setEmail(registerDto.getEmail()); newUser.setPassword(hashCodedpw);
 * 
 * userService.registerUser(newUser);
 * 
 * return "redirect:/login?success=true"; }
 * 
 * @GetMapping("/login") public ModelAndView loginForm() { ModelAndView mv = new
 * ModelAndView("login", "loginDto", new LoginDTO()); return mv; }
 * 
 * }
 */
package com.hibernate.controller;

import javax.servlet.http.HttpSession; // Session အတွက် လိုအပ်သော import
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

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginRegisterController {

    public final UserLoginRegisterService userService;
    public final PasswordEncoder encoder;

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
        return "redirect:/login?success=true";
    }

    @GetMapping("/login")
    public ModelAndView loginForm() {
        return new ModelAndView("login", "loginDto", new LoginDTO());
    }

    
    }
