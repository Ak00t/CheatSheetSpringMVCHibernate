package com.hibernate.repository;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.UserFollowedCategoryEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserFollowedCategoryRepositoryImpl
        implements UserFollowedCategoryRepository {

    private final SessionFactory sessionFactory;

    @Override
    public void follow(Long userId, Long categoryId) {

        if (!isFollowing(userId, categoryId)) {

            UserFollowedCategoryEntity entity =
                    new UserFollowedCategoryEntity();

            entity.setUserId(userId);
            entity.setCategoryId(categoryId);

            sessionFactory
                    .getCurrentSession()
                    .save(entity);
        }
    }

    @Override
    public void unfollow(Long userId, Long categoryId) {

        sessionFactory
                .getCurrentSession()
                .createQuery(
                        "delete from UserFollowedCategoryEntity " +
                        "where userId = :userId " +
                        "and categoryId = :categoryId")
                .setParameter("userId", userId)
                .setParameter("categoryId", categoryId)
                .executeUpdate();
    }

    @Override
    public boolean isFollowing(
            Long userId,
            Long categoryId) {

        Long count =
                sessionFactory
                        .getCurrentSession()
                        .createQuery(
                                "select count(*) " +
                                "from UserFollowedCategoryEntity " +
                                "where userId = :userId " +
                                "and categoryId = :categoryId",
                                Long.class)
                        .setParameter("userId", userId)
                        .setParameter("categoryId", categoryId)
                        .getSingleResult();

        return count > 0;
    }

    @Override
    public long countFollowers(Long categoryId) {

        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select count(*) " +
                        "from UserFollowedCategoryEntity " +
                        "where categoryId = :categoryId",
                        Long.class)
                .setParameter("categoryId", categoryId)
                .getSingleResult();
    }
}