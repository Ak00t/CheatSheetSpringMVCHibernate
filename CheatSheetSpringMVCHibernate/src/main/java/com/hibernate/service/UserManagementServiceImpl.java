package com.hibernate.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.UserStatus;
import com.hibernate.repository.UserManagementRepository;
import lombok.RequiredArgsConstructor;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserManagementServiceImpl implements UserManagementService {

    private final UserManagementRepository userManagementRepository;

    @Override
    @Transactional(readOnly = true)
    public List<UserEntity> getUsersByPage(int offset, int size) {
        return userManagementRepository.findUsersWithPagination(offset, size);
    }

    @Override
    @Transactional(readOnly = true)
    public long getTotalUsersCount() {
        return userManagementRepository.getTotalUsersCount();
    }

    @Override
    @Transactional
    public void banUser(Long userId) {
        userManagementRepository.updateUserStatus(userId, UserStatus.BANNED);
    }

    @Override
    @Transactional
    public void unbanUser(Long userId) {
        userManagementRepository.updateUserStatus(userId, UserStatus.ACTIVE);
    }

    @Override
    @Transactional
    public void removeUser(Long userId) {
        userManagementRepository.deleteUser(userId);
    }

    // ✅ FIX: User ID အလိုက် တင်ထားသမျှ Cheatsheet စာရင်းကို Repository မှ ဆွဲထုတ်ခြင်း
    @Override
    @Transactional(readOnly = true)
    public List<CheatsheetEntity> getCheatsheetsByUserId(Long userId) {
        return userManagementRepository.findCheatsheetsByUserId(userId);
    }

    // ✅ FIX: User ID ကိုသုံးပြီး မိမိကြည့်မည့် User Object တစ်ခုလုံးကို ဆွဲထုတ်ခြင်း
    @Override
    @Transactional(readOnly = true)
    public UserEntity getUserById(Long userId) {
        return userManagementRepository.findUserById(userId);
    }
}