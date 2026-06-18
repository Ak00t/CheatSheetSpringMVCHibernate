package com.hibernate.controller;

import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hibernate.entity.LikeEntity;


import com.hibernate.service.LikeService;

import lombok.RequiredArgsConstructor;




@Controller
@RequiredArgsConstructor
@RequestMapping("/likes")

public class LikeController {
	@Autowired
	private  LikeService likeService;
	
	
	@PostMapping("/toggle")
	public String toggleLike(@RequestParam("cheatsheetId") Long cheatsheetId, 
            HttpSession session, 
            RedirectAttributes redirectAttributes) {
		
		
		
		
		/*
		 * UserEntity userId=new UserEntity(); userId.setId(1l);
		 */
      
Long userId = (Long) session.getAttribute("userId");
        
        // User Login ဝင်ထားသလား စစ်ဆေးခြင်း
        if (userId == null) {
            redirectAttributes.addFlashAttribute("message", "Like လုပ်ရန် Login ဝင်ပေးပါ");
            return "redirect:/login";
        }

        // Service ကိုခေါ်ပြီး Like/Unlike ပြုလုပ်ခြင်း
       // likeService.toggleLike(userId, cheatsheetId);
        likeService.toggleLike(1l, 1l);
        return "redirect:/Like/view/" + cheatsheetId;
    }
	@GetMapping("/list")
    public String getAlllike(Model m) {
    	List<LikeEntity> list=likeService.getAlllike();
    	m.addAttribute("likeObj",list);
    	return "Like";
    	}
			}
