package com.hibernate.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.AdminProfileService;

@Controller
@RequestMapping("/admin")
public class AdminProfileController {

    @Autowired
    private AdminProfileService adminService;
    
    @Autowired
    private PasswordEncoder encoder;
    
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        UserEntity loginUser = (UserEntity) session.getAttribute("currentUser");
        if (loginUser == null) {
            return "redirect:/login"; 
        }
        UserEntity admin = adminService.getAdminProfile(loginUser.getId());
        model.addAttribute("admin", admin);
        return "admin_profile"; 
    }

    @PostMapping("/profile/update-password")
    public String updatePassword(@RequestParam String currentPassword, 
                                 @RequestParam String newPassword, 
                                 @RequestParam String confirmPassword,
                                 HttpSession session, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";
        
        UserEntity dbUser = adminService.getAdminProfile(currentUser.getId());
        
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "New passwords do not match!");
            model.addAttribute("admin", dbUser);
            return "admin_profile";
        }
        
        if (!encoder.matches(currentPassword, dbUser.getPassword())) {
            model.addAttribute("error", "Current password is incorrect!");
            model.addAttribute("admin", dbUser);
            return "admin_profile";
        }
        
        adminService.updateAdminPassword(currentUser.getId(), newPassword);
        session.invalidate(); 
        return "redirect:/login?msg=password_updated";
    }

    @PostMapping("/profile/upload-photo")
    public String uploadProfilePhoto(@RequestParam("profilePhoto") MultipartFile file,
                                     HttpSession session, HttpServletRequest request, Model model) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) return "redirect:/login";

        if (!file.isEmpty()) {
            try {
                String userHome = System.getProperty("user.home");
                String uploadDir = userHome + File.separator + "app_uploads" + File.separator;
                
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = "profile_" + currentUser.getId() + "_" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
                File serverFile = new File(uploadDir + fileName);
                
                file.transferTo(serverFile);

                // FIXED: Set relative URL path using /admin/uploads/ mapping
                String relativePath = request.getContextPath() + "/admin/uploads/" + fileName;
                adminService.updateAdminProfileImage(currentUser.getId(), relativePath);

                currentUser.setProfileImg(relativePath);
                session.setAttribute("currentUser", currentUser);

            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("error", "Failed to save profile picture.");
            }
        }
        return "redirect:/admin/profile";
    }

    // NEW ENDPOINT: Directly serves the image from the local storage folder to browser via byte response
    @GetMapping("/uploads/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@PathVariable String fileName) {
        try {
            String userHome = System.getProperty("user.home");
            File file = new File(userHome + File.separator + "app_uploads" + File.separator + fileName);
            
            if (file.exists()) {
                byte[] imageBytes = Files.readAllBytes(file.toPath());
                return ResponseEntity.ok().body(imageBytes);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ResponseEntity.notFound().build();
    }
}