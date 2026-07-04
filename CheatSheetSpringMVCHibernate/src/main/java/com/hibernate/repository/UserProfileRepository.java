package com.hibernate.repository;


import com.hibernate.entity.UserEntity;
import com.hibernate.entity.UserFollowEntity;

public interface UserProfileRepository {
    UserEntity findById(Long id);
    void updateProfile(UserEntity user);
	UserEntity findByUsername(String currentUsername);
	UserEntity findByEmail(String email); 
	
}
