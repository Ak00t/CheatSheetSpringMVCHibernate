package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.DTO.MonthlyReportDTO;
import com.hibernate.repository.MonthlyReportRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MonthlyReportServiceImpl implements MonthlyReportService {
	private final MonthlyReportRepository repo;

	@Override
	public List<MonthlyReportDTO> getMonthlyReport(int month, int year) {

		return repo.getMonthlyReport(month, year);
	}

}
