package com.hibernate.service;

import java.util.List;

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

	@Override
	public List<CommentEntity> selectCommentsByCheatsheetId(Long cheatsheetId) {
		return commentRepo.selectCommentsByCheatsheetId(cheatsheetId);
	}

	@Override
	public List<CommentEntity> findReplies(Long parentCommentId) {

		return commentRepo.findReplies(parentCommentId);
	}

}
