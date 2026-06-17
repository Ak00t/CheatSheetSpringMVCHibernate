package com.hibernate.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "cheatsheet_row_cells")
public class CheatsheetRowCellEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "row_id", nullable = false)
	private CheatsheetRowEntity row;

	@Column(name = "cell_key", length = 200)
	private String cellKey;

	@Column(name = "cell_value", columnDefinition = "TEXT")
	private String cellValue;

	@Column(name = "sort_order")
	private Integer sortOrder = 0;
}
