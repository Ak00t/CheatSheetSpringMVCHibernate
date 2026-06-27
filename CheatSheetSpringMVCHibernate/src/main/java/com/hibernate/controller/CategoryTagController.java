package com.hibernate.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.TagEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CategoryService;
import com.hibernate.service.TagService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class CategoryTagController {

    private final CategoryService categoryService;
    private final TagService tagService;

    @GetMapping({"/category-tags", "/taxonomy"})
    public String categoryTagPage(Model model) {
        List<CategoryEntity> categories = categoryService.findAll();
        List<TagEntity> tags = tagService.findAll();

        model.addAttribute("categories", categories);
        model.addAttribute("tags", tags);
        
        if (!model.containsAttribute("category")) {
            model.addAttribute("category", new CategoryEntity());
        }
        if (!model.containsAttribute("tag")) {
            model.addAttribute("tag", new TagEntity());
        }

        return "category-tag-form";
    }

    @PostMapping("/category/save")
    public String saveCategory(@ModelAttribute("category") CategoryEntity category,
                               RedirectAttributes redirectAttributes) {
        try {
            // Slug ရှိမရှိ စစ်ဆေးခြင်း
            boolean isSlugExist = categoryService.existsBySlug(category.getSlug());
            if (isSlugExist) {
                redirectAttributes.addFlashAttribute("errorMessage", "🚨 Error: URL Slug Identifier already exists in Database!");
                redirectAttributes.addFlashAttribute("category", category);
                return "redirect:/admin/category-tags";
            }

            // HTML Form က 'parent.id' ကို auto-bind လုပ်ပေးထားလို့ အောက်ပါအတိုင်း တိုက်ရိုက်စစ်ရပါမယ်
            if (category.getParent() != null && category.getParent().getId() != null && category.getParent().getId() != 0) {
                CategoryEntity parent = categoryService.findById(category.getParent().getId());
                category.setParent(parent);
            } else {
                category.setParent(null); // Root Node ဖြစ်လျှင် null သတ်မှတ်မယ်
            }

            category.setCreatedAt(LocalDateTime.now());
            categoryService.save(category);

        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", "🚨 Database Constraint Error: Duplicate entry detected!");
            redirectAttributes.addFlashAttribute("category", category);
            return "redirect:/admin/category-tags";
        }

        return "redirect:/admin/category-tags";
    }

    @PostMapping("/tag/save")
    public String saveTag(@RequestParam Long categoryId,
                          @ModelAttribute("tag") TagEntity tag,
                          RedirectAttributes redirectAttributes) {
        try {
            CategoryEntity category = categoryService.findById(categoryId);
            tag.setCategory(category);

            UserEntity admin = new UserEntity();
            admin.setId(1L);
            tag.setCreatedBy(admin);

            tag.setCreatedAt(LocalDateTime.now());
            tagService.save(tag);
            
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("errorMessage", "🚨 Database Constraint Error: Tag entry details conflict!");
            redirectAttributes.addFlashAttribute("tag", tag);
            return "redirect:/admin/category-tags";
        }

        return "redirect:/admin/category-tags";
    }

    @GetMapping("/category/edit/{id}")
    public String editCategory(@PathVariable Long id, Model model) {
        CategoryEntity category = categoryService.findById(id);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("category", category);

        return "category-edit";
    }

    @PostMapping("/category/update")
    public String updateCategory(@RequestParam(value = "parentId", required = false) Long parentId,
                                 @ModelAttribute CategoryEntity category) {

        CategoryEntity oldCategory = categoryService.findById(category.getId());
        oldCategory.setName(category.getName());
        oldCategory.setDescription(category.getDescription());
        oldCategory.setSlug(category.getSlug());

        if (parentId != null && parentId != 0) {
            oldCategory.setParent(categoryService.findById(parentId));
        } else {
            oldCategory.setParent(null);
        }

        categoryService.update(oldCategory);
        return "redirect:/admin/category-tags";
    }

    @GetMapping("/tag/edit/{id}")
    public String editTag(@PathVariable Long id, Model model) {
        TagEntity tag = tagService.findById(id);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("tag", tag);

        return "tag-edit";
    }

    @PostMapping("/tag/update")
    public String updateTag(@RequestParam Long categoryId,
                            @ModelAttribute TagEntity tag) {

        TagEntity oldTag = tagService.findById(tag.getId());
        oldTag.setName(tag.getName());
        oldTag.setCategory(categoryService.findById(categoryId));

        tagService.update(oldTag);
        return "redirect:/admin/category-tags";
    }

    @GetMapping("/category/delete/{id}")
    public String deleteCategory(@PathVariable Long id) {
        categoryService.delete(id);
        return "redirect:/admin/category-tags";
    }

    @GetMapping("/tag/delete/{id}")
    public String deleteTag(@PathVariable Long id) {
        tagService.delete(id);
        return "redirect:/admin/category-tags";
    }
}