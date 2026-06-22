package com.hibernate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.service.CommentService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    // Create Comment
    @PostMapping("/create")
    public String createComment(
            @RequestParam Long cheatsheetId,
            @RequestParam String content) {

        commentService.saveComment(
                cheatsheetId,
                content);

        return "redirect:/cheatsheet/" + cheatsheetId;
    }

    // Reply
    @PostMapping("/reply")
    public String createReply(
            @RequestParam Long cheatsheetId,
            @RequestParam Long parentCommentId,
            @RequestParam String content) {

        commentService.saveReply(
                cheatsheetId,
                parentCommentId,
                content);

        return "redirect:/cheatsheet/" + cheatsheetId;
    }

    // Edit
    @PostMapping("/edit")
    public String editComment(
            @RequestParam Long commentId,
            @RequestParam Long cheatsheetId,
            @RequestParam String content) {

        Long loginUserId = 1L; // later session user

        commentService.editComment(
                commentId,
                loginUserId,
                content);

        return "redirect:/cheatsheet/" + cheatsheetId;
    }

    // Delete
    @PostMapping("/delete")
    public String deleteComment(
            @RequestParam Long commentId,
            @RequestParam Long cheatsheetId) {

        Long loginUserId = 1L; // later session user

        commentService.deleteComment(
                commentId,
                loginUserId);

        return "redirect:/cheatsheet/" + cheatsheetId;
    }
}