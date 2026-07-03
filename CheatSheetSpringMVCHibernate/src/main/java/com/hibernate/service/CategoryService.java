package com.hibernate.service;

import java.util.List;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;

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
	
	
	//fianl
	// =========================
	// Home / Parent Category Statistics
	// =========================

	long countActiveCategories();

	long countChildrenByParentId(Long parentId);
	
	
	
	// =========================
	// Child Category View
	// =========================

	List<CheatsheetEntity> findPopularByCategoryId(
	        Long categoryId);

	List<CheatsheetEntity> findRecentByCategoryId(
	        Long categoryId);
	
	
	
	// Home Parent Category Pagination
	List<CategoryEntity> findParentCategoriesWithPagination(
	        int page,
	        int size);

	long countParentCategories();
	

}