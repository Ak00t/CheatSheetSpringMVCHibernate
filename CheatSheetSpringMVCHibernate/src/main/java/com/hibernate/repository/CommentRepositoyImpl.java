package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CommentEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
@Transactional
public class CommentRepositoyImpl implements CommentsRepository {

	private final SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public Long insertComment(CommentEntity obj) {

		return (Long) getSession().save(obj);
	}

	public CommentEntity updateComment(CommentEntity obj) {
		return (CommentEntity) getSession().merge(obj);
	}

	public CommentEntity DeleteComment(CommentEntity obj) {
		return (CommentEntity) getSession().merge(obj);

	}

	@Override
	public CommentEntity selectCommentById(Long id) {

		return getSession().get(CommentEntity.class, id);
	}

}
