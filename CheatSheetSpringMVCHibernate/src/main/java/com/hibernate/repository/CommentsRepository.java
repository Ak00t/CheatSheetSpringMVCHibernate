package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.CommentEntity;

public interface CommentsRepository {

	public List<CommentEntity> selectCommentsByCheatsheetId(Long cheatsheetId);

	public Long insertComment(CommentEntity obj);

	public CommentEntity updateComment(CommentEntity obj);

	public Integer deleteComment(Long id);

	public CommentEntity selectCommentById(Long id);

	public List<CommentEntity> findReplies(Long parentCommentId);

}
