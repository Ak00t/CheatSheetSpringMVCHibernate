package com.hibernate.DTO;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CommentEntity;
import com.hibernate.entity.UserEntity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminReportTargetPreviewDTO {

	private String displayLabel;
	private String displaySubtitle;
	private UserEntity user;
	private CommentEntity comment;
	private CheatsheetEntity cheatsheet;
}
