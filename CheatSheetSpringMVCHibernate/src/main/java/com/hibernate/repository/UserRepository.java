package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.UserEntity;

public interface UserRepository {

    // Home page statistics
    long countActiveUsers();

    // Top contributors
    List<Object[]> findTopContributors(int limit);

    // Optional
    UserEntity findById(Long id);
}