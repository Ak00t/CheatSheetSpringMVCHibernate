package com.hibernate.repository;

import com.hibernate.entity.UserEntity;
import java.time.LocalDateTime;
import java.util.List;

public interface UserListRepository {
    List<UserEntity> findUsersByDateRange(LocalDateTime start, LocalDateTime end);
}