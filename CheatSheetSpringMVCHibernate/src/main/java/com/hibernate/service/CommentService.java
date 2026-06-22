package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.CommentEntity;

public interface CommentService {

    // Create
    void saveComment(Long cheatsheetId,
                     String content);

    // Reply
    void saveReply(Long cheatsheetId,
                   Long parentCommentId,
                   String content);

    // Edit
    void editComment(Long commentId,
                     Long loginUserId,
                     String content);

    // Delete
    void deleteComment(Long commentId,
                       Long loginUserId);

    // List
    List<CommentEntity> getRootComments(Long cheatsheetId);

    List<CommentEntity> getReplies(Long parentCommentId);
}