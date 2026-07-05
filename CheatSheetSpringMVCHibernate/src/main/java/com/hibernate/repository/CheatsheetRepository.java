package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.CheatsheetEntity;

public interface CheatsheetRepository {

    Long save(CheatsheetEntity cheatsheet);

    CheatsheetEntity findById(Long id);

    void update(CheatsheetEntity cheatsheet);
    
    
    
    
    List<CheatsheetEntity> findPublishedCheatsheetsByCategoryId(Long categoryId);
    
 
    List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId);
    
   
    CheatsheetEntity findDetailsById(Long id);
    
 
    List<CheatsheetEntity> findProfileCheatsheetByUserId(Long userId);
   
    CheatsheetEntity findProfileDetailById(Long id);

    CheatsheetEntity findVisibleCheatsheet(Long cheatsheetId, Long loginUserId);

      //final
    // =========================
    // Home Page Statistics
    // =========================

    long countPublicCheatsheets();

    List<CheatsheetEntity> findPopularCheatsheets(int limit);

    List<CheatsheetEntity> findRecentCheatsheets(int limit);

    List<CheatsheetEntity> findPopularByParentCategoryId(Long parentId);

    List<CheatsheetEntity> findRecentByParentCategoryId(Long parentId);
    
 // =========================
 // Child Category View
 // =========================

 // Popular Cheatsheets by Child Category
 List<CheatsheetEntity> findPopularByCategoryId(
         Long categoryId);

 
 // Recent Cheatsheets by Child Category
 List<CheatsheetEntity> findRecentByCategoryId(
         Long categoryId);
    //pagination
 List<CheatsheetEntity> findPublishedCheatsheetsByCategoryIdWithPagination(
	        Long categoryId,
	        int page,
	        int size);

	long countPublishedCheatsheetsByCategoryId(Long categoryId);

	List<CheatsheetEntity> findPublishedCheatsheetsByTagIdWithPagination(
	        Long tagId,
	        int page,
	        int size);

	long countPublishedCheatsheetsByTagId(Long tagId);
	
	
	// profile cheatsheet list status 
	List<CheatsheetEntity> findPublishedByUserId(Long userId);

	List<CheatsheetEntity> findDraftByUserId(Long userId);

	List<CheatsheetEntity> findArchivedByUserId(Long userId);

	List<CheatsheetEntity> findPrivateByUserId(Long userId);
	
	
	long countAllByUserId(Long userId);
	
	List<CheatsheetEntity> findUnlistedByUserId(
	        Long userId);
	
	List<CheatsheetEntity> findPublicSheetsOfFollowersByUserId(Long userId);
    }
    
    
