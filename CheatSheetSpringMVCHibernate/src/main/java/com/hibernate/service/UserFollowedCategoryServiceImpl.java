package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.repository.UserFollowedCategoryRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class UserFollowedCategoryServiceImpl
        implements UserFollowedCategoryService {

    private final UserFollowedCategoryRepository
            userFollowedCategoryRepository;

    @Override
    public void follow(
            Long userId,
            Long categoryId) {

        userFollowedCategoryRepository
                .follow(userId, categoryId);
    }

    @Override
    public void unfollow(
            Long userId,
            Long categoryId) {

        userFollowedCategoryRepository
                .unfollow(userId, categoryId);
    }

    @Override
    public boolean isFollowing(
            Long userId,
            Long categoryId) {

        return userFollowedCategoryRepository
                .isFollowing(
                        userId,
                        categoryId);
    }

    @Override
    public long countFollowers(
            Long categoryId) {

        return userFollowedCategoryRepository
                .countFollowers(categoryId);
    }
    @Override
	public List<CategoryEntity> findFollowedCategoriesByUserId(Long userId) {
		return userFollowedCategoryRepository.findFollowedCategoriesByUserId(userId);
	}
}