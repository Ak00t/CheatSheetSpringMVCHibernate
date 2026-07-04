package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.TagEntity;

public interface TagService {

	Long save(TagEntity tag);

	List<TagEntity> findAll();

	TagEntity findById(Long id);

	void update(TagEntity tag);

	void delete(Long id);
	
	
	 //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
	List<TagEntity> findActiveTagsByCategoryId(Long categoryId);
	

}