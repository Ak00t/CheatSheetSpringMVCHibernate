package com.hibernate.repository;

import com.hibernate.entity.UserEntity;

public interface UserRegisterRepository {

	public boolean checkUser(UserEntity obj);

	public int registerUser(UserEntity obj);

}
