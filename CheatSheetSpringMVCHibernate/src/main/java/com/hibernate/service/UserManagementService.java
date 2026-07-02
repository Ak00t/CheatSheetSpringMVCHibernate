package com.hibernate.service;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import java.util.List;

public interface UserManagementService {
    List<UserEntity> getUsersByPage(int offset, int size);
    long getTotalUsersCount();
    void banUser(Long userId);
    void unbanUser(Long userId);
    void removeUser(Long userId);
	List<CheatsheetEntity> getCheatsheetsByUserId(Long userId);
	UserEntity getUserById(Long userId);
}