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

    @GetMapping({"/category-tags", "/taxonomy"})
    public String categoryTagPage(Model model) {

        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("tags", tagService.findAll());

        if (!model.containsAttribute("category")) {
            model.addAttribute("category", new CategoryEntity());
        }

        if (!model.containsAttribute("tag")) {
            model.addAttribute("tag", new TagEntity());
        }

        return "category-tag-form";
    }

    @PostMapping("/category/save")
    public String saveCategory(
            @ModelAttribute("category") CategoryEntity category,
            Model model) {

        try {
            if (categoryService.existsBySlug(category.getSlug())) {
                model.addAttribute(
                        "errorMessage",
                        "🚨 Category slug already exists. Please use another slug.");

                model.addAttribute("categories", categoryService.findAll());
                model.addAttribute("tags", tagService.findAll());
                model.addAttribute("category", category);
                model.addAttribute("tag", new TagEntity());

                return "category-tag-form";
            }

            if (category.getParent() != null
                    && category.getParent().getId() != null
                    && category.getParent().getId() != 0) {

                CategoryEntity parent =
                        categoryService.findById(category.getParent().getId());

                category.setParent(parent);
            } else {
                category.setParent(null);
            }

            category.setCreatedAt(LocalDateTime.now());
            categoryService.save(category);

            return "redirect:/admin/category-tags";

        } catch (Exception ex) {
            model.addAttribute(
                    "errorMessage",
                    "🚨 Category already exists or duplicate data detected.");

            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("tags", tagService.findAll());
            model.addAttribute("category", category);
            model.addAttribute("tag", new TagEntity());

            return "category-tag-form";
        }
    }

    @PostMapping("/tag/save")
    public String saveTag(
            @RequestParam Long categoryId,
            @ModelAttribute("tag") TagEntity tag,
            Model model) {

        try {
            CategoryEntity category =
                    categoryService.findById(categoryId);

            tag.setCategory(category);

            UserEntity admin = new UserEntity();
            admin.setId(1L);
            tag.setCreatedBy(admin);

            tag.setCreatedAt(LocalDateTime.now());
            tagService.save(tag);

            return "redirect:/admin/category-tags";

        } catch (Exception ex) {
            model.addAttribute(
                    "errorMessage",
                    "🚨 Tag already exists or duplicate data detected.");

            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("tags", tagService.findAll());
            model.addAttribute("category", new CategoryEntity());
            model.addAttribute("tag", tag);

            return "category-tag-form";
        }
    }

    @GetMapping("/category/edit/{id}")
    public String editCategory(
            @PathVariable Long id,
            Model model) {

        CategoryEntity category =
                categoryService.findById(id);

        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("category", category);

        return "category-edit";
    }

    @PostMapping("/category/update")
    public String updateCategory(
            @RequestParam(value = "parentId", required = false) Long parentId,
            @ModelAttribute CategoryEntity category,
            Model model) {

        CategoryEntity oldCategory =
                categoryService.findById(category.getId());

        try {
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

        } catch (Exception ex) {
            model.addAttribute(
                    "errorMessage",
                    "🚨 Category update failed. Name or slug already exists.");

            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("category", oldCategory);

            return "category-edit";
        }
    }

    @GetMapping("/tag/edit/{id}")
    public String editTag(
            @PathVariable Long id,
            Model model) {

        TagEntity tag =
                tagService.findById(id);

        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("tag", tag);

        return "tag-edit";
    }

	/*
	 * @PostMapping("/tag/update") public String updateTag(
	 * 
	 * @RequestParam Long categoryId,
	 * 
	 * @ModelAttribute TagEntity tag, Model model) {
	 * 
	 * TagEntity oldTag = tagService.findById(tag.getId());
	 * 
	 * try { oldTag.setName(tag.getName());
	 * oldTag.setCategory(categoryService.findById(categoryId));
	 * 
	 * tagService.update(oldTag);
	 * 
	 * return "redirect:/admin/category-tags";
	 * 
	 * } catch (Exception ex) { model.addAttribute( "errorMessage",
	 * "🚨 Tag update failed. Tag name already exists.");
	 * 
	 * model.addAttribute("categories", categoryService.findAll());
	 * model.addAttribute("tag", oldTag);
	 * 
	 * return "tag-edit"; } }
	 */
    
    @PostMapping("/tag/update")
    public String updateTag(
            @RequestParam Long categoryId,
            @ModelAttribute TagEntity tag,
            Model model) {

        TagEntity oldTag =
                tagService.findById(tag.getId());

        if (tagService.existsByNameAndCategoryId(
                tag.getName(),
                categoryId,
                tag.getId())) {

            oldTag.setName(tag.getName());
            oldTag.setCategory(
                    categoryService.findById(categoryId));

            model.addAttribute(
                    "errorMessage",
                    "🚨 This tag already exists in this category.");

            model.addAttribute(
                    "categories",
                    categoryService.findAll());

            model.addAttribute(
                    "tag",
                    oldTag);

            return "tag-edit";
        }

        oldTag.setName(tag.getName());
        oldTag.setCategory(
                categoryService.findById(categoryId));

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