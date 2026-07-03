package com.hibernate.service;

import com.hibernate.entity.CheatsheetEntity;
import java.util.List;

public interface TopRatingService {
    List<CheatsheetEntity> getTopRatingList(String type, Integer year, Integer month, Integer week, String day);
}