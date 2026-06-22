package com.hibernate.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.DTO.CheatsheetFormDto;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.UserRole;
import com.hibernate.service.CheatsheetService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/cheatsheet")
@RequiredArgsConstructor
public class AdminCheatsheetController {

    private final CheatsheetService cheatsheetService;

    private boolean isAdmin(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        return user != null && (user.getRole() == UserRole.ADMIN || user.getRole() == UserRole.MODERATOR);
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        
        CheatsheetEntity cheatsheet = cheatsheetService.getById(id);
        if (cheatsheet == null) return "redirect:/cheatsheet/explore";
        
        CheatsheetFormDto formDto = new CheatsheetFormDto();
        formDto.setTitle(cheatsheet.getTitle());
        formDto.setDescription(cheatsheet.getDescription());
        formDto.setVisibility(cheatsheet.getVisibility().name());
        formDto.setThemeColor(cheatsheet.getThemeColor());
        if (cheatsheet.getCategory() != null) {
            formDto.setCategoryId(cheatsheet.getCategory().getId());
        }
        
        model.addAttribute("cheatsheetForm", formDto);
        model.addAttribute("currentStatus", cheatsheet.getStatus().name());
        model.addAttribute("cheatsheetId", id);
        return "admin-cheatsheet-edit"; 
    }

    @PostMapping("/update/{id}")
    public String updateCheatsheet(
            @PathVariable("id") Long id,
            @ModelAttribute("cheatsheetForm") CheatsheetFormDto formDto,
            @RequestParam("status") String contentStatus,
            HttpSession session) {
        
        if (!isAdmin(session)) return "redirect:/login";
        
        cheatsheetService.updateCheatsheetByAdmin(id, formDto, contentStatus);
        return "redirect:/cheatsheet/explore";
    }

    @GetMapping("/delete/{id}")
    public String deleteCheatsheet(@PathVariable("id") Long id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        
        cheatsheetService.deleteCheatsheet(id);
        return "redirect:/cheatsheet/explore";
    }
}