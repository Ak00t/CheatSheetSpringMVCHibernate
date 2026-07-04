package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.TagEntity;
import com.hibernate.service.CategoryService;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.TagService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CategoryViewController {
	private final TagService tagService;
	private final CheatsheetService cheatsheetService;
	
	
	//next homeview childcategory view by parent Id

    private final CategoryService categoryService;

    @RequestMapping("/category/{id}")
    public String parentCategoryView(@PathVariable Long id,
                                     Model model) {

        CategoryEntity parentCategory =
                categoryService.findById(id);

        model.addAttribute("parentCategory", parentCategory);

        model.addAttribute("childCategories",
                categoryService.findChildrenByParentId(id));

        return "category-view";
    }
    
    //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
    
    @RequestMapping("/child-category/{id}")
    public String childCategoryView(@PathVariable Long id,
                                    Model model) {

        CategoryEntity childCategory =
                categoryService.findById(id);

        model.addAttribute("childCategory", childCategory);

        model.addAttribute("tags",
                tagService.findActiveTagsByCategoryId(id));

        model.addAttribute("cheatsheets",
                cheatsheetService.findPublishedCheatsheetsByCategoryId(id));

        return "child-category-view";
    }
    
    //child tag နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list 
    
 // 🌟 LazyInitializationException ကိုကျော်လွှားပြီး တိုက်ရိုက် Fetch လုပ်ပေးမည့် စနစ်အသစ် 🌟
    @RequestMapping("/tag/{id}")
    public String tagView(@PathVariable Long id, Model model) {
        
        // ၁. Tag အချက်အလက်ကို အရင်ယူသည်
        TagEntity tag = tagService.findById(id);
        
        // ❌ [အမှား] tag.getCategory() က Lazy ဖြစ်နေလို့ JSP မှာ သုံးရင် Session ပိတ်ပြီး Error တက်တတ်သည်
        // CategoryEntity childCategory = tag.getCategory();
        
        // 🌟 [အမှန်] categoryService.findById(id) ကို သုံးပြီး အမိ Category ကို ဆက်ရှင်အရှင်ရှိစဉ် တိုက်ရိုက်ဆွဲထုတ်လိုက်ခြင်း
        CategoryEntity childCategory = categoryService.findById(tag.getCategory().getId());

        model.addAttribute("childCategory", childCategory);
        model.addAttribute("tags", tagService.findActiveTagsByCategoryId(childCategory.getId()));
        
        // Tag ID အလိုက် စစ်ထုတ်ထားသော List ကို ပေးပို့ခြင်း
        model.addAttribute("cheatsheets", cheatsheetService.findPublishedCheatsheetsByTagId(id));

        return "child-category-view"; 
    }
    
    
}