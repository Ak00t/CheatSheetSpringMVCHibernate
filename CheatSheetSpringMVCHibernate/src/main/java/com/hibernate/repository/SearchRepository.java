package com.hibernate.repository;

import java.util.List;

import com.hibernate.DTO.SearchResultDTO;
import com.hibernate.entity.SearchLogEntity;

public interface SearchRepository {

	public SearchResultDTO searchAll(String keyword, Long currentUserId);

	public List<SearchLogEntity> getSearchLogByUserId(Long userId);

}
