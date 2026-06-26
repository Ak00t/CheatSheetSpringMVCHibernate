package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.CommentService;
import com.hibernate.service.LikeService;
import com.hibernate.service.RatingService;
import com.hibernate.service.ReportService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@Transactional
public class CheatsheetDetailsController {
	
	private final CommentService commentService;
	 //cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
    private final CheatsheetService cheatsheetService;
    private final LikeService likeService;
    private final RatingService ratingService;
    private final ReportService reportService;
    @RequestMapping("/cheatsheet/{id}")
    public String viewDetails(@PathVariable Long id, Model model,HttpSession session) {
        UserEntity user=(UserEntity) session.getAttribute("currentUser");
        Long userId = (user != null) ? user.getId() : null;
        
        CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id);
        model.addAttribute("comments", commentService.selectCommentById(id));
        
        
        model.addAttribute("cheatsheet", cheatsheet);
        model.addAttribute(
                "comments",
                commentService.selectCommentById(id));
        

        
        model.addAttribute("isLiked", userId != null && likeService.isLiked(userId, id));
        model.addAttribute("likeCount", likeService.countLikes(id));
        return "cheatsheet-detail"; // WEB-INF/views/cheatsheet-detail.jsp သို့ သွားမည်
    }
    @PostMapping("/cheatsheet/like")
    public String toggleLike(@RequestParam Long cheatsheetId, HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("currentUser");
        if (user != null) {
            likeService.toggleLike(user.getId(), cheatsheetId);
        }
        return "redirect:/cheatsheet/" + cheatsheetId;
    }
    @PostMapping("/cheatsheet/rate")
    public String submitRating(@RequestParam Long cheatsheetId, 
                               @RequestParam Integer score, 
                               HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("currentUser");
        if (user != null) {
            ratingService.addRating(user.getId(), cheatsheetId, score);
        }
        return "redirect:/cheatsheet/" + cheatsheetId;
    }
    @PostMapping("/report/submit")
    public String submitReport(@RequestParam Long targetId,
                               @RequestParam String reason,
                               @RequestParam(required = false) String description,
                               HttpSession session) {
        
        // Login ဝင်ထားတဲ့ User ကို စစ်ဆေးခြင်း
        UserEntity user = (UserEntity) session.getAttribute("currentUser");
        
        if (user != null) {
            // Service ကို အချက်အလက်များ ပို့ပေးခြင်း
            reportService.saveReport(user.getId(), targetId, reason, description);
        }
        
        // Report တင်ပြီးရင် Cheatsheet page ကို ပြန်သွားမယ်
        return "redirect:/cheatsheet/" + targetId;
    }

}