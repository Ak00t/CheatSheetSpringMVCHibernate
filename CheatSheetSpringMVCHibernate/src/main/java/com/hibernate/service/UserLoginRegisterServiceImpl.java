package com.hibernate.service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

		UserEntity user = userRepo.findByEmail(email);
		if (user == null) {
			throw new UsernameNotFoundException("User not found with email: " + email);
		}
		return User.builder().username(user.getEmail()).password(user.getPassword()).roles(user.getRole().name())
				.build();

	}

	@Override
	public UserEntity findByEmail(String email) {
		return userRepo.findByEmail(email);
	}

}
