package com.hibernate.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserLoginRegisterRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class UserLoginRegisterServiceImpl implements UserLoginRegisterService {

	private final UserLoginRegisterRepository userRepo;

	@Override
	public Boolean checkEmail(UserEntity obj) {
		return userRepo.checkEmail(obj);

	}

	@Override
	public void registerUser(UserEntity obj) {
		userRepo.registerUser(obj);

	}

}
