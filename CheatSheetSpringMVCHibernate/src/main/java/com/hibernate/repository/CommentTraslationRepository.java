package com.hibernate.repository;

import com.hibernate.entity.CommentTranslationEntity;

public interface CommentTraslationRepository {

	public void saveTranslation(CommentTranslationEntity obj);

	public CommentTranslationEntity findCachedTranslation(Long Id, String sourceLanguage);

}
