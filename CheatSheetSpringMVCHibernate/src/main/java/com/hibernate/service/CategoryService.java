package com.hibernate.service;

import java.util.List;
import com.hibernate.entity.CategoryEntity;

public interface CategoryService {

	Long save(CategoryEntity category);

	List<CategoryEntity> findAll();

	CategoryEntity findById(Long id);

	void update(CategoryEntity category);

	void delete(Long id);
	
	//home view parent category list
	
	List<CategoryEntity> findParentCategories();
	
	//next homeview childcategory view by parent Id
	
	List<CategoryEntity> findChildrenByParentId(Long parentId);

	boolean existsBySlug(String slug);
	
	

}