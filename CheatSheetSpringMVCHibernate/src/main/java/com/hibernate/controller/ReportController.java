package com.hibernate.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.engine.spi.SessionImplementor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.DTO.MonthlyReportDTO;
import com.hibernate.service.MonthlyReportService;

import lombok.RequiredArgsConstructor;
// ADD THESE TWO IMPORTS
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@Controller
@Transactional
@RequiredArgsConstructor
@RequestMapping("/admin")
public class ReportController {

	private final SessionFactory sessionFactory;
	private final MonthlyReportService repo;

	@GetMapping("/reports/monthly")
	public String showMonthlyDashboard(@RequestParam(value = "targetMonth", required = false) String targetMonth,
			Model model) {

		// Default to current month/year if none selected yet
		if (targetMonth == null || targetMonth.isEmpty()) {
			java.time.LocalDate now = java.time.LocalDate.now();
			targetMonth = String.format("%d-%02d", now.getYear(), now.getMonthValue());
		}

		String[] parts = targetMonth.split("-");
		int year = Integer.parseInt(parts[0]);
		int month = Integer.parseInt(parts[1]);

		List<MonthlyReportDTO> reportList = repo.getMonthlyReport(month, year);

		// Extract month name label (e.g., "June") for display matching image_1d6261.png
		String monthLabel = java.time.Month.of(month).name();
		monthLabel = monthLabel.substring(0, 1).toUpperCase() + monthLabel.substring(1).toLowerCase();

		model.addAttribute("reportList", reportList);
		model.addAttribute("selectedMonth", targetMonth);
		model.addAttribute("viewingMonthLabel", monthLabel);
		model.addAttribute("viewingYear", year);

		// Count total unique authors in the list
		long uniqueUsers = reportList.stream().map(MonthlyReportDTO::getName).distinct().count();
		model.addAttribute("uniqueUsersCount", uniqueUsers);

		return "monthly-reports";
	}

	@GetMapping("/reports/monthly/download")
	public void downloadReport(@RequestParam(value = "targetMonth", required = false) String targetMonth,
			HttpServletResponse response) {

		// Default to current month/year if no parameter was passed
		if (targetMonth == null || targetMonth.isEmpty()) {
			java.time.LocalDate now = java.time.LocalDate.now();
			targetMonth = String.format("%d-%02d", now.getYear(), now.getMonthValue());
		}

		// Split "YYYY-MM" string safely into separate integers
		String[] parts = targetMonth.split("-");
		int year = Integer.parseInt(parts[0]);
		int month = Integer.parseInt(parts[1]);

		String reportPath = "/reports/Cheatsheet_Report.jrxml";

		try (InputStream inputStream = getClass().getResourceAsStream(reportPath)) {
			if (inputStream == null) {
				throw new RuntimeException("Jasper report file not found at: " + reportPath);
			}

			// Pass BOTH parameters matching your Jasper Report Parameter map EXACTLY
			Map<String, Object> parameters = new HashMap<>();
			parameters.put("monthly_report", month);
			parameters.put("target_year", year);

			Session session = sessionFactory.getCurrentSession();
			SessionImplementor sessionImplementor = (SessionImplementor) session;
			Connection jdbcConnection = sessionImplementor.connection();

			// Compile and bundle
			JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, jdbcConnection);

			// Send PDF download stream back to browser
			response.setContentType("application/pdf");
			response
					.setHeader("Content-Disposition",
							"attachment; filename=Cheatsheet_Monthly_Report_" + targetMonth + ".pdf");

			try (OutputStream outputStream = response.getOutputStream()) {
				JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
				outputStream.flush();
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error occurred during report compilation generation: " + e.getMessage());
		}
	}
}