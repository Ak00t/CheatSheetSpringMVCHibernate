package com.hibernate.service;

import com.hibernate.entity.UserEntity;
import java.util.List;

public interface UserListService {
    List<UserEntity> getUsersByPeriod(String type, Integer year, Integer month, Integer week, String day);
}