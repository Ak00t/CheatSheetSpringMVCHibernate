package com.hibernate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;
@Service
@Transactional
public class UserProfileServiceImpl implements UserProfileService{
	@Autowired
    private UserProfileRepository  userRepository;

    
	@Override
    @Transactional(readOnly = true)
    
	public UserEntity getUserProfile(Long userId) {
		
		return userRepository.findById(userId);
	}

	@Override
	@Transactional
	public void updateProfile(Long userId, String name, String bio, String profileImg) {
		UserEntity user = userRepository.findById(userId);
        if (user != null) {
          
            user.setName(name);
            user.setBio(bio);
            user.setProfileImg(profileImg);
        }
    
	}

}
