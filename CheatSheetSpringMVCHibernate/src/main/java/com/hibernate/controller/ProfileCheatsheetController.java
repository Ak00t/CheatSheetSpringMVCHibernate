package com.hibernate.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
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

	/*
	 * @RequestMapping("/{userId}") public String list(@PathVariable Long userId,
	 * Model model) { model.addAttribute("userId", userId);
	 * model.addAttribute("cheatsheets",
	 * cheatsheetService.findProfileCheatsheetByUserId(userId)); return
	 * "profile-cheatsheet-list"; }
	 */
    
    
    @RequestMapping
    public String list(HttpSession session, Model model) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        Long userId = currentUser.getId();

        model.addAttribute("userId", userId);

        model.addAttribute(
                "cheatsheets",
                cheatsheetService.findProfileCheatsheetByUserId(userId));

        return "profile-cheatsheet-list";
    }
    
	/*
	 * @RequestMapping("/detail/{id}") public String detail(@PathVariable Long id,
	 * Model model) { model.addAttribute("cheatsheet",
	 * cheatsheetService.findDetailsById(id)); model.addAttribute("comments",
	 * commentService.selectCommentsByCheatsheetId(id)); return
	 * "profile-cheatsheet-detail"; }
	 * 
	 * @RequestMapping("/edit/{id}") public String edit(@PathVariable Long id, Model
	 * model) { model.addAttribute("cheatsheet",
	 * cheatsheetService.findDetailsForEdit(id)); return "profile-cheatsheet-edit";
	 * }
	 * 
	 * @PostMapping("/update") public String update(@RequestParam Long id,
	 * 
	 * @RequestParam String title,
	 * 
	 * @RequestParam(required = false) String description,
	 * 
	 * @RequestParam(required = false) String themeColor,
	 * 
	 * @RequestParam PublishStatus publishStatus,
	 * 
	 * @RequestParam CheatsheetVisibility visibility,
	 * 
	 * @RequestParam Long categoryId,
	 * 
	 * @RequestParam(value = "coverPhoto", required = false)
	 * org.springframework.web.multipart.MultipartFile coverPhoto,
	 * 
	 * @RequestParam(value = "sectionIndexes", required = false) List<Integer>
	 * sectionIndexes,
	 * 
	 * @RequestParam(value = "sectionTitles", required = false) List<String>
	 * sectionTitles,
	 * 
	 * @RequestParam(value = "tagIds", required = false) List<Long> tagIds,
	 * javax.servlet.http.HttpServletRequest request) {
	 * 
	 * CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id); String
	 * existingSlug = cheatsheet.getSlug(); Long userId =
	 * cheatsheet.getUser().getId();
	 * 
	 * if (cheatsheet.getNotes() != null) cheatsheet.getNotes().clear();
	 * 
	 * if (cheatsheet.getSections() != null) { for
	 * (com.hibernate.entity.CheatsheetSectionEntity sec : cheatsheet.getSections())
	 * { if (sec.getNotes() != null) sec.getNotes().clear();
	 * 
	 * if (sec.getRows() != null) { for (com.hibernate.entity.CheatsheetRowEntity
	 * row : sec.getRows()) { if (row.getCells() != null) row.getCells().clear(); }
	 * sec.getRows().clear(); } } cheatsheet.getSections().clear(); } else {
	 * cheatsheet.setSections(new java.util.ArrayList<>()); }
	 * 
	 * cheatsheet.setTitle(title); cheatsheet.setSlug(existingSlug);
	 * cheatsheet.setDescription(description); cheatsheet.setThemeColor(themeColor);
	 * cheatsheet.setPublishStatus(publishStatus);
	 * cheatsheet.setVisibility(visibility);
	 * cheatsheet.setUpdatedAt(LocalDateTime.now());
	 * 
	 * com.hibernate.entity.CategoryEntity category = new
	 * com.hibernate.entity.CategoryEntity(); category.setId(categoryId);
	 * cheatsheet.setCategory(category);
	 * 
	 * if (coverPhoto != null && !coverPhoto.isEmpty()) { try { String userHome =
	 * System.getProperty("user.home");
	 * 
	 * String uploadDir = userHome + File.separator + "app_uploads" + File.separator
	 * + "cheatsheets" + File.separator;
	 * 
	 * File dir = new File(uploadDir); if (!dir.exists()) { dir.mkdirs(); }
	 * 
	 * String originalName = coverPhoto.getOriginalFilename(); if (originalName ==
	 * null) { originalName = "cover.jpg"; }
	 * 
	 * String cleanFileName = originalName.replaceAll("\\s+", "_"); String fileName
	 * = "cheatsheet_" + id + "_" + System.currentTimeMillis() + "_" +
	 * cleanFileName;
	 * 
	 * File serverFile = new File(uploadDir + fileName);
	 * coverPhoto.transferTo(serverFile);
	 * 
	 * String dbMediaUrl = request.getContextPath() +
	 * "/profile-cheatsheets/uploads/" + fileName;
	 * 
	 * if (cheatsheet.getMediaList() == null) { cheatsheet.setMediaList(new
	 * java.util.ArrayList<>()); } else { cheatsheet.getMediaList().clear(); }
	 * 
	 * com.hibernate.entity.CheatsheetMediaEntity media = new
	 * com.hibernate.entity.CheatsheetMediaEntity(); media.setMediaUrl(dbMediaUrl);
	 * media.setMediaType(com.hibernate.entity.enums.MediaType.IMAGE);
	 * media.setCheatsheet(cheatsheet); media.setCaption(title);
	 * media.setSortOrder(0); media.setCreatedAt(LocalDateTime.now());
	 * 
	 * cheatsheet.getMediaList().add(media);
	 * 
	 * } catch (Exception e) { e.printStackTrace(); } }
	 * 
	 * if (sectionIndexes != null) { for (int i = 0; i < sectionIndexes.size(); i++)
	 * { int actualIdx = sectionIndexes.get(i);
	 * 
	 * com.hibernate.entity.CheatsheetSectionEntity section = new
	 * com.hibernate.entity.CheatsheetSectionEntity();
	 * section.setTitle((sectionTitles != null && i < sectionTitles.size()) ?
	 * sectionTitles.get(i) : ""); section.setCheatsheet(cheatsheet);
	 * section.setRows(new java.util.ArrayList<>()); section.setNotes(new
	 * java.util.ArrayList<>());
	 * 
	 * String[] rowTitles = request.getParameterValues("rowTitles_" + actualIdx);
	 * String[] cellKeys = request.getParameterValues("cellKeys_" + actualIdx);
	 * String[] cellValues = request.getParameterValues("cellValues_" + actualIdx);
	 * 
	 * if (rowTitles != null) { for (int r = 0; r < rowTitles.length; r++) {
	 * com.hibernate.entity.CheatsheetRowEntity row = new
	 * com.hibernate.entity.CheatsheetRowEntity(); row.setRowTitle(rowTitles[r]);
	 * row.setSection(section);
	 * 
	 * com.hibernate.entity.CheatsheetRowCellEntity cell = new
	 * com.hibernate.entity.CheatsheetRowCellEntity(); cell.setCellKey(cellKeys !=
	 * null && r < cellKeys.length ? cellKeys[r] : ""); cell.setCellValue(cellValues
	 * != null && r < cellValues.length ? cellValues[r] : ""); cell.setRow(row);
	 * 
	 * row.setCells(java.util.Arrays.asList(cell)); section.getRows().add(row); } }
	 * 
	 * String[] noteTitles = request.getParameterValues("noteTitles_" + actualIdx);
	 * String[] noteContents = request.getParameterValues("noteContents_" +
	 * actualIdx);
	 * 
	 * if (noteContents != null) { for (int n = 0; n < noteContents.length; n++) {
	 * com.hibernate.entity.CheatsheetNoteEntity note = new
	 * com.hibernate.entity.CheatsheetNoteEntity(); note.setNoteTitle(noteTitles !=
	 * null && n < noteTitles.length ? noteTitles[n] : "");
	 * note.setNoteContent(noteContents[n]); note.setSection(section);
	 * note.setCheatsheet(cheatsheet); section.getNotes().add(note); } }
	 * 
	 * cheatsheet.getSections().add(section); } }
	 * 
	 * cheatsheetService.updateCheatsheet(cheatsheet); return
	 * "redirect:/profile-cheatsheets/" + userId; }
	 * 
	 * @GetMapping("/uploads/{fileName:.+}")
	 * 
	 * @ResponseBody public ResponseEntity<byte[]> getCheatsheetImage(@PathVariable
	 * String fileName) { try { String userHome = System.getProperty("user.home");
	 * 
	 * File file = new File(userHome + File.separator + "app_uploads" +
	 * File.separator + "cheatsheets" + File.separator + fileName);
	 * 
	 * if (file.exists()) { byte[] imageBytes = Files.readAllBytes(file.toPath());
	 * return ResponseEntity.ok().body(imageBytes); }
	 * 
	 * } catch (IOException e) { e.printStackTrace(); }
	 * 
	 * return ResponseEntity.notFound().build(); }
	 * 
	 * @PostMapping("/delete/{id}") public String delete(@PathVariable Long id) {
	 * CheatsheetEntity cheatsheet = cheatsheetService.findProfileDetailById(id);
	 * Long userId = cheatsheet.getUser().getId();
	 * cheatsheetService.softDeleteCheatsheet(id); return
	 * "redirect:/profile-cheatsheets/" + userId; }
	 */
    
    
    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable Long id,
                         HttpSession session,
                         Model model) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        CheatsheetEntity cheatsheet =
                cheatsheetService.findDetailsById(id);

        if (!cheatsheet.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/profile-cheatsheets";
        }

        model.addAttribute("cheatsheet", cheatsheet);
        model.addAttribute("comments", commentService.selectCommentsByCheatsheetId(id));

        return "profile-cheatsheet-detail";
    }

    @RequestMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                       HttpSession session,
                       Model model) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        CheatsheetEntity cheatsheet =
                cheatsheetService.findDetailsForEdit(id);

        if (!cheatsheet.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/profile-cheatsheets";
        }

        model.addAttribute("cheatsheet", cheatsheet);

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
                         HttpSession session,
                         javax.servlet.http.HttpServletRequest request) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id);

        if (!cheatsheet.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/profile-cheatsheets";
        }

        String existingSlug = cheatsheet.getSlug();
        Long userId = currentUser.getId();

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

        if (coverPhoto != null && !coverPhoto.isEmpty()) {
            try {
                String userHome = System.getProperty("user.home");

                String uploadDir = userHome
                        + File.separator + "app_uploads"
                        + File.separator + "cheatsheets"
                        + File.separator;

                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String originalName = coverPhoto.getOriginalFilename();
                if (originalName == null) {
                    originalName = "cover.jpg";
                }

                String cleanFileName = originalName.replaceAll("\\s+", "_");
                String fileName = "cheatsheet_" + id + "_" + System.currentTimeMillis() + "_" + cleanFileName;

                File serverFile = new File(uploadDir + fileName);
                coverPhoto.transferTo(serverFile);

                String dbMediaUrl = request.getContextPath()
                        + "/profile-cheatsheets/uploads/"
                        + fileName;

                if (cheatsheet.getMediaList() == null) {
                    cheatsheet.setMediaList(new java.util.ArrayList<>());
                } else {
                    cheatsheet.getMediaList().clear();
                }

                com.hibernate.entity.CheatsheetMediaEntity media = new com.hibernate.entity.CheatsheetMediaEntity();
                media.setMediaUrl(dbMediaUrl);
                media.setMediaType(com.hibernate.entity.enums.MediaType.IMAGE);
                media.setCheatsheet(cheatsheet);
                media.setCaption(title);
                media.setSortOrder(0);
                media.setCreatedAt(LocalDateTime.now());

                cheatsheet.getMediaList().add(media);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (sectionIndexes != null) {
            for (int i = 0; i < sectionIndexes.size(); i++) {
                int actualIdx = sectionIndexes.get(i);

                com.hibernate.entity.CheatsheetSectionEntity section = new com.hibernate.entity.CheatsheetSectionEntity();
                section.setTitle((sectionTitles != null && i < sectionTitles.size()) ? sectionTitles.get(i) : "");
                section.setCheatsheet(cheatsheet);
                section.setRows(new java.util.ArrayList<>());
                section.setNotes(new java.util.ArrayList<>());

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

        return "redirect:/profile-cheatsheets";
    }

    @GetMapping("/uploads/{fileName:.+}")
    @ResponseBody
    public ResponseEntity<byte[]> getCheatsheetImage(@PathVariable String fileName) {
        try {
            String userHome = System.getProperty("user.home");

            File file = new File(userHome
                    + File.separator + "app_uploads"
                    + File.separator + "cheatsheets"
                    + File.separator + fileName);

            if (file.exists()) {
                byte[] imageBytes = Files.readAllBytes(file.toPath());
                return ResponseEntity.ok().body(imageBytes);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return ResponseEntity.notFound().build();
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id,
                         HttpSession session) {

        UserEntity currentUser =
                (UserEntity) session.getAttribute("currentUser");

        if (currentUser == null) {
            return "redirect:/";
        }

        CheatsheetEntity cheatsheet = cheatsheetService.findProfileDetailById(id);

        if (!cheatsheet.getUser().getId().equals(currentUser.getId())) {
            return "redirect:/profile-cheatsheets";
        }

        cheatsheetService.softDeleteCheatsheet(id);

        return "redirect:/profile-cheatsheets";
    }
    
    
    
}