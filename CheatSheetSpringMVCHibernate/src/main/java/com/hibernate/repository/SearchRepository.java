package com.hibernate.repository;

import java.util.List;

import com.hibernate.DTO.SearchResultDTO;
import com.hibernate.entity.SearchLogEntity;

public interface SearchRepository {

	public SearchResultDTO searchAll(String keyword);

	public void saveSearchLog(String keyword, int resultCount, Long userId);

	public List<SearchLogEntity> getSearchLogByUserId(Long userId);

}
