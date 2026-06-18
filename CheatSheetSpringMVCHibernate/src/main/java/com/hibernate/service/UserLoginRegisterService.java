package com.hibernate.service;

import com.hibernate.entity.UserEntity;

public interface UserLoginRegisterService {

	public Boolean checkEmail(UserEntity obj);

	public void registerUser(UserEntity obj);

}
