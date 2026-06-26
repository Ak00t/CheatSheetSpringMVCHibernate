package com.hibernate.service;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.TagEntity;
import com.hibernate.repository.AdminCheatsheetRepository;


@Service
@Transactional
public class AdminCheatsheetServiceImpl implements AdminCheatsheetService {

    @Autowired
    private AdminCheatsheetRepository adminCheatsheetRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional(readOnly = true)
    public List<CheatsheetEntity> getAllCheatsheets() {
        return adminCheatsheetRepository.getAllCheatsheets();
    }

    @Override
    @Transactional(readOnly = true)
    public List<CategoryEntity> getAllCategories() {
        return entityManager.createQuery("SELECT cat FROM CategoryEntity cat", CategoryEntity.class).getResultList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<TagEntity> getAllTags() {
        return entityManager.createQuery("SELECT t FROM TagEntity t", TagEntity.class).getResultList();
    }

    @Override
    public void deleteCheatsheet(Long id) {
        adminCheatsheetRepository.deleteCheatsheet(id);
    }
}