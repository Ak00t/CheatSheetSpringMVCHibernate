package com.hibernate.DTO;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MonthlyReportDTO {

	private String title;
	private String name;
	private Date date;
	private String month;
	private BigInteger likes;
	private Integer year;
	private BigDecimal rating;
	private BigInteger view_count;

}
