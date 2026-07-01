package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public long countActiveUsers() {
        return userRepository.countActiveUsers();
    }

    @Override
    public List<Object[]> findTopContributors(int limit) {
        return userRepository.findTopContributors(limit);
    }

    @Override
    public UserEntity findById(Long id) {
        return userRepository.findById(id);
    }
}