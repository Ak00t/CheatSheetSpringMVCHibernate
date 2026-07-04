package com.hibernate.service;

import java.util.Map;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class TranslationService {

	private final RestTemplate restTemplate;

	// Direct endpoint without query params in the base template string
	private static final String API_URL = "https://api.mymemory.translated.net/get?q={q}&langpair={langpair}";

	public TranslationService() {
		this.restTemplate = new RestTemplate();
		this.restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
	}

	public String translateText(String text, String targetLang) {
		try {
			// Force clean, lowercase language format (e.g., "en|my")
			String langPair = "en|" + targetLang.toLowerCase().trim();

			// Pass variables directly as arguments to let RestTemplate handle URL Encoding
			// safely
			Map<String, Object> response = restTemplate.getForObject(API_URL, Map.class, text, langPair);

			if (response != null && response.containsKey("responseData")) {
				Map<String, Object> responseData = (Map<String, Object>) response.get("responseData");
				if (responseData != null && responseData.containsKey("translatedText")) {
					return responseData.get("translatedText").toString();
				}
			}

			return "Translation Error: Invalid Response Payload Structure";
		} catch (Exception e) {
			e.printStackTrace();
			return "Translation failed: " + e.getMessage();
		}
	}
}