package com.hibernate.service;

import org.springframework.web.multipart.MultipartFile;

import com.hibernate.entity.UserEntity;

public interface UserProfileService {
    UserEntity getUserProfile(Long id);
    void updateProfile(Long id, String name, String bio, MultipartFile file);
}