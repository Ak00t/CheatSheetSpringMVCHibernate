package com.hibernate.repository;

import java.util.List;
import com.hibernate.entity.CheatsheetEntity;

public interface AdminCheatsheetRepository {
    List<CheatsheetEntity> getAllCheatsheets();
    void deleteCheatsheet(Long id);
}