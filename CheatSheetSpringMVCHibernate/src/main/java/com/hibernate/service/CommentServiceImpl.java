package com.hibernate.service;

import org.springframework.stereotype.Service;

import com.hibernate.entity.CommentEntity;
import com.hibernate.repository.CommentsRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

	private final CommentsRepository commentRepo;

	@Override
	public Long insertComment(CommentEntity obj) {
		return commentRepo.insertComment(obj);
	}

	@Override
	public CommentEntity updateComment(CommentEntity obj) {

		return commentRepo.updateComment(obj);
	}

	@Override
	public CommentEntity DeleteComment(CommentEntity obj) {

		return commentRepo.DeleteComment(obj);
	}

	@Override
	public CommentEntity selectCommentById(Long id) {

		return commentRepo.selectCommentById(id);
	}

}
