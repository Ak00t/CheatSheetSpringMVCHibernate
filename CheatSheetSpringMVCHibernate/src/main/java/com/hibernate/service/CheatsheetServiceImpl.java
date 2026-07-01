package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.*;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.repository.*;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class CheatsheetServiceImpl implements CheatsheetService {

    private final CheatsheetRepository cheatsheetRepository;
    private final CheatsheetTagRepository cheatsheetTagRepository;
    private final CheatsheetSectionRepository cheatsheetSectionRepository;
    private final CheatsheetRowRepository cheatsheetRowRepository;
    private final CheatsheetRowCellRepository cheatsheetRowCellRepository;
    private final CheatsheetNoteRepository cheatsheetNoteRepository;
    private final CheatsheetMediaRepository cheatsheetMediaRepository;
    private final TagRequestRepository tagRequestRepository;

    @Override
    public Long saveCheatsheet(CheatsheetEntity cheatsheet) {
        return cheatsheetRepository.save(cheatsheet);
    }

  
    @Override
    public void saveCheatsheetTag(Long cheatsheetId, Long tagId) {
        cheatsheetTagRepository.save(cheatsheetId, tagId);
    }
    

    @Override
    public void saveSection(CheatsheetSectionEntity section) {
        cheatsheetSectionRepository.save(section);
    }

    @Override
    public void saveRow(CheatsheetRowEntity row) {
        cheatsheetRowRepository.save(row);
    }

    @Override
    public void saveRowCell(CheatsheetRowCellEntity cell) {
        cheatsheetRowCellRepository.save(cell);
    }

    @Override
    public void saveNote(CheatsheetNoteEntity note) {
        cheatsheetNoteRepository.save(note);
    }

    @Override
    public void saveMedia(CheatsheetMediaEntity media) {
        cheatsheetMediaRepository.save(media);
    }

    @Override
    public void saveTagRequest(TagRequestEntity request) {
        tagRequestRepository.save(request);
    }
    
    //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
    
    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByCategoryId(Long categoryId) {
        return cheatsheetRepository
                .findPublishedCheatsheetsByCategoryId(categoryId);
    }
    // child tag နှိပ်ရင် ပေါ်လာမယ့် view -- cheatsheetcard list

    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId) {
        return cheatsheetRepository.findPublishedCheatsheetsByTagId(tagId);
    }
    
    //cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
 // CheatsheetServiceImpl.java ထဲတွင် တိုးရန်
    @Override
    public CheatsheetEntity findDetailsById(Long id) {
        return cheatsheetRepository.findDetailsById(id);
    }
 // profile view မှာ userId အလိုက် cheatsheet list ထုတ်ရန်
    @Override
    public List<CheatsheetEntity> findProfileCheatsheetByUserId(Long userId) {
        return cheatsheetRepository.findProfileCheatsheetByUserId(userId);
    }

    @Override
    public CheatsheetEntity findById(Long id) {
        return cheatsheetRepository.findById(id);
    }

    @Override
    public void updateCheatsheet(CheatsheetEntity cheatsheet) {
        cheatsheetRepository.update(cheatsheet);
    }

    @Override
    public void softDeleteCheatsheet(Long id) {

        CheatsheetEntity cheatsheet = cheatsheetRepository.findById(id);

        if (cheatsheet != null) {
            cheatsheet.setStatus(ContentStatus.DELETED);
            cheatsheetRepository.update(cheatsheet);
        }
    }
    // profile view မှာ userId အလိုက် cheatsheet detail view  ထုတ်ရန်
    @Override
    public CheatsheetEntity findProfileDetailById(Long id) {
        return cheatsheetRepository.findProfileDetailById(id);
    }
    
    
    // profile edit အတွက် edit view မှာ မူလ old data များ ပြန်ပေါ်ရန် 
 // 🌟 CheatsheetServiceImpl.java ထဲတွင် ဤမိတ်သတ်အသစ်အား တိုးပေးပါ
    @Override
    public CheatsheetEntity findDetailsForEdit(Long id) {
        // ၁။ Sections, Rows, Cells ပါဝင်ပြီးသား entity အား ဆွဲထုတ်သည်
        CheatsheetEntity cheatsheet = cheatsheetRepository.findDetailsById(id);
        
        if (cheatsheet != null && cheatsheet.getTags() != null) {
            // ၂။ 🌟 Transaction Session မပိတ်ခင် tags collection အား အတင်း initialize လုပ်ပေးလိုက်ခြင်းဖြင့် JSP တွင် Lazy Error မတက်တော့ပါ။
            cheatsheet.getTags().size(); 
        }
        
        return cheatsheet;
    }
    //profile cheatsheet update အတွက် လိုအပ်သော method( profile cheatsheet controller ရဲ့ update method နဲ့ အတွဲ)
 // profile cheatsheet update အတွက် လိုအပ်သော method( profile cheatsheet controller ရဲ့ update method နဲ့ အတွဲ)

    @Override
    public CheatsheetEntity findVisibleCheatsheet(
            Long cheatsheetId,
            Long loginUserId) {

        return cheatsheetRepository.findVisibleCheatsheet(
                cheatsheetId,
                loginUserId);
    }

    }
    
    
    
