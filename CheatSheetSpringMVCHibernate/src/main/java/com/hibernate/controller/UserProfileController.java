package com.hibernate.controller;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;
import com.hibernate.service.BookmarkService;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.CollectionService;
import com.hibernate.service.FollowService;
import com.hibernate.service.ShareService;
import com.hibernate.service.UserProfileService;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

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
    @Autowired
    private BookmarkService bookmarkService;
    @Autowired
    private ShareService shareService;
    @Autowired
    private FollowService followService;
   

    @GetMapping("/{id}")
    public String viewProfile(@PathVariable Long id, Model model, HttpSession session) {
        UserEntity targetUser = userService.getUserProfile(id);
        if (targetUser == null) {
            return "redirect:/";
        }

        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        Long currentUserId = (currentUser != null) ? currentUser.getId() : null;

    
        if (currentUserId == null || !id.equals(currentUserId)) {
            model.addAttribute("publicUser", targetUser);

          
            model.addAttribute("followersCount", followService.getFollowersCount(id));
            model.addAttribute("followingCount", followService.getFollowingCount(id));

            
            boolean isFollowing = false;
            if (currentUserId != null) {
                isFollowing = followService.isFollowing(currentUserId, id);
            }
            model.addAttribute("isFollowing", isFollowing);

           
            List<CheatsheetEntity> followersOnlySheets;
            if (isFollowing) {
                followersOnlySheets = cheatsheetService.findUnlistedByUserId(id);
            } else {
                followersOnlySheets = new ArrayList<>(); 
            }
            model.addAttribute("followersOnlySheets", followersOnlySheets);

            
            List<CheatsheetEntity> purePublicSheets = cheatsheetService.findPublishedByUserId(id);
            model.addAttribute("purePublicSheets", purePublicSheets);

            
            List<CollectionEntity> publicPlaylists = collectionService.getCollectionsByInterface(id, 1, 100);
            if (publicPlaylists != null) {
                publicPlaylists.removeIf(col -> !"PUBLIC".equals(col.getVisibility().toString()));
            }
            model.addAttribute("publicPlaylists", publicPlaylists);

            return "user-public-profile"; 
        }
        
        model.addAttribute("user", targetUser);
        model.addAttribute("bookmarkedSheets", cheatsheetService.findBookmarkedByUserId(id));
        model.addAttribute("sharedLogs", shareService.findSharesByUserId(id));

        List<CollectionEntity> rawCollections = collectionService.getCollectionsByInterface(id, 1, 100);
        if (currentUserId == null || !id.equals(currentUserId)) {
            rawCollections.removeIf(col -> !"PUBLIC".equals(col.getVisibility().toString()));
        }
        model.addAttribute("userCollections", rawCollections);

        return "profile";
    }
    @PostMapping("/update")
    public String updateProfile(@RequestParam("id") Long id,
            @RequestParam("name") String name,
            @RequestParam("bio") String bio,
            @RequestParam("profileImg") MultipartFile profileImg, Principal principal,HttpSession session) {
        UserEntity user = userRepository.findById(id);

        String currentUsername = principal.getName();
        UserEntity currentUser = userRepository.findByUsername(currentUsername);

       
        if (!currentUser.getId().equals(id)) {
            return "redirect:/error/403"; 
        }

        

        if (!profileImg.isEmpty()) {
            try {
                // Dynamic Path: user.home/app_uploads/profiles/
                String userHome = System.getProperty("user.home");
                String uploadDir = userHome + File.separator + "app_uploads" + File.separator + "profiles"
                        + File.separator;

                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs(); 
                }

               
                String fileName = System.currentTimeMillis() + "_" + profileImg.getOriginalFilename();
                File dest = new File(uploadDir + fileName);

                profileImg.transferTo(dest);
                user.setProfileImg(fileName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        user.setName(name);
        user.setBio(bio);
        userRepository.updateProfile(user);
        
        //final header pic 
        session.setAttribute("currentUser", user);
        
        
        
                return "redirect:/profile/" + id;
       

    }
   

    @Autowired
    private CheatsheetService cheatsheetService;
    @Autowired
    private CollectionService collectionService;

}