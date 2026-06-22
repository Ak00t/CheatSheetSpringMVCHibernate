package com.hibernate.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.PublishStatus;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.CommentService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/profile-cheatsheets")
public class ProfileCheatsheetController {
	private final CommentService commentService;
    private final CheatsheetService cheatsheetService;

    // ၁။ User ID အလိုက် Cheatsheet List ထုတ်မည့် လမ်းကြောင်း
    @RequestMapping("/{userId}")
    public String list(@PathVariable Long userId, Model model) {
        model.addAttribute("userId", userId);
        model.addAttribute("cheatsheets", cheatsheetService.findProfileCheatsheetByUserId(userId));
        
       
        return "profile-cheatsheet-list";
    }

    // ၂။ Profile အောက်ရှိ Cheatsheet Detail View သို့ သွားမည့် လမ်းကြောင်း
    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("cheatsheet", cheatsheetService.findDetailsById(id));
        
        model.addAttribute(
                "comments",
                commentService.selectCommentById(id));
        return "profile-cheatsheet-detail";
    }

    // ၃။ Edit View Form သို့ သွားမည့် လမ်းကြောင်း
    @RequestMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        // Lazy tag exception အား ကျော်လွှားရန် နှိုးဆွထားသော service method အား သုံးစွဲခြင်း
        model.addAttribute("cheatsheet", cheatsheetService.findDetailsForEdit(id));
        return "profile-cheatsheet-edit";
    }

    
    @PostMapping("/update")
    public String update(@RequestParam Long id,
                         @RequestParam String title,
                         @RequestParam(required = false) String description,
                         @RequestParam(required = false) String themeColor,
                         @RequestParam PublishStatus publishStatus,
                         @RequestParam CheatsheetVisibility visibility,
                         @RequestParam Long categoryId,
                         @RequestParam(value = "coverPhoto", required = false) org.springframework.web.multipart.MultipartFile coverPhoto,
                         @RequestParam(value = "sectionIndexes", required = false) List<Integer> sectionIndexes,
                         @RequestParam(value = "sectionTitles", required = false) List<String> sectionTitles,
                         @RequestParam(value = "tagIds", required = false) List<Long> tagIds,
                         javax.servlet.http.HttpServletRequest request) {

        // ၁။ DB မှ Data ဆွဲထုတ်ခြင်း
        CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id);
        String existingSlug = cheatsheet.getSlug(); 
        Long userId = cheatsheet.getUser().getId();

        // ၂။ Cascade Error ကာကွယ်ရန် List များ ရှင်းလင်းခြင်း
        if (cheatsheet.getNotes() != null) cheatsheet.getNotes().clear();
        if (cheatsheet.getSections() != null) {
            for (com.hibernate.entity.CheatsheetSectionEntity sec : cheatsheet.getSections()) {
                if (sec.getNotes() != null) sec.getNotes().clear();
                if (sec.getRows() != null) {
                    for (com.hibernate.entity.CheatsheetRowEntity row : sec.getRows()) {
                        if (row.getCells() != null) row.getCells().clear();
                    }
                    sec.getRows().clear();
                }
            }
            cheatsheet.getSections().clear();
        } else {
            cheatsheet.setSections(new java.util.ArrayList<>());
        }

        // ၃။ Basic Fields Updates
        cheatsheet.setTitle(title);
        cheatsheet.setSlug(existingSlug);
        cheatsheet.setDescription(description);
        cheatsheet.setThemeColor(themeColor);
        cheatsheet.setPublishStatus(publishStatus);
        cheatsheet.setVisibility(visibility);
        cheatsheet.setUpdatedAt(LocalDateTime.now());
        
        com.hibernate.entity.CategoryEntity category = new com.hibernate.entity.CategoryEntity();
        category.setId(categoryId);
        cheatsheet.setCategory(category);

        // ၄။ Image ပုံသိမ်းဆည်းခြင်း
        if (coverPhoto != null && !coverPhoto.isEmpty()) {
            try {
                String uploadDir = System.getProperty("catalina.home") + java.io.File.separator + "webapps" + java.io.File.separator + "uploads" + java.io.File.separator;
                java.io.File dir = new java.io.File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = System.currentTimeMillis() + "_" + coverPhoto.getOriginalFilename().replaceAll("\\s+", "");
                coverPhoto.transferTo(new java.io.File(uploadDir + fileName));

                String dbMediaUrl = "/uploads/" + fileName;

                if (cheatsheet.getMediaList() == null) cheatsheet.setMediaList(new java.util.ArrayList<>());
                else cheatsheet.getMediaList().clear();
                
                com.hibernate.entity.CheatsheetMediaEntity media = new com.hibernate.entity.CheatsheetMediaEntity();
                media.setMediaUrl(dbMediaUrl);
                media.setMediaType(com.hibernate.entity.enums.MediaType.IMAGE);
                media.setCheatsheet(cheatsheet);
                cheatsheet.getMediaList().add(media);
            } catch (Exception e) { e.printStackTrace(); }
        }

        // ၅။ Tree Layout (Row & Note) ပြန်လည်တည်ဆောက်ခြင်း
        if (sectionIndexes != null) {
            for (int i = 0; i < sectionIndexes.size(); i++) {
                int actualIdx = sectionIndexes.get(i);
                
                com.hibernate.entity.CheatsheetSectionEntity section = new com.hibernate.entity.CheatsheetSectionEntity();
                section.setTitle((sectionTitles != null && i < sectionTitles.size()) ? sectionTitles.get(i) : "");
                section.setCheatsheet(cheatsheet);
                section.setRows(new java.util.ArrayList<>());
                section.setNotes(new java.util.ArrayList<>());

                // Row/Cell ဖမ်းခြင်း
                String[] rowTitles = request.getParameterValues("rowTitles_" + actualIdx);
                String[] cellKeys = request.getParameterValues("cellKeys_" + actualIdx);
                String[] cellValues = request.getParameterValues("cellValues_" + actualIdx);

                if (rowTitles != null) {
                    for (int r = 0; r < rowTitles.length; r++) {
                        com.hibernate.entity.CheatsheetRowEntity row = new com.hibernate.entity.CheatsheetRowEntity();
                        row.setRowTitle(rowTitles[r]);
                        row.setSection(section);
                        com.hibernate.entity.CheatsheetRowCellEntity cell = new com.hibernate.entity.CheatsheetRowCellEntity();
                        cell.setCellKey(cellKeys != null && r < cellKeys.length ? cellKeys[r] : "");
                        cell.setCellValue(cellValues != null && r < cellValues.length ? cellValues[r] : "");
                        cell.setRow(row);
                        row.setCells(java.util.Arrays.asList(cell));
                        section.getRows().add(row);
                    }
                }
                
                // Note ဖမ်းခြင်း
                String[] noteTitles = request.getParameterValues("noteTitles_" + actualIdx);
                String[] noteContents = request.getParameterValues("noteContents_" + actualIdx);
                if (noteContents != null) {
                    for (int n = 0; n < noteContents.length; n++) {
                        com.hibernate.entity.CheatsheetNoteEntity note = new com.hibernate.entity.CheatsheetNoteEntity();
                        note.setNoteTitle(noteTitles != null && n < noteTitles.length ? noteTitles[n] : "");
                        note.setNoteContent(noteContents[n]);
                        note.setSection(section);
                        note.setCheatsheet(cheatsheet);
                        section.getNotes().add(note);
                    }
                }
                cheatsheet.getSections().add(section);
            }
        }

        cheatsheetService.updateCheatsheet(cheatsheet);
        return "redirect:/profile-cheatsheets/" + userId;
    }
    
    
    
    // ၅။ Delete လုပ်ဆောင်မည့် လမ်းကြောင်း
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        CheatsheetEntity cheatsheet = cheatsheetService.findProfileDetailById(id);
        Long userId = cheatsheet.getUser().getId();
        cheatsheetService.softDeleteCheatsheet(id);
        return "redirect:/profile-cheatsheets/" + userId;
    }
}