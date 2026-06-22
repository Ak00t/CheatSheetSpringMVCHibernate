package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.CheatsheetRepository;
import com.hibernate.repository.CommentRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final CheatsheetRepository cheatsheetRepository;

    @Override
    public void saveComment(Long cheatsheetId,
                            String content) {

        CheatsheetEntity cheatsheet =
                cheatsheetRepository.findById(cheatsheetId);

        UserEntity user = new UserEntity();
        user.setId(1L); // later loginUser.id

        CommentEntity comment = new CommentEntity();
        comment.setCheatsheet(cheatsheet);
        comment.setUser(user);
        comment.setContent(content);
        comment.setCreatedAt(LocalDateTime.now());
        comment.setUpdatedAt(LocalDateTime.now());

        commentRepository.save(comment);
    }

    @Override
    public void saveReply(Long cheatsheetId,
                          Long parentCommentId,
                          String content) {

        CheatsheetEntity cheatsheet =
                cheatsheetRepository.findById(cheatsheetId);

        CommentEntity parent =
                commentRepository.findById(parentCommentId);

        UserEntity user = new UserEntity();
        user.setId(1L); // later loginUser.id

        CommentEntity reply = new CommentEntity();
        reply.setCheatsheet(cheatsheet);
        reply.setUser(user);
        reply.setParentComment(parent);
        reply.setContent(content);
        reply.setCreatedAt(LocalDateTime.now());
        reply.setUpdatedAt(LocalDateTime.now());

        commentRepository.save(reply);
    }

    @Override
    public void editComment(Long commentId,
                            Long loginUserId,
                            String content) {

        CommentEntity comment =
                commentRepository.findById(commentId);

        if (comment == null) {
            return;
        }

        Long commentOwnerId =
                comment.getUser().getId();

        boolean isCommentOwner =
                commentOwnerId.equals(loginUserId);

        if (isCommentOwner) {
            comment.setContent(content);
            comment.setUpdatedAt(LocalDateTime.now());
            commentRepository.update(comment);
        }
    }

    @Override
    public void deleteComment(Long commentId,
                              Long loginUserId) {

        CommentEntity comment =
                commentRepository.findById(commentId);

        if (comment == null) {
            return;
        }

        Long commentOwnerId =
                comment.getUser().getId();

        Long cheatsheetOwnerId =
                comment.getCheatsheet()
                       .getUser()
                       .getId();

        boolean isCheatsheetOwner =
                cheatsheetOwnerId.equals(loginUserId);

        boolean isCommentOwner =
                commentOwnerId.equals(loginUserId);

        boolean isParentCommentOwner = false;

        if (comment.getParentComment() != null) {

            Long parentOwnerId =
                    comment.getParentComment()
                           .getUser()
                           .getId();

            isParentCommentOwner =
                    parentOwnerId.equals(loginUserId);
        }

        if (isCheatsheetOwner ||
            isCommentOwner ||
            isParentCommentOwner) {

            commentRepository.delete(comment);
        }
    }

    @Override
    public List<CommentEntity> getRootComments(Long cheatsheetId) {
        return commentRepository.findRootComments(cheatsheetId);
    }

    @Override
    public List<CommentEntity> getReplies(Long parentCommentId) {
        return commentRepository.findReplies(parentCommentId);
    }
}