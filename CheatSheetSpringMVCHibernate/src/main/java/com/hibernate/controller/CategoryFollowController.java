package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserFollowedCategoryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CategoryFollowController {

    private final UserFollowedCategoryService
            userFollowedCategoryService;

    @PostMapping("/category/follow/{categoryId}")
    public String follow(
            @PathVariable Long categoryId,
            HttpSession session) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute(
                        "currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        userFollowedCategoryService.follow(
                currentUser.getId(),
                categoryId);

        return "redirect:/child-category/"
                + categoryId;
    }

    @PostMapping("/category/unfollow/{categoryId}")
    public String unfollow(
            @PathVariable Long categoryId,
            HttpSession session) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute(
                        "currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        userFollowedCategoryService.unfollow(
                currentUser.getId(),
                categoryId);

        return "redirect:/child-category/"
                + categoryId;
    }
 
 	@GetMapping("/category/followed-list")
 	public String viewFollowedCategories(HttpSession session, Model model) {
 		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
 		if (currentUser == null) {
 			return "redirect:/?unauthorized=true";
 		}

 		java.util.List<com.hibernate.entity.CategoryEntity> followedCategories = 
 				userFollowedCategoryService.findFollowedCategoriesByUserId(currentUser.getId());

 		model.addAttribute("followedCategories", followedCategories);
 		return "followed-categories-list"; 
 	}
}