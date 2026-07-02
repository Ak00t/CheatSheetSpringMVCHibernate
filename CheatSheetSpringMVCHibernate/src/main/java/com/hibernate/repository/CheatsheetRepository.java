package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.CheatsheetEntity;

public interface CheatsheetRepository {

    Long save(CheatsheetEntity cheatsheet);

    CheatsheetEntity findById(Long id);

    void update(CheatsheetEntity cheatsheet);
    
    
    //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatsheetcard list / tag list 
    
    List<CheatsheetEntity> findPublishedCheatsheetsByCategoryId(Long categoryId);
    
 // child tag နှိပ်ရင် ပေါ်လာမယ့် view -- cheatsheetcard list
    List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId);
    
   //cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
 // CheatsheetRepository.java ထဲတွင် ဤစာကြောင်း ထည့်ပေးပါ
    CheatsheetEntity findDetailsById(Long id);
    
 // profile view မှာ userId အလိုက် cheatsheet list ထုတ်ရန်
    List<CheatsheetEntity> findProfileCheatsheetByUserId(Long userId);
    // 🌟 ၂။ [နာမည်အသစ်] Profile Detail View အတွက် တစ်စောင်တည်းကို အသေးစိတ် ပြသမည့် မိတ်သတ် (Single Object ပြန်ပေးရမည်)
    CheatsheetEntity findProfileDetailById(Long id);
 // Profile / Public detail permission စစ်ပြီး ပြရန်
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

    }
    
    
