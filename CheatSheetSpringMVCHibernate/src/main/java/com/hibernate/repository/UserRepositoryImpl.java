package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.PublishStatus;
import com.hibernate.entity.enums.UserRole;
import com.hibernate.entity.enums.UserStatus;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserRepositoryImpl implements UserRepository {

	private final SessionFactory sessionFactory;

	@Override
	public long countActiveUsers() {
		return sessionFactory
				.getCurrentSession()
					.createQuery("select count(u.id) from UserEntity u " + "where u.status = :status", Long.class)
					.setParameter("status", UserStatus.ACTIVE)
					.getSingleResult();
	}

	/*
	 * @Override public List<Object[]> findTopContributors(int limit) { return
	 * sessionFactory .getCurrentSession() .createQuery("select u, count(c.id) " +
	 * "from UserEntity u " + "join u.cheatsheets c " +
	 * "where u.status = :userStatus " + "and c.publishStatus = :publishStatus " +
	 * "and c.visibility = :visibility " + "and c.status = :contentStatus " +
	 * "group by u.id " + "order by count(c.id) desc", Object[].class)
	 * .setParameter("userStatus", UserStatus.ACTIVE) .setParameter("publishStatus",
	 * PublishStatus.PUBLISHED) .setParameter("visibility",
	 * CheatsheetVisibility.PUBLIC) .setParameter("contentStatus",
	 * ContentStatus.ACTIVE) .setMaxResults(limit) .getResultList(); }
	 */
	
	
	@Override
	public List<Object[]> findTopContributors(int limit) {
	    return sessionFactory
	            .getCurrentSession()
	            .createQuery(
	                    "select u, count(distinct c.id) " +
	                    "from UserEntity u " +
	                    "join u.cheatsheets c " +
	                    "where u.status = :userStatus " +
	                    "and c.publishStatus = :publishStatus " +
	                    "and c.status != :deletedStatus " +
	                    "group by u.id " +
	                    "order by count(distinct c.id) desc",
	                    Object[].class)
	            .setParameter("userStatus", UserStatus.ACTIVE)
	            .setParameter("publishStatus", PublishStatus.PUBLISHED)
	            .setParameter("deletedStatus", ContentStatus.DELETED)
	            .setMaxResults(limit)
	            .getResultList();
	}
	

	@Override
	public UserEntity findById(Long id) {
		return sessionFactory.getCurrentSession().get(UserEntity.class, id);
	}

	@Override
	@Transactional
	public List<UserEntity> findByRole(String role) {

		return sessionFactory
				.getCurrentSession()
					.createQuery("from UserEntity u where u.role = :role", UserEntity.class)
					.setParameter("role", UserRole.valueOf(role))
					.getResultList();
	}
}