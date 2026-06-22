package com.hibernate.service;

import java.util.List;

import com.hibernate.DTO.CheatsheetFormDto;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;

public interface CheatsheetService {
    public void createNewCheatsheet(CheatsheetFormDto formDto, UserEntity loginUser);
    public void updateCheatsheetByAdmin(Long id, CheatsheetFormDto formDto, String contentStatus);
    public void deleteCheatsheet(Long id);
    public CheatsheetEntity getById(Long id);
    public List<CheatsheetEntity> getAllCheatsheets();
}