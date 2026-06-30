package com.hibernate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hibernate.entity.UserEntity;
import com.hibernate.repository.AdminProfileRepository;

@Service
@Transactional
public class AdminProfileServiceImpl implements AdminProfileService {

    @Autowired
    private AdminProfileRepository adminRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    @Transactional(readOnly = true)
    public UserEntity getAdminProfile(Long id) {
        return adminRepository.findById(id);
    }

    @Override
    public void updateAdminPassword(Long id, String newPassword) {
        UserEntity admin = adminRepository.findById(id);
        if (admin != null) {
            // Hashing performed exactly once securely within the Service layer
            admin.setPassword(passwordEncoder.encode(newPassword));
            adminRepository.update(admin);
        }
    }

    @Override
    public void updateAdminProfileImage(Long id, String imagePath) {
        UserEntity admin = adminRepository.findById(id);
        if (admin != null) {
            admin.setProfileImg(imagePath);
            adminRepository.update(admin);
        }
    }

    @Override
    public UserEntity findByEmail(String email) {
        return null;
    }
}