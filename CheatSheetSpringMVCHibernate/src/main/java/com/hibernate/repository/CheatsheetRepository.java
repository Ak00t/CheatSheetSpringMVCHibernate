package com.hibernate.repository;

import java.util.List;
import com.hibernate.entity.CheatsheetEntity;

public interface CheatsheetRepository {
    public void save(CheatsheetEntity cheatsheet);
    public void update(CheatsheetEntity cheatsheet);
    public void delete(CheatsheetEntity cheatsheet);
    public CheatsheetEntity findById(Long id);
    public List<CheatsheetEntity> findAll();
}