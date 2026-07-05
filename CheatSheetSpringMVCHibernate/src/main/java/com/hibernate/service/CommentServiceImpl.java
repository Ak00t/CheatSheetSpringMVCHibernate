package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.ReportEntity;
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
	public Integer deleteComment(Long id) {

		return commentRepo.deleteComment(id);
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

	@Override
	public CommentEntity findByParentId(Long id) {

		return commentRepo.findByParentId(id);
	}

	@Override
	public void reportComment(ReportEntity report) {
		commentRepo.reportComment(report);

	}

	@Override
	public void deleteTranslationByCommentId(Long commentId) {
		commentRepo.deleteTranslationByCommentId(commentId);

	}

	@Override
	public Long getCheatsheetByCommentId(Long commentId) {

		return commentRepo.getCheatsheetIdByCommentId(commentId);
	}

}
