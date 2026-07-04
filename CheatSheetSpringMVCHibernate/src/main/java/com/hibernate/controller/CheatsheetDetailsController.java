package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.ReferenceType;
import com.hibernate.service.BookmarkService;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.CommentService;
import com.hibernate.service.LikeService;
import com.hibernate.service.NotificationService;
import com.hibernate.service.RatingService;
import com.hibernate.service.ReportService;
import com.hibernate.service.ShareService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CheatsheetDetailsController {

	private final CommentService commentService;
	private final CheatsheetService cheatsheetService;
	private final LikeService likeService;
	private final RatingService ratingService;
	private final ReportService reportService;
	private final BookmarkService bookmarkService;
	private final ShareService shareService;
	private final NotificationService notiService;

	@RequestMapping("/cheatsheet/{id}")
	public String viewDetails(@PathVariable Long id, Model model, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		Long userId = (user != null) ? user.getId() : null;

		CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id);
		model.addAttribute("cheatsheet", cheatsheet);
		model.addAttribute("comments", commentService.selectCommentsByCheatsheetId(id));
		model.addAttribute("isBookmarked", userId != null && bookmarkService.isBookmarked(userId, id));
		model.addAttribute("isLiked", userId != null && likeService.isLiked(userId, id));
		model.addAttribute("likeCount", likeService.countLikes(id));
		return "cheatsheet-detail";
	}

	@PostMapping("/cheatsheet/bookmark")
	public String toggleBookmark(@RequestParam Long cheatsheetId, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		if (user != null) {
			bookmarkService.toggleBookmark(user.getId(), cheatsheetId);
		}
		return "redirect:/cheatsheet/" + cheatsheetId;
	}

	@PostMapping("/cheatsheet/share-log")
	@ResponseBody
	public String logCheatsheetShare(@RequestParam Long cheatsheetId, @RequestParam String platform,
			HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		if (user != null) {
			shareService.saveShareLog(user.getId(), cheatsheetId, platform);
			return "Logged Successfully";
		}
		return "User not logged in";
	}

	// 💡 Manage Button နှင့် Header က လှမ်းလာမယ့် စုစုပေါင်း Bookmark ပြသပေးမည့်
	// API
	@GetMapping("/profile/bookmarks")
	public String viewUserBookmarks(Model model, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		if (user == null) {
			return "redirect:/";
		}
		model.addAttribute("bookmarkedSheets", cheatsheetService.findBookmarkedByUserId(user.getId()));
		return "user-bookmarks";
	}

	@PostMapping("/cheatsheet/like")
	public String toggleLike(@RequestParam Long cheatsheetId, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		CheatsheetEntity cheatsheet = cheatsheetService.findById(cheatsheetId);
		UserEntity targetUserToNotify = null;
		String notiMessage = "";
		if (user != null) {
			notiMessage = user.getName() + " liked your cheatsheet";
			targetUserToNotify = cheatsheet.getUser();
			likeService.toggleLike(user.getId(), cheatsheetId);
			if (targetUserToNotify != null && !user.getId().equals(targetUserToNotify.getId())) {
				notiService
						.createAndSendNotification("You got like", notiMessage, "LIKE", ReferenceType.CHEATSHEET,
								cheatsheetId, targetUserToNotify.getId(), user.getId());
			}
		}
		return "redirect:/cheatsheet/" + cheatsheetId;

	}

	@PostMapping("/cheatsheet/rate")
	public String submitRating(@RequestParam Long cheatsheetId, @RequestParam Integer score, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		if (user != null) {
			ratingService.addRating(user.getId(), cheatsheetId, score);
		}
		return "redirect:/cheatsheet/" + cheatsheetId;
	}

	@PostMapping("/report/submit")
	public String submitReport(@RequestParam Long targetId, @RequestParam String reason,
			@RequestParam(required = false) String description, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");
		if (user != null) {
			reportService.saveReport(user.getId(), targetId, reason, description);
		}
		return "redirect:/cheatsheet/" + targetId;
	}
	// 💡 CheatsheetDetailsController.java ၏ အတွင်းထဲတွင် ဤ API လိုင်းသစ်အား
	// ဖြည့်စွက်ပါ

}