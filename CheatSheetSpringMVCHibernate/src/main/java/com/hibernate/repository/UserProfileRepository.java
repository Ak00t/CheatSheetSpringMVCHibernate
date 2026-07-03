package com.hibernate.repository;


import com.hibernate.entity.UserEntity;

public interface UserProfileRepository {
    UserEntity findById(Long id);
    void updateProfile(UserEntity user);
}
