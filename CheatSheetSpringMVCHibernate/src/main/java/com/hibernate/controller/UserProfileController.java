package com.hibernate.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;
import com.hibernate.service.UserProfileService;

@Controller
@RequestMapping("/profile")
public class UserProfileController {

    @Autowired
    private UserProfileService userService;

    @Autowired
    private UserProfileRepository userRepository;

    @GetMapping("/{id}")
    public String viewProfile(@PathVariable Long id, Model model) {
        model.addAttribute("user", userService.getUserProfile(id));
        return "profile";
    }

    @PostMapping("/update")
    public String updateProfile(@RequestParam("id") Long id,
                                @RequestParam("name") String name,
                                @RequestParam("bio") String bio,
                                @RequestParam("profileImg") MultipartFile profileImg) {

        UserEntity user = userRepository.findById(id);

        if (profileImg != null && !profileImg.isEmpty()) {

            try {

                String userHome = System.getProperty("user.home");

                String uploadDir =
                        userHome
                        + File.separator
                        + "app_uploads"
                        + File.separator
                        + "profiles"
                        + File.separator;

                File dir = new File(uploadDir);

                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileName =
                        "profile_"
                        + id
                        + "_"
                        + System.currentTimeMillis()
                        + "_"
                        + profileImg.getOriginalFilename();

                File dest = new File(uploadDir + fileName);

                profileImg.transferTo(dest);

                // DB ထဲ သိမ်းမယ့် path
                user.setProfileImg(fileName);

            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        user.setName(name);
        user.setBio(bio);

        userRepository.updateProfile(user);

        return "redirect:/profile/" + id;
    }

    @GetMapping("/uploads/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<byte[]> getProfileImage(
            @PathVariable String fileName) {

        try {

            String userHome =
                    System.getProperty("user.home");

            File file =
                    new File(
                            userHome
                            + File.separator
                            + "app_uploads"
                            + File.separator
                            + "profiles"
                            + File.separator
                            + fileName);

            if (file.exists()) {

                byte[] imageBytes =
                        Files.readAllBytes(file.toPath());

                return ResponseEntity
                        .ok()
                        .body(imageBytes);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return ResponseEntity.notFound().build();
    }

    @GetMapping("/view/{id}")
    public String viewProfileDetail(
            @PathVariable Long id,
            Model model) {

        model.addAttribute(
                "profileUser",
                userService.getUserProfile(id));

        return "profile-detail";
    }
}