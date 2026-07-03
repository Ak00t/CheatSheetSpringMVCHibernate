package com.hibernate.service;

import com.hibernate.entity.UserEntity;

public interface AdminProfileService {
    UserEntity getAdminProfile(Long id);
    void updateAdminPassword(Long id, String newPassword);
	UserEntity findByEmail(String email);
	void updateAdminProfileImage(Long id, String imagePath);
}