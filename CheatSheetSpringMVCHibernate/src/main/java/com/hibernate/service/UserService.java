package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.UserEntity;

public interface UserService {

    long countActiveUsers();

    List<Object[]> findTopContributors(int limit);

    UserEntity findById(Long id);
}