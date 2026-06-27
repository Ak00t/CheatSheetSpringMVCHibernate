package com.hibernate.repository;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.UserStatus;
import java.util.List;

public interface UserManagementRepository {
    List<UserEntity> findUsersWithPagination(int offset, int size);
    long getTotalUsersCount();
    void updateUserStatus(Long userId, UserStatus status);
    void deleteUser(Long userId);
	List<CheatsheetEntity> findCheatsheetsByUserId(Long userId);
	UserEntity findUserById(Long userId);
}