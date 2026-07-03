package com.hibernate.config;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserLoginRegisterService;
import com.hibernate.service.AdminActivityLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserLoginRegisterService userService;

    @Autowired
    private AdminActivityLogService adminActivityLogService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        
        String email = authentication.getName();
        UserEntity user = userService.findByEmail(email);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            
            int userId = user.getId().intValue();
            String description;
            
            if (user.getRole() != null && "ADMIN".equals(user.getRole().name())) {
                description = "Admin successfully authenticated via login form.";
                adminActivityLogService.log(userId, "LOGIN", "users", userId, description);
                response.sendRedirect(request.getContextPath() + "/admindashboard");
            } else {
                description = "User '" + user.getName() + "' successfully logged in.";
                adminActivityLogService.log(userId, "LOGIN", "users", userId, description);
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login?error=true");
        }
    }
}