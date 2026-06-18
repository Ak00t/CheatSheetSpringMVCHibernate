package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
@Transactional
public class UserLoginRegisterRepositoryImpl implements UserLoginRegisterRepository {

	private final SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public boolean checkEmail(UserEntity obj) {
		Long count = getSession().createQuery("SELECT COUNT(u) FROM UserEntity u WHERE email=:email", Long.class)
				.setParameter("email", obj.getEmail()).uniqueResult();

		return count != null && count > 0;
	}

	@Override
	public void registerUser(UserEntity obj) {
		getSession().save(obj);
	}

}
