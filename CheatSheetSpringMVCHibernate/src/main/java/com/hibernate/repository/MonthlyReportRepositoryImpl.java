package com.hibernate.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.DTO.MonthlyReportDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor

public class MonthlyReportRepositoryImpl implements MonthlyReportRepository {

	private final SessionFactory SessionFactory;

	public final Session getSession() {
		return SessionFactory.getCurrentSession();
	}

	@Override
	@SuppressWarnings({ "deprecation", "unchecked" })
	public List<MonthlyReportDTO> getMonthlyReport(int month, int year) {
		return getSession()
				.createNativeQuery("CALL cheatsheet_monthly_report(:month, :year)")
					.setParameter("month", month)
					.setParameter("year", year)
					.setResultTransformer(org.hibernate.transform.Transformers.aliasToBean(MonthlyReportDTO.class))
					.getResultList();
	}

}
