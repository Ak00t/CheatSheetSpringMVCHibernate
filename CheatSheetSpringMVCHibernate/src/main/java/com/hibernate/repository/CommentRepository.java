package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.CommentEntity;

public interface CommentRepository {

    Long save(CommentEntity comment);

    void update(CommentEntity comment);

    void delete(CommentEntity comment);

    CommentEntity findById(Long id);

    List<CommentEntity> findRootComments(Long cheatsheetId);

    List<CommentEntity> findReplies(Long parentCommentId);
}