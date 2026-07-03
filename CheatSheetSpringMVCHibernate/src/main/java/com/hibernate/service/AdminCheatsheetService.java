package com.hibernate.service;

import java.util.List;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.TagEntity;

public interface AdminCheatsheetService {
    List<CheatsheetEntity> getAllCheatsheets();
    List<CategoryEntity> getAllCategories();
    List<TagEntity> getAllTags();
    void deleteCheatsheet(Long id);
}