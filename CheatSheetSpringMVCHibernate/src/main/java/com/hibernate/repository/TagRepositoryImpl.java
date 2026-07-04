package com.hibernate.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.TagEntity;
import com.hibernate.entity.enums.TagStatus;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class TagRepositoryImpl implements TagRepository {

	private final SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public Long save(TagEntity tag) {
		return (Long) getSession().save(tag);
	}

	/*
	 * @Override public List<TagEntity> findAll() { return getSession()
	 * .createQuery("from TagEntity", TagEntity.class) .list(); }
	 */
	
	/*
	 * @Override public List<TagEntity> findAll() { return getSession()
	 * .createQuery( "select t from TagEntity t join fetch t.category",
	 * TagEntity.class) .getResultList(); }
	 */
	
	@Override
	public List<TagEntity> findAll() {

	    return getSession()
	        .createQuery(
	            "select t from TagEntity t " +
	            "join fetch t.category " +
	            "where t.status = :status",
	            TagEntity.class)
	        .setParameter("status", TagStatus.ACTIVE)
	        .getResultList();
	}
	
	
	
	

	@Override
	public TagEntity findById(Long id) {
		return getSession().get(TagEntity.class, id);
	}

	@Override
	public void update(TagEntity tag) {
		getSession().update(tag);
	}

	@Override
	public void delete(Long id) {

		TagEntity tag = findById(id);

		if(tag != null) {
			getSession().delete(tag);
		}
	}

	
	
	
	@Override
	public List<TagEntity> findByCategoryId(Long categoryId) {
	    return getSession()
	        .createQuery("from TagEntity t where t.category.id = :categoryId",
	                     TagEntity.class)
	        .setParameter("categoryId", categoryId)
	        .getResultList();
	}
	
	
	  //child category နှိပ်ရင်ပေါ်လာမယ့် view -- / tag list 
	
	@Override
	public List<TagEntity> findActiveTagsByCategoryId(Long categoryId) {

	    return getSession()
	            .createQuery(
	                    "from TagEntity t " +
	                    "where t.category.id = :categoryId " +
	                    "and t.status = :status " +
	                    "order by t.id asc",
	                    TagEntity.class)
	            .setParameter("categoryId", categoryId)
	            .setParameter("status", TagStatus.ACTIVE)
	            .getResultList();
	}
	
	
	
	
}