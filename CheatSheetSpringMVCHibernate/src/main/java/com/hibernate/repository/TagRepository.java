package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.TagEntity;

public interface TagRepository {

	Long save(TagEntity tag);

	List<TagEntity> findAll();

	TagEntity findById(Long id);

	void update(TagEntity tag);

	void delete(Long id);
	
	List<TagEntity> findByCategoryId(Long categoryId);
	
	
	  //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
	List<TagEntity> findActiveTagsByCategoryId(Long categoryId);
	
	
	
	

}