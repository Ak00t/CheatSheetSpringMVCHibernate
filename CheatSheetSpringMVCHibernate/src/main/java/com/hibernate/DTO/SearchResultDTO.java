package com.hibernate.DTO;

import java.util.List;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter

public class SearchResultDTO {
	private List<CheatsheetEntity> cheatsheets;
	private List<CategoryEntity> categories;
	private List<UserEntity> users;
}
