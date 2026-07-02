package com.hibernate.repository;

import java.util.List;

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

	public Integer deleteComment(Long id) {
		return getSession()
				.createQuery("update CommentEntity c set c.status = 'DELETED' where c.id = :id")
					.setParameter("id", id)
					.executeUpdate();

	}

	@Override
	public CommentEntity selectCommentById(Long id) {

		return getSession().get(CommentEntity.class, id);
	}

	@Override
	public List<CommentEntity> selectCommentsByCheatsheetId(Long cheatsheetId) {

		List<CommentEntity> rootComments = sessionFactory
				.getCurrentSession()
					.createQuery("select distinct c " + "from CommentEntity c " + "left join fetch c.user "
							+ "left join fetch c.cheatsheet cs " + "left join fetch cs.user "
							+ "where c.cheatsheet.id = :id " + "and c.parentComment is null "
							+ "and c.status = 'ACTIVE' " + "order by c.createdAt desc", CommentEntity.class)
					.setParameter("id", cheatsheetId)
					.list();

		for (CommentEntity comment : rootComments) {
			loadReplies(comment);
		}

		return rootComments;

	}

	@Override
	public List<CommentEntity> findReplies(Long parentCommentId) {

		return sessionFactory
				.getCurrentSession()
					.createQuery("select distinct r " + "from CommentEntity r " + "left join fetch r.user "
							+ "where r.parentComment.id = :id " + "and r.status = 'ACTIVE' "
							+ "order by r.createdAt asc", CommentEntity.class)
					.setParameter("id", parentCommentId)
					.list();
	}

	private void loadReplies(CommentEntity comment) {

		List<CommentEntity> replies = findReplies(comment.getId());

		comment.getReplies().clear();
		comment.getReplies().addAll(replies);

		for (CommentEntity reply : replies) {
			loadReplies(reply);
		}
	}

	@Override
	public CommentEntity findByParentId(Long id) {

		return getSession()
				.createQuery("select c from CommentEntity c where c.parentComment.id = :id", CommentEntity.class)
					.setParameter("id", id)
					.uniqueResult();
	}

}