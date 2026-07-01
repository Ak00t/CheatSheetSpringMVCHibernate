package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.TagEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CategoryService;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.TagService;
import com.hibernate.service.UserFollowedCategoryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CategoryViewController {
	private final TagService tagService;
	private final CheatsheetService cheatsheetService;
	private final UserFollowedCategoryService
    userFollowedCategoryService;
	
	
	//next homeview childcategory view by parent Id

    private final CategoryService categoryService;

	/*
	 * @RequestMapping("/category/{id}") public String
	 * parentCategoryView(@PathVariable Long id, Model model) {
	 * 
	 * CategoryEntity parentCategory = categoryService.findById(id);
	 * 
	 * model.addAttribute("parentCategory", parentCategory);
	 * 
	 * model.addAttribute("childCategories",
	 * categoryService.findChildrenByParentId(id));
	 * 
	 * return "category-view"; }
	 */
    
    // final
    @RequestMapping("/category/{id}")
    public String parentCategoryView(@PathVariable Long id,
                                     Model model) {

        CategoryEntity parentCategory =
                categoryService.findById(id);

        model.addAttribute(
                "parentCategory",
                parentCategory);

        // Child Categories
        model.addAttribute(
                "childCategories",
                categoryService.findChildrenByParentId(id));

        // Child Count
        model.addAttribute(
                "childCount",
                categoryService.countChildrenByParentId(id));

        // Popular In Parent
        model.addAttribute(
                "popularCheatsheets",
                cheatsheetService
                        .findPopularByParentCategoryId(id));

        // Recent In Parent
        model.addAttribute(
                "recentCheatsheets",
                cheatsheetService
                        .findRecentByParentCategoryId(id));

        return "category-view";
    }
    
    
    
    
    //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
    
    @RequestMapping("/child-category/{id}")
    public String childCategoryView(
            @PathVariable Long id,
            HttpSession session,
            Model model) {

        CategoryEntity childCategory =
                categoryService.findById(id);

        model.addAttribute(
                "childCategory",
                childCategory);

        // Tags
        model.addAttribute(
                "tags",
                tagService
                        .findActiveTagsByCategoryId(id));

        // All Cheatsheets
        model.addAttribute(
                "cheatsheets",
                cheatsheetService
                        .findPublishedCheatsheetsByCategoryId(id));

        // Popular
        model.addAttribute(
                "popularCheatsheets",
                cheatsheetService
                        .findPopularByCategoryId(id));

        // Recent
        model.addAttribute(
                "recentCheatsheets",
                cheatsheetService
                        .findRecentByCategoryId(id));

        // Follow
        UserEntity currentUser =
                (UserEntity)
                        session.getAttribute(
                                "currentUser");

        model.addAttribute(
                "followersCount",
                userFollowedCategoryService
                        .countFollowers(id));

        if (currentUser != null) {

            model.addAttribute(
                    "isFollowing",
                    userFollowedCategoryService
                            .isFollowing(
                                    currentUser.getId(),
                                    id));
        }

        return "child-category-view";
    }
    
    
	/*
	 * @RequestMapping("/child-category/{id}") public String
	 * childCategoryView(@PathVariable Long id, Model model) {
	 * 
	 * CategoryEntity childCategory = categoryService.findById(id);
	 * 
	 * model.addAttribute("childCategory", childCategory);
	 * 
	 * model.addAttribute("tags", tagService.findActiveTagsByCategoryId(id));
	 * 
	 * model.addAttribute("cheatsheets",
	 * cheatsheetService.findPublishedCheatsheetsByCategoryId(id));
	 * 
	 * return "child-category-view"; }
	 */
    
    
    
    
    
    //child tag နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list 
    
 // 🌟 LazyInitializationException ကိုကျော်လွှားပြီး တိုက်ရိုက် Fetch လုပ်ပေးမည့် စနစ်အသစ် 🌟
    
 // child tag နှိပ်ရင်ပေါ်လာမယ့် view -- cheatsheetcard list
    @RequestMapping("/tag/{id}")
    public String tagView(@PathVariable Long id, Model model) {

        // ၁. Tag အချက်အလက်ကို အရင်ယူသည်
        TagEntity tag = tagService.findById(id);

        // ၂. Tag နဲ့ဆိုင်တဲ့ Child Category ကိုယူ
        CategoryEntity childCategory =
                categoryService.findById(
                        tag.getCategory().getId());

        model.addAttribute("childCategory", childCategory);

        // ၃. Sidebar Tags
        model.addAttribute(
                "tags",
                tagService.findActiveTagsByCategoryId(
                        childCategory.getId()));

        // ၄. Main Content - Tag အလိုက် Cheatsheets
        model.addAttribute(
                "cheatsheets",
                cheatsheetService.findPublishedCheatsheetsByTagId(id));

        // ၅. Sidebar Popular
        model.addAttribute(
                "popularCheatsheets",
                cheatsheetService.findPopularByCategoryId(
                        childCategory.getId()));

        // ၆. Sidebar Recent
        model.addAttribute(
                "recentCheatsheets",
                cheatsheetService.findRecentByCategoryId(
                        childCategory.getId()));

        return "child-category-view";
    }
    
    
	/*
	 * @RequestMapping("/tag/{id}") public String tagView(@PathVariable Long id,
	 * Model model) {
	 * 
	 * // ၁. Tag အချက်အလက်ကို အရင်ယူသည် TagEntity tag = tagService.findById(id);
	 * 
	 * // ❌ [အမှား] tag.getCategory() က Lazy ဖြစ်နေလို့ JSP မှာ သုံးရင် Session
	 * ပိတ်ပြီး Error တက်တတ်သည် // CategoryEntity childCategory = tag.getCategory();
	 * 
	 * // 🌟 [အမှန်] categoryService.findById(id) ကို သုံးပြီး အမိ Category ကို
	 * ဆက်ရှင်အရှင်ရှိစဉ် တိုက်ရိုက်ဆွဲထုတ်လိုက်ခြင်း CategoryEntity childCategory =
	 * categoryService.findById(tag.getCategory().getId());
	 * 
	 * model.addAttribute("childCategory", childCategory);
	 * model.addAttribute("tags",
	 * tagService.findActiveTagsByCategoryId(childCategory.getId()));
	 * 
	 * // Tag ID အလိုက် စစ်ထုတ်ထားသော List ကို ပေးပို့ခြင်း
	 * model.addAttribute("cheatsheets",
	 * cheatsheetService.findPublishedCheatsheetsByTagId(id));
	 * 
	 * return "child-category-view"; }
	 */
    
}