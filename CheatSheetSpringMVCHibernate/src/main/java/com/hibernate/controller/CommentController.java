package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CommentService; // Replace with your actual package path
import com.hibernate.service.CommentTranslationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor // Automatically wires your CommentService bean via constructor injection
public class CommentController {

	private final CommentService commentService;
	private final CommentTranslationService commentTranslationService;

	@PostMapping("/post")
	public String postComment(@RequestParam("cheatsheetId") Long cheatsheetId, @RequestParam("content") String content,
			@RequestParam(value = "parentCommentId", required = false) Long parentId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity user = (UserEntity) session.getAttribute("currentUser");

		CommentEntity newComment = new CommentEntity();

		newComment.setContent(content.trim());
		newComment.setUser(user);

		CheatsheetEntity cheatsheet = new CheatsheetEntity();
		cheatsheet.setId(cheatsheetId);
		newComment.setCheatsheet(cheatsheet);

		if (parentId != null) {
			CommentEntity parentComment = new CommentEntity();
			parentComment.setId(parentId);
			newComment.setParentComment(parentComment);
		}

		commentService.insertComment(newComment);

		redirectAttributes.addFlashAttribute("message", "Posted successfully!");
		return "redirect:/cheatsheet/" + cheatsheetId;
	}

	@PostMapping("/edit")

	public String editComment(@RequestParam("commentId") Long commentId, @RequestParam("content") String newContent,
			HttpSession session, RedirectAttributes redirectAttributes) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");

		CommentEntity existingComment = commentService.selectCommentById(commentId);

		if (existingComment == null) {
			redirectAttributes.addFlashAttribute("error", "Comment not found.");
			return "redirect:/";
		}

		if (!existingComment.getUser().getId().equals(user.getId())) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized! You can only edit your own comments.");
			return "redirect:/";
		}

		existingComment.setContent(newContent);
		commentService.updateComment(existingComment);

		redirectAttributes.addFlashAttribute("message", "Comment updated successfully!");
		return "redirect:/";

	}

	@GetMapping(value = "/translate", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> translateComment(@RequestParam("commentId") Long commentId,
			@RequestParam("lang") String targetLang) {

		// 1. Fetch the original comment entity from the database
		CommentEntity comment = commentService.selectCommentById(commentId);

		// Safety check to ensure the comment actually exists
		if (comment == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Error: Comment not found");
		}

		// 2. Pass it through the caching manager to get the translation payload
		try {
			String translatedResult = commentTranslationService.getOrFetchTranslation(comment, targetLang);
			return ResponseEntity.ok(translatedResult);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
						.body("Translation processing crashed: " + e.getMessage());
		}
	}
}