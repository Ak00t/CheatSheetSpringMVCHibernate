package com.hibernate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.AdminReportService;

@Controller
@RequestMapping("/admin")
public class AdminReportController {

	private final AdminReportService adminReportService;

	@Autowired
	public AdminReportController(AdminReportService adminReportService) {
		this.adminReportService = adminReportService;
	}

	@GetMapping("/reports")
	public String showReportsPage(Model model, HttpSession session) {
		UserEntity loggedInAdmin = (UserEntity) session.getAttribute("currentUser");
		if (loggedInAdmin == null) {
			return "redirect:/login";
		}

		model.addAttribute("pendingReportsList", adminReportService.getPendingReports());
		return "adminreport";
	}

	@PostMapping("/reports/resolve")
	public String resolveReport(@RequestParam("reportId") Long reportId, @RequestParam("actionType") String actionType,
			@RequestParam(value = "warningMessage", required = false) String warningMessage, HttpSession session) {

		UserEntity loggedInAdmin = (UserEntity) session.getAttribute("currentUser");
		if (loggedInAdmin == null) {
			return "redirect:/?login=true";
		}

		adminReportService.handleReportAction(reportId, actionType, warningMessage, loggedInAdmin);
		return "redirect:/admin/reports";
	}
}