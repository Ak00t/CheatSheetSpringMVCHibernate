package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CommentTranslationEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
@Transactional
public class CommentTranslationRepositoryImpl implements CommentTraslationRepository {
	private final SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public void saveTranslation(CommentTranslationEntity obj) {
		getSession().save(obj);
	}

	@Override
	public CommentTranslationEntity findCachedTranslation(Long id, String targetLanguage) {

		return getSession()
				.createQuery(
						"FROM CommentTranslationEntity t WHERE t.comment.id = :commentId AND t.targetLanguage= :lang",
						CommentTranslationEntity.class)
					.setParameter("commentId", id)
					.setParameter("lang", targetLanguage)
					.uniqueResultOptional()
					.orElse(null);
	}

}
