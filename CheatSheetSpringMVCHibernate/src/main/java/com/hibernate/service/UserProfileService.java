package com.hibernate.service;

import com.hibernate.entity.UserEntity;

public interface UserProfileService {	
	UserEntity getUserProfile(Long userId);
    void updateProfile(Long userId, String name, String bio, String profileImg);

}
