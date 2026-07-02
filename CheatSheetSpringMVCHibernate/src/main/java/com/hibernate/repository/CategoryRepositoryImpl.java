package com.hibernate.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.enums.CategoryStatus;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CategoryRepositoryImpl implements CategoryRepository {

	private final SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public Long save(CategoryEntity category) {
		return (Long) getSession().save(category);
	}
	
	@Override
	public List<CategoryEntity> findAll() {
		return getSession()
			.createQuery(
				"select distinct c from CategoryEntity c " +
				"left join fetch c.parent " +
				"where c.status = :status",
				CategoryEntity.class)
			.setParameter("status", CategoryStatus.ACTIVE)
			.getResultList();
	}

	@Override
	public CategoryEntity findById(Long id) {
		return getSession().get(CategoryEntity.class, id);
	}

	@Override
	public void update(CategoryEntity category) {
		getSession().update(category);
	}

	@Override
	public void delete(Long id) {
		CategoryEntity category = findById(id);

		if(category != null) {
			getSession().delete(category);
		}
	}

	@Override
	public List<CategoryEntity> findByParentId(Long parentId) {
		return getSession()
			.createQuery("from CategoryEntity c where c.parent.id = :parentId",
						 CategoryEntity.class)
			.setParameter("parentId", parentId)
			.getResultList();
	}
	
	@Override
	public List<CategoryEntity> findParentCategories() {
		return getSession()
				.createQuery(
						"from CategoryEntity c " +
						"where c.parent is null " +
						"and c.status = :status " +
						"order by c.id asc",
						CategoryEntity.class)
				.setParameter("status", CategoryStatus.ACTIVE)
				.getResultList();
	}
	
	@Override
	public List<CategoryEntity> findChildrenByParentId(Long parentId) {
		return getSession()
				.createQuery(
						"from CategoryEntity c " +
						"where c.parent.id = :parentId " +
						"and c.status = :status " +
						"order by c.id asc",
						CategoryEntity.class)
				.setParameter("parentId", parentId)
				.setParameter("status", CategoryStatus.ACTIVE)
				.getResultList();
	}

	// 🚨 Fixed: Active ဖြစ်နေပြီး တူညီတဲ့ Slug စာရင်း ရှိမရှိ Database မှာ Count Query နဲ့ လှမ်းစစ်ခြင်း
	@Override
	public boolean existsBySlug(String slug) {
		Long count = getSession()
				.createQuery(
						"select count(c) from CategoryEntity c " +
						"where c.slug = :slug " +
						"and c.status = :status", 
						Long.class)
				.setParameter("slug", slug)
				.setParameter("status", CategoryStatus.ACTIVE)
				.getSingleResult();
		
		return count > 0;
	}
	
	
	//final
	// =========================
	// Home / Parent Category Statistics
	// =========================

	@Override
	public long countActiveCategories() {

	    return getSession()
	            .createQuery(
	                    "select count(c.id) " +
	                    "from CategoryEntity c " +
	                    "where c.status = :status",
	                    Long.class)
	            .setParameter("status", CategoryStatus.ACTIVE)
	            .getSingleResult();
	}

	@Override
	public long countChildrenByParentId(Long parentId) {

	    return getSession()
	            .createQuery(
	                    "select count(c.id) " +
	                    "from CategoryEntity c " +
	                    "where c.parent.id = :parentId " +
	                    "and c.status = :status",
	                    Long.class)
	            .setParameter("parentId", parentId)
	            .setParameter("status", CategoryStatus.ACTIVE)
	            .getSingleResult();
	}
	
	
}