package com.hibernate.service;

import com.hibernate.entity.CommentEntity;

public interface CommentService {

	public Long insertComment(CommentEntity obj);

	public CommentEntity updateComment(CommentEntity obj);

	public CommentEntity DeleteComment(CommentEntity obj);

	public CommentEntity selectCommentById(Long id);

}
