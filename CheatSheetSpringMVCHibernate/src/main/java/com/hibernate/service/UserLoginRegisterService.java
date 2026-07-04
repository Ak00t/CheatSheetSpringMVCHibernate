package com.hibernate.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.hibernate.entity.UserEntity;

public interface UserLoginRegisterService extends UserDetailsService {

	public Boolean checkEmail(UserEntity obj);

	public void registerUser(UserEntity obj);

	public UserEntity findByEmail(String email);

}
