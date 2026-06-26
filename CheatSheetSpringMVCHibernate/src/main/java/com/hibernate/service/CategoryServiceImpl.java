package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.TagEntity;
import com.hibernate.entity.enums.CategoryStatus;
import com.hibernate.entity.enums.TagStatus;
import com.hibernate.repository.CategoryRepository;
import com.hibernate.repository.TagRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

	private final CategoryRepository categoryRepository;
	private final TagRepository tagRepository;

	@Override
	@Transactional
	public Long save(CategoryEntity category) {
		return categoryRepository.save(category);
	}

	@Override
	@Transactional
	public List<CategoryEntity> findAll() {
		return categoryRepository.findAll();
	}

	@Override
	@Transactional
	public CategoryEntity findById(Long id) {
		return categoryRepository.findById(id);
	}

	@Override
	@Transactional
	public void update(CategoryEntity category) {
		categoryRepository.update(category);
	}

	@Override
	@Transactional
	public void delete(Long id) {
		CategoryEntity category = categoryRepository.findById(id);

		if (category != null) {
			softDeleteCategory(category);
		}
	}
	
	private void softDeleteCategory(CategoryEntity category) {
		category.setStatus(CategoryStatus.INACTIVE);
		categoryRepository.update(category);

		List<TagEntity> tags = tagRepository.findByCategoryId(category.getId());

		for (TagEntity tag : tags) {
			tag.setStatus(TagStatus.INACTIVE);
			tagRepository.update(tag);
		}

		List<CategoryEntity> children = categoryRepository.findByParentId(category.getId());

		for (CategoryEntity child : children) {
			softDeleteCategory(child);
		}
	}
	
	//home view parent category list
	@Override
	@Transactional
	public List<CategoryEntity> findParentCategories() {
		return categoryRepository.findParentCategories();
	}
	
	//next homeview childcategory view by parent Id
	@Override
	@Transactional
	public List<CategoryEntity> findChildrenByParentId(Long parentId) {
		return categoryRepository.findChildrenByParentId(parentId);
	}

	// 🚨 Fixed: Repository ဆီက နေပြီး အမှန်/အမှား လှမ်းယူပြီး ပြန်ပေးခြင်း
	@Override
	@Transactional
	public boolean existsBySlug(String slug) {
		return categoryRepository.existsBySlug(slug);
	}

}