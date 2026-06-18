package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.hibernate.entity.UserEntity;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor

public class UserRepositoryImpl implements UserRepository {

	private final SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public UserEntity checkUser(UserEntity obj) {
		UserEntity user =null;
		return user;
	}

	@Override
	public int registerUser(UserEntity obj) {
		return 0;
	}

}
