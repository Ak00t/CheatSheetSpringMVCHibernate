package com.hibernate.controller;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;
import com.hibernate.service.BookmarkService;
import com.hibernate.service.ShareService;
import com.hibernate.service.UserProfileService;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

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
    /*
     * @GetMapping("/{id}") public String viewProfile(@PathVariable Long id, Model
     * model) { model.addAttribute("user", userService.getUserProfile(id));
     * 
     * 
     * 
     * return "profile"; }
     */

    @GetMapping("/{id}")
    public String viewProfile(@PathVariable Long id, Model model, HttpSession session) {
        UserEntity targetUser = userService.getUserProfile(id);
        if (targetUser == null)
            return "redirect:/";

        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        Long currentUserId = (currentUser != null) ? currentUser.getId() : null;

        // ၁။ Target Profile ပိုင်ရှင် သိမ်းဆည်းထားသော Bookmarks များဆွဲထုတ်ခြင်း
        model.addAttribute("user", targetUser);
        model.addAttribute("bookmarkedSheets", cheatsheetService.findBookmarkedByUserId(id));
        model.addAttribute("sharedLogs", shareService.findSharesByUserId(id));
        // ၂။ Target Profile ပိုင်ရှင် ဖန်တီးထားသော Collections များဆွဲထုတ်ခြင်း
        List<CollectionEntity> rawCollections = collectionService.getCollectionsByInterface(id, 1, 100);

        // 🛡️ Security Check: ကိုယ့် profile ကိုယ်ကြည့်တာမဟုတ်ရင် 'PUBLIC' collection
        // တွေပဲ သီးသန့်စစ်ထုတ်ပြသမည်
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
            @RequestParam("profileImg") MultipartFile profileImg, Principal principal) {
        UserEntity user = userRepository.findById(id);

        String currentUsername = principal.getName();
        UserEntity currentUser = userRepository.findByUsername(currentUsername);

        // 2. Security Validation: Login ဝင်ထားတဲ့သူရဲ့ ID နဲ့ Update လုပ်မယ့် ID တူမှသာ
        // လုပ်ဆောင်ပါ
        if (!currentUser.getId().equals(id)) {
            return "redirect:/error/403"; // တူညီမှုမရှိရင် Access Denied စာမျက်နှာသို့ ပို့ပါ
        }

        // တူညီတယ်ဆိုရင် အောက်ပါ Update လုပ်ငန်းစဉ်များကို ဆက်လုပ်ပါ

        if (!profileImg.isEmpty()) {
            try {
                // Dynamic Path: user.home/app_uploads/profiles/
                String userHome = System.getProperty("user.home");
                String uploadDir = userHome + File.separator + "app_uploads" + File.separator + "profiles"
                        + File.separator;

                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs(); // ဖိုင်တွဲမရှိရင် အလိုလိုဖန်တီးပေးခြင်း
                }

                // File နာမည်ကို Unique ဖြစ်အောင် Timestamp ထည့်ခြင်း (အကြံပြုချက်)
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
        // userService.updateProfile(id, name, bio, profileImg); // ဒီ code
        // ထပ်နေတယ်ဆိုရင် ပြန်စစ်ပါ
        return "redirect:/profile/" + id;
        /*
         * }
         * // UserProfileController.java
         * 
         * @GetMapping("/view/{id}")
         * public String viewProfileDetail(@PathVariable Long id, Model model) {
         * model.addAttribute("profileUser", userService.getUserProfile(id));
         * return "profile-detail"; // profile detail ကို ပြမယ့် jsp နာမည်
         * }
         */

    }
    // 💡 UserProfileController.java ထဲက viewProfile method ကို ဤကုဒ်ဖြင့်
    // အစားထိုးပါဦးဗျာ

    @Autowired
    private com.hibernate.service.CheatsheetService cheatsheetService;
    @Autowired
    private com.hibernate.service.CollectionService collectionService;

}