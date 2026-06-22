package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.CommentService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CheatsheetDetailsController {
	
	private final CommentService commentService;
	 //cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
    private final CheatsheetService cheatsheetService;

    @RequestMapping("/cheatsheet/{id}")
    public String viewDetails(@PathVariable Long id, Model model) {
        
        CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id);
        model.addAttribute("cheatsheet", cheatsheet);
        model.addAttribute(
                "comments",
                commentService.selectCommentById(id));
        return "cheatsheet-detail"; // WEB-INF/views/cheatsheet-detail.jsp သို့ သွားမည်
    }
}