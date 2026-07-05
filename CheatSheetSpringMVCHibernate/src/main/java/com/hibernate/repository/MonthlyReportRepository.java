package com.hibernate.repository;

import java.util.List;

import com.hibernate.DTO.MonthlyReportDTO;

public interface MonthlyReportRepository {

	List<MonthlyReportDTO> getMonthlyReport(int month, int year);

}
