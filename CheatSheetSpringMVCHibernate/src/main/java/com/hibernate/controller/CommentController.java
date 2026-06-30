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
import com.hibernate.entity.enums.ReferenceType;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.CommentService;
import com.hibernate.service.CommentTranslationService;
import com.hibernate.service.NotificationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {

	private final CommentService commentService;
	private final CommentTranslationService commentTranslationService;
	private final NotificationService notiService;
	private final CheatsheetService cheatsheetService;

	@PostMapping("/post")
	public String postComment(@RequestParam("cheatsheetId") Long cheatsheetId, @RequestParam("content") String content,
			@RequestParam(value = "parentCommentId", required = false) Long parentId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");

		// 1. Fetch the real, fully-populated Cheatsheet
		CheatsheetEntity cheatsheet = cheatsheetService.findById(cheatsheetId);
		if (cheatsheet == null) {
			redirectAttributes.addFlashAttribute("error", "Cheatsheet not found!");
			return "redirect:/";
		}

		CommentEntity newComment = new CommentEntity();
		newComment.setContent(content.trim());
		newComment.setUser(currentUser);
		newComment.setCheatsheet(cheatsheet);

		// Variables to track who needs to be notified
		UserEntity targetUserToNotify = null;
		String notificationMessage = "";

		// 2. Determine if this is a Reply or a Root Comment
		if (parentId != null) {
			// Fetch the full parent comment from your database
			CommentEntity parentComment = commentService.selectCommentById(parentId);

			if (parentComment != null) {
				newComment.setParentComment(parentComment);

				// Target receiver becomes the author of the parent comment
				targetUserToNotify = parentComment.getUser();
				notificationMessage = currentUser.getName() + " replied to your comment on \"" + cheatsheet.getTitle()
						+ "\".";
			}
		} else {
			targetUserToNotify = cheatsheet.getUser();
			notificationMessage = currentUser.getName() + " commented on your cheatsheet: \"" + cheatsheet.getTitle()
					+ "\".";
		}

		commentService.insertComment(newComment);

		if (targetUserToNotify != null && !currentUser.getId().equals(targetUserToNotify.getId())) {

			notiService
					.createAndSendNotification(parentId != null ? "New Reply" : "New Comment", notificationMessage,
							"COMMENT", ReferenceType.CHEATSHEET, cheatsheetId, targetUserToNotify.getId(),
							currentUser.getId());
		}

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
		Long cheatsheetId = existingComment.getCheatsheet().getId();

		existingComment.setContent(newContent.trim());
		commentService.updateComment(existingComment);

		redirectAttributes.addFlashAttribute("message", "Comment updated successfully!");
		return "redirect:/cheatsheet/" + cheatsheetId;

	}

	@PostMapping("/delete")
	public String deleteComment(@RequestParam("commentId") Long commentId, HttpSession session,
			RedirectAttributes redirectAttributes) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");

		CommentEntity existingComment = commentService.selectCommentById(commentId);

		if (existingComment == null) {
			redirectAttributes.addFlashAttribute("error", "Comment not found.");
			return "redirect:/";
		}

		if (!existingComment.getUser().getId().equals(user.getId())) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized! You can only delete your own comments.");
			return "redirect:/";
		}
		Long cheatsheetId = existingComment.getCheatsheet().getId();

		commentService.deleteComment(commentId);
		redirectAttributes.addFlashAttribute("message", "Comment deleted successfully!");
		return "redirect:/cheatsheet/" + cheatsheetId;
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