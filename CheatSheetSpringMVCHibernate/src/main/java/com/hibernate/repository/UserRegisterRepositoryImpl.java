package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.hibernate.entity.UserEntity;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor

public class UserRegisterRepositoryImpl implements UserRegisterRepository {

	private final SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public boolean checkUser(UserEntity obj) {
		String email = obj.getEmail();

		return false;
	}

	@Override
	public int registerUser(UserEntity obj) {
		// TODO Auto-generated method stub
		return 0;
	}

}
