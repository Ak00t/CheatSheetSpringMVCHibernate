package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CommentService; // Replace with your actual package path

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor // Automatically wires your CommentService bean via constructor injection
public class CommentController {

	private final CommentService commentService;

	@PostMapping("/post")
	public String postComment(@RequestParam("cheatsheetId") Long cheatsheetId, @RequestParam("content") String content,
			@RequestParam(value = "parentId", required = false) Long parentId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		UserEntity user = (UserEntity) session.getAttribute("currentUser");

		CommentEntity newComment = new CommentEntity();
		newComment.setContent(content);
		newComment.setUser(user);

		CheatsheetEntity cheatsheet = new CheatsheetEntity();
		cheatsheet.setId(cheatsheetId);
		newComment.setCheatsheet(cheatsheet);

		if (parentId != null) {
			CommentEntity parentComment = new CommentEntity();
			parentComment.setId(parentId);
			newComment.setParentComment(parentComment);
		}
		// Link to the Cheatsheet context

		commentService.insertComment(newComment);

		redirectAttributes.addFlashAttribute("message", "Posted successfully!");
		return "redirect:/home";
	}

	@PostMapping("/edit")
	public String editComment(@RequestParam("commentId") Long commentId, @RequestParam("content") String newContent,
			HttpSession session, RedirectAttributes redirectAttributes) {
		UserEntity user = (UserEntity) session.getAttribute("currentUser");

		CommentEntity existingComment = commentService.selectCommentById(commentId);

		if (existingComment == null) {
			redirectAttributes.addFlashAttribute("error", "Comment not found.");
			return "redirect:/home";
		}

		// 3. Security Guard Check: Does the owner ID match the logged-in user ID?
		if (!existingComment.getUser().getId().equals(user.getId())) {
			redirectAttributes.addFlashAttribute("error", "Unauthorized! You can only edit your own comments.");
			return "redirect:/home";
		}

		// 4. Update the content and save back to the database
		existingComment.setContent(newContent);
		commentService.updateComment(existingComment); // Uses getSession().merge() under the hood

		redirectAttributes.addFlashAttribute("message", "Comment updated successfully!");
		return "redirect:/home";

	}
}