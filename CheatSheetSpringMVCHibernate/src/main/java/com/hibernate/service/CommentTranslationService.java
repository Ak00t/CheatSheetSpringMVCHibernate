package com.hibernate.service;

import com.hibernate.entity.CommentEntity;

public interface CommentTranslationService {
	
	public String getOrFetchTranslation(CommentEntity comment,String targetLang);
}
