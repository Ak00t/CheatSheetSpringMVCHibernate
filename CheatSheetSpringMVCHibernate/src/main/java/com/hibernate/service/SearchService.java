package com.hibernate.service;

import java.util.List;

import com.hibernate.DTO.SearchResultDTO;
import com.hibernate.entity.SearchLogEntity;

public interface SearchService {

	public SearchResultDTO searchAll(String keyword);

	public List<SearchLogEntity> getSearchLogByUserId(Long userId);

	public void saveSearchLog(String keyword, int resultCount, Long userId);
}
