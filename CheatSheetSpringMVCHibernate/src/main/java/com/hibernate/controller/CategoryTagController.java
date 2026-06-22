package com.hibernate.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/category-tags")
    public String categoryTagPage(Model model) {
        List<CategoryEntity> categories = categoryService.findAll();

        model.addAttribute("categories", categories);
        model.addAttribute("category", new CategoryEntity());
        model.addAttribute("tag", new TagEntity());

        return "category-tag-form";
    }

    @PostMapping("/category/save")
    public String saveCategory(@RequestParam(required = false) Long parentId,
                               @ModelAttribute CategoryEntity category) {

        if (parentId != null && parentId != 0) {
            CategoryEntity parent = categoryService.findById(parentId);
            category.setParent(parent);
        }

        category.setCreatedAt(LocalDateTime.now());

        categoryService.save(category);

        return "redirect:/admin/category-tags";
    }

    @PostMapping("/tag/save")
    public String saveTag(@RequestParam Long categoryId,
                          @ModelAttribute TagEntity tag) {

        CategoryEntity category = categoryService.findById(categoryId);
        tag.setCategory(category);

        // login မလုပ်သေးရင် temporary admin user id ထည့်
        UserEntity admin = new UserEntity();
        admin.setId(1L);
        tag.setCreatedBy(admin);

        tag.setCreatedAt(LocalDateTime.now());

        tagService.save(tag);

        return "redirect:/admin/category-tags";
    }
    @GetMapping("/category-list")
    public String categoryListPage(Model model) {

        List<CategoryEntity> categories = categoryService.findAll();
        List<TagEntity> tags = tagService.findAll();

        model.addAttribute("categories", categories);
        model.addAttribute("tags", tags);

        return "category-list";
    }
    @GetMapping("/category/edit/{id}")
    public String editCategory(@PathVariable Long id,
                               Model model) {

        CategoryEntity category =
                categoryService.findById(id);

        model.addAttribute("categories",
                categoryService.findAll());

        model.addAttribute("category",
                category);

        return "category-edit";
    }
    @PostMapping("/category/update")
    public String updateCategory(
            @RequestParam(required = false) Long parentId,
            @ModelAttribute CategoryEntity category) {

        CategoryEntity oldCategory =
                categoryService.findById(category.getId());

        oldCategory.setName(category.getName());
        oldCategory.setDescription(category.getDescription());

        if(parentId != null && parentId != 0) {
            oldCategory.setParent(
                    categoryService.findById(parentId));
        } else {
            oldCategory.setParent(null);
        }

        categoryService.update(oldCategory);

        return "redirect:/admin/category-list";
    }
    @GetMapping("/tag/edit/{id}")
    public String editTag(@PathVariable Long id,
                          Model model) {

        TagEntity tag =
                tagService.findById(id);

        model.addAttribute("categories",
                categoryService.findAll());

        model.addAttribute("tag",
                tag);

        return "tag-edit";
    }
    @PostMapping("/tag/update")
    public String updateTag(
            @RequestParam Long categoryId,
            @ModelAttribute TagEntity tag) {

        TagEntity oldTag =
                tagService.findById(tag.getId());

        oldTag.setName(tag.getName());

        oldTag.setCategory(
                categoryService.findById(categoryId));

        tagService.update(oldTag);

        return "redirect:/admin/category-list";
    }
    @GetMapping("/category/delete/{id}")
    public String deleteCategory(@PathVariable Long id) {
        categoryService.delete(id);
        return "redirect:/admin/category-list";
    }

    @GetMapping("/tag/delete/{id}")
    public String deleteTag(@PathVariable Long id) {
        tagService.delete(id);
        return "redirect:/admin/category-list";
    }
}