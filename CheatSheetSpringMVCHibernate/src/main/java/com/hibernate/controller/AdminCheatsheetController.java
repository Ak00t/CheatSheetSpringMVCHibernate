package com.hibernate.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.TagEntity;
import com.hibernate.service.AdminCheatsheetService;

@Controller
@RequestMapping("/admin/cheatsheet") // 👈 Sidebar က လှမ်းခေါ်မယ့် ဗဟိုလမ်းကြောင်း
public class AdminCheatsheetController {

    @Autowired
    private AdminCheatsheetService adminCheatsheetService;

    // ✅ Sidebar က /admin/cheatsheet လို့ နှိပ်လိုက်ရင် ဒီ Method ထဲ တည့်တည့်ဝင်လာပါမယ်
    @GetMapping
    public String showAdminCheatsheetPanel(Model model) {
        List<CheatsheetEntity> cheatsheets = adminCheatsheetService.getAllCheatsheets();
        List<CategoryEntity> categories = adminCheatsheetService.getAllCategories();
        List<TagEntity> tags = adminCheatsheetService.getAllTags();

        model.addAttribute("adminCheatsheets", cheatsheets);
        model.addAttribute("categories", categories);
        model.addAttribute("tags", tags);

        return "admin-cheatsheet-management"; // မင်းရဲ့ JSP File နာမည်
    }

  
    @PostMapping("/delete/{id}")
    public String removeCheatsheet(@PathVariable("id") Long id) {
        adminCheatsheetService.deleteCheatsheet(id);
        return "redirect:/admin/cheatsheet";
    }
}