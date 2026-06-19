package com.hibernate.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.dto.CheatsheetFormDto;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CheatsheetService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/cheatsheet")
@RequiredArgsConstructor
public class CheatsheetController {

    private final CheatsheetService cheatsheetService;

    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        model.addAttribute("cheatsheetForm", new CheatsheetFormDto());
        return "create-cheatsheet"; 
    }

    @PostMapping("/save")
    public String saveCheatsheet(@ModelAttribute("cheatsheetForm") CheatsheetFormDto formDto, HttpSession session) {
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        cheatsheetService.createNewCheatsheet(formDto, loginUser);
        return "redirect:/cheatsheet/explore";
    }

   
    @GetMapping("/explore")
    public String exploreAllCheatsheets(Model model, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        
        List<CheatsheetEntity> list = cheatsheetService.getAllCheatsheets();
        model.addAttribute("cheatsheets", list);
        return "admin-cheatsheet-explore"; 
    }
}