package com.hibernate.repository;

import com.hibernate.entity.UserEntity;

public interface UserLoginRegisterRepository {

	public boolean checkEmail(UserEntity obj);

	public void registerUser(UserEntity obj);

	public UserEntity findByEmail(String email);

	
	
	}

