package com.hibernate.repository;

import com.hibernate.entity.UserEntity;

public interface AdminProfileRepository {
    UserEntity findById(Long id);
    void update(UserEntity user);
}