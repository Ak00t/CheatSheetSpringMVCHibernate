package com.hibernate.repository;

import java.util.List;
import com.hibernate.entity.CategoryEntity;

public interface CategoryRepository {

	Long save(CategoryEntity category);

	List<CategoryEntity> findAll();

	CategoryEntity findById(Long id);

	void update(CategoryEntity category);

	void delete(Long id);
	
	List<CategoryEntity> findByParentId(Long parentId);
	
	
	//home view parent category list
	
	List<CategoryEntity> findParentCategories();
	
	//next homeview childcategory view by parent Id
	
	List<CategoryEntity> findChildrenByParentId(Long parentId);

	boolean existsBySlug(String slug);
	
	
	
	//final
	// =========================
	// Home / Parent Category Statistics
	// =========================

	// Home total active categories
	long countActiveCategories();

	// Parent category card child count
	long countChildrenByParentId(Long parentId);
	
	
	
	
}