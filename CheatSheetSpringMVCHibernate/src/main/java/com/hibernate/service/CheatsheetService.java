package com.hibernate.service;



import java.util.List;

import com.hibernate.entity.*;

public interface CheatsheetService {

    Long saveCheatsheet(CheatsheetEntity cheatsheet);

    void saveCheatsheetTag(Long cheatsheetId, Long tagId);

    void saveSection(CheatsheetSectionEntity section);

    void saveRow(CheatsheetRowEntity row);

    void saveRowCell(CheatsheetRowCellEntity cell);

    void saveNote(CheatsheetNoteEntity note);

    void saveMedia(CheatsheetMediaEntity media);

    void saveTagRequest(TagRequestEntity request);
    
    
    //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
    List<CheatsheetEntity> findPublishedCheatsheetsByCategoryId(Long categoryId);
 // child tag နှိပ်ရင် ပေါ်လာမယ့် view -- cheatsheetcard list
    List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId);
    //cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
 // CheatsheetService.java ထဲတွင် တိုးရန်
    CheatsheetEntity findDetailsById(Long id);
    
 // profile view မှာ userId အလိုက် cheatsheet list ထုတ်ရန်
    
    List<CheatsheetEntity> findProfileCheatsheetByUserId(Long userId);

    CheatsheetEntity findById(Long id);

    void updateCheatsheet(CheatsheetEntity cheatsheet);

    void softDeleteCheatsheet(Long id);
    
 // profile view မှာ userId အလိုက် cheatsheet detail view  ထုတ်ရန်
    CheatsheetEntity findProfileDetailById(Long id);
    // profile edit အတွက် edit view မှာ မူလ old data များ ပြန်ပေါ်ရန်
	CheatsheetEntity findDetailsForEdit(Long id);
	 //profile cheatsheet update အတွက် လိုအပ်သော method( profile cheatsheet controller ရဲ့ update method နဲ့ အတွဲ)
	
	

}