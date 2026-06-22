package com.hibernate.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.DTO.CheatsheetFormDto;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.PublishStatus;
import com.hibernate.repository.CheatsheetRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CheatsheetServiceImpl implements CheatsheetService {

    private final CheatsheetRepository cheatsheetRepository;
    private final SessionFactory sessionFactory;

    @Override
    @Transactional
    public void createNewCheatsheet(CheatsheetFormDto formDto, UserEntity loginUser) {
        CheatsheetEntity cheatsheet = new CheatsheetEntity();
        
        cheatsheet.setTitle(formDto.getTitle());
        cheatsheet.setDescription(formDto.getDescription());
        cheatsheet.setThemeColor(formDto.getThemeColor());
        cheatsheet.setSlug(generateSlug(formDto.getTitle()));
        cheatsheet.setUser(loginUser); 
        
        if (formDto.getCategoryId() != null) {
            CategoryEntity category = sessionFactory.getCurrentSession()
                    .get(CategoryEntity.class, formDto.getCategoryId());
            cheatsheet.setCategory(category);
        }
        
        cheatsheet.setVisibility(CheatsheetVisibility.valueOf(formDto.getVisibility().toUpperCase()));
        cheatsheet.setPublishStatus(PublishStatus.PUBLISHED);
        cheatsheet.setStatus(ContentStatus.ACTIVE);
        
        cheatsheet.setViewCount(0);
        cheatsheet.setLikeCount(0);
        cheatsheet.setBookmarkCount(0);
        cheatsheet.setCommentCount(0);
        cheatsheet.setShareCount(0);
        cheatsheet.setReportCount(0);
        cheatsheet.setRatingAvg(BigDecimal.ZERO);
        cheatsheet.setCreatedAt(LocalDateTime.now());
        cheatsheet.setUpdatedAt(LocalDateTime.now());
        
        cheatsheetRepository.save(cheatsheet);
    }

    @Override
    @Transactional
    public void updateCheatsheetByAdmin(Long id, CheatsheetFormDto formDto, String contentStatus) {
        CheatsheetEntity existing = cheatsheetRepository.findById(id);
        if (existing != null) {
            existing.setTitle(formDto.getTitle());
            existing.setDescription(formDto.getDescription());
            existing.setThemeColor(formDto.getThemeColor());
            existing.setVisibility(CheatsheetVisibility.valueOf(formDto.getVisibility().toUpperCase()));
            
            if (contentStatus != null) {
                existing.setStatus(ContentStatus.valueOf(contentStatus.toUpperCase()));
            }
            
            if (formDto.getCategoryId() != null) {
                CategoryEntity category = sessionFactory.getCurrentSession()
                        .get(CategoryEntity.class, formDto.getCategoryId());
                existing.setCategory(category);
            }
            
            existing.setUpdatedAt(LocalDateTime.now());
            cheatsheetRepository.update(existing);
        }
    }

    @Override
    @Transactional
    public void deleteCheatsheet(Long id) {
        CheatsheetEntity cheatsheet = cheatsheetRepository.findById(id);
        if (cheatsheet != null) {
            cheatsheetRepository.delete(cheatsheet);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public CheatsheetEntity getById(Long id) {
        return cheatsheetRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CheatsheetEntity> getAllCheatsheets() {
        return cheatsheetRepository.findAll();
    }

    private String generateSlug(String title) {
        if (title == null) return "untitled";
        return title.toLowerCase()
                    .replaceAll("[^a-z0-9\\s]", "")
                    .replaceAll("\\s+", "-")
                    + "-" + (System.currentTimeMillis() % 100000);
    }
}