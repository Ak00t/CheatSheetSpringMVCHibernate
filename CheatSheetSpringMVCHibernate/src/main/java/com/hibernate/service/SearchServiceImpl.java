package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.DTO.SearchResultDTO;
import com.hibernate.entity.SearchLogEntity;
import com.hibernate.repository.SearchRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class SearchServiceImpl implements SearchService {

	private final SearchRepository searchRepo;

	@Override
	public SearchResultDTO searchAll(String keyword) {
		return searchRepo.searchAll(keyword);
	}

	@Override
	public List<SearchLogEntity> getSearchLogByUserId(Long userId) {

		return searchRepo.getSearchLogByUserId(userId);
	}

	@Override
	public void saveSearchLog(String keyword, int resultCount, Long userId) {
		searchRepo.saveSearchLog(keyword, resultCount, userId);

	}

}
