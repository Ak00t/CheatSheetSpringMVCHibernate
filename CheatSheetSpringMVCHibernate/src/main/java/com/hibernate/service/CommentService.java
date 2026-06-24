package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.CommentEntity;

public interface CommentService {

	public List<CommentEntity> selectCommentsByCheatsheetId(Long cheatsheetId);

	public Long insertComment(CommentEntity obj);

	public CommentEntity updateComment(CommentEntity obj);

	public CommentEntity DeleteComment(CommentEntity obj);

	public CommentEntity selectCommentById(Long id);

	public List<CommentEntity> findReplies(Long parentCommentId);

}
