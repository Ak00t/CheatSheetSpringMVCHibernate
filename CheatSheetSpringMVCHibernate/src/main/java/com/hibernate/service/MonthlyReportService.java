package com.hibernate.service;

import java.util.List;

import com.hibernate.DTO.MonthlyReportDTO;

public interface MonthlyReportService {
	List<MonthlyReportDTO> getMonthlyReport(int month, int year);

}
