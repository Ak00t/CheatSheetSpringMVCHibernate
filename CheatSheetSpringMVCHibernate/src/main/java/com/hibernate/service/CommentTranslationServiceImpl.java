package com.hibernate.service;

import org.springframework.stereotype.Service;

import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.CommentTranslationEntity;
import com.hibernate.repository.CommentTraslationRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentTranslationServiceImpl implements CommentTranslationService {
	private final CommentTraslationRepository commentTranslationRepo;
	private final TranslationService translationService;

	@Override
	public String getOrFetchTranslation(CommentEntity comment, String targetLang) {
		CommentTranslationEntity cached = commentTranslationRepo.findCachedTranslation(comment.getId(), targetLang);
		if (cached != null) {
			return cached.getTranslatedText();
		}

		// 2. Cache Miss: Run your MyMemory RestTemplate Client
		String translatedText = translationService.translateText(comment.getContent(), targetLang);

		// 3. Save the translation entity back to the DB for instant future lookup
		CommentTranslationEntity newTranslation = new CommentTranslationEntity();
		newTranslation.setComment(comment);
		newTranslation.setTargetLanguage(targetLang);
		newTranslation.setTranslatedText(translatedText);

		commentTranslationRepo.saveTranslation(newTranslation);

		return translatedText;
	}

}
