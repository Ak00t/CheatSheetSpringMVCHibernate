package com.hibernate.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserProfileRepository;
@Service
@Transactional

public class UserProfileServiceImpl implements UserProfileService {

    private final String UPLOAD_DIR = "uploads/profiles/";

    @Autowired
    private UserProfileRepository userRepository;

    @Override
    public void updateProfile(Long id, String name, String bio, MultipartFile file) {
        UserEntity user = userRepository.findById(id);
        user.setName(name);
        user.setBio(bio);

        if (!file.isEmpty()) {
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            
            try {
                file.transferTo(new File(UPLOAD_DIR + fileName));
                user.setProfileImg(fileName); 
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        userRepository.updateProfile(user);
    }
    
    @Override
    public UserEntity getUserProfile(Long id) {
        return userRepository.findById(id);
    }
    
}