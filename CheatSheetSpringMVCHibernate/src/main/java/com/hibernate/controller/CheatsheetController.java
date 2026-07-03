package com.hibernate.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.hibernate.entity.*;
import com.hibernate.entity.enums.*;
import com.hibernate.service.CategoryService;
import com.hibernate.service.CheatsheetService;
import com.hibernate.service.TagService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/cheatsheet")
public class CheatsheetController {

    private final CategoryService categoryService;
    private final TagService tagService;
    private final CheatsheetService cheatsheetService;
    private final ServletContext servletContext;

    @GetMapping("/create")
    public String createPage(Model model) {
        model.addAttribute("cheatsheet", new CheatsheetEntity());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("tags", tagService.findAll());
        return "cheatsheet-create";
    }

	
    
    
    @PostMapping("/save")
    public String saveCheatsheet(
            @RequestParam Long categoryId,
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) String themeColor,
            @RequestParam String action,
            @RequestParam(required = false) Long[] tagIds,
            @RequestParam(required = false) String[] requestedTags,
            @RequestParam(required = false) Integer[] sectionIndexes,
            @RequestParam(required = false) String[] sectionTitles,
            @RequestParam(required = false) MultipartFile coverPhoto,
            HttpSession session,
            HttpServletRequest request) throws IOException {

        UserEntity user = (UserEntity) session.getAttribute("currentUser");

        if (user == null) {
            return "redirect:/";
        }

        CategoryEntity category = categoryService.findById(categoryId);

        CheatsheetEntity cheatsheet = new CheatsheetEntity();
        cheatsheet.setUser(user);
        cheatsheet.setCategory(category);
        cheatsheet.setTitle(title);
        cheatsheet.setSlug(makeSlug(title) + "-" + System.currentTimeMillis());
        cheatsheet.setDescription(description);
        cheatsheet.setThemeColor(themeColor);
        cheatsheet.setStatus(ContentStatus.ACTIVE);
        cheatsheet.setCreatedAt(LocalDateTime.now());
        cheatsheet.setUpdatedAt(LocalDateTime.now());

        if ("draft".equals(action)) {
            cheatsheet.setPublishStatus(PublishStatus.DRAFT);
            cheatsheet.setVisibility(CheatsheetVisibility.PRIVATE);
        } else {
            cheatsheet.setPublishStatus(PublishStatus.PUBLISHED);
            cheatsheet.setVisibility(CheatsheetVisibility.PUBLIC);
        }

        Long cheatsheetId = cheatsheetService.saveCheatsheet(cheatsheet);

        if (tagIds != null) {
            for (Long tagId : tagIds) {
                cheatsheetService.saveCheatsheetTag(cheatsheetId, tagId);
            }
        }

        if (requestedTags != null) {
            for (String tagName : requestedTags) {
                if (tagName != null && !tagName.trim().isEmpty()) {
                    TagRequestEntity tagRequest = new TagRequestEntity();
                    tagRequest.setName(tagName.trim());
                    tagRequest.setStatus(TagRequestStatus.PENDING);
                    tagRequest.setCategory(category);
                    tagRequest.setRequestedBy(user);
                    tagRequest.setCreatedAt(LocalDateTime.now());
                    cheatsheetService.saveTagRequest(tagRequest);
                }
            }
        }

        if (sectionIndexes != null && sectionTitles != null) {
            for (int i = 0; i < sectionIndexes.length; i++) {
                Integer sectionIndex = sectionIndexes[i];
                String sectionTitle = sectionTitles[i];

                if (sectionTitle == null || sectionTitle.trim().isEmpty()) {
                    continue;
                }

                CheatsheetSectionEntity section = new CheatsheetSectionEntity();
                section.setCheatsheet(cheatsheet);
                section.setTitle(sectionTitle.trim());
                section.setSortOrder(i);
                section.setCreatedAt(LocalDateTime.now());
                cheatsheetService.saveSection(section);

                String[] rowTitles = request.getParameterValues("rowTitles_" + sectionIndex);
                String[] cellKeys = request.getParameterValues("cellKeys_" + sectionIndex);
                String[] cellValues = request.getParameterValues("cellValues_" + sectionIndex);

                if (rowTitles != null) {
                    for (int r = 0; r < rowTitles.length; r++) {
                        if (rowTitles[r] == null || rowTitles[r].trim().isEmpty()) {
                            continue;
                        }

                        CheatsheetRowEntity row = new CheatsheetRowEntity();
                        row.setSection(section);
                        row.setRowTitle(rowTitles[r].trim());
                        row.setSortOrder(r);
                        row.setCreatedAt(LocalDateTime.now());
                        cheatsheetService.saveRow(row);

                        CheatsheetRowCellEntity cell = new CheatsheetRowCellEntity();
                        cell.setRow(row);
                        cell.setCellKey(cellKeys != null && r < cellKeys.length ? cellKeys[r] : "");
                        cell.setCellValue(cellValues != null && r < cellValues.length ? cellValues[r] : "");
                        cell.setSortOrder(r);
                        cheatsheetService.saveRowCell(cell);
                    }
                }

                String[] noteTitles = request.getParameterValues("noteTitles_" + sectionIndex);
                String[] noteContents = request.getParameterValues("noteContents_" + sectionIndex);

                if (noteTitles != null) {
                    for (int n = 0; n < noteTitles.length; n++) {
                        if ((noteTitles[n] == null || noteTitles[n].trim().isEmpty())
                                && (noteContents == null || n >= noteContents.length || noteContents[n].trim().isEmpty())) {
                            continue;
                        }

                        CheatsheetNoteEntity note = new CheatsheetNoteEntity();
                        note.setCheatsheet(cheatsheet);
                        note.setSection(section);
                        note.setNoteTitle(noteTitles[n]);
                        note.setNoteContent(noteContents != null && n < noteContents.length ? noteContents[n] : "");
                        note.setSortOrder(n);
                        note.setCreatedAt(LocalDateTime.now());
                        cheatsheetService.saveNote(note);
                    }
                }
            }
        }

        if (coverPhoto != null && !coverPhoto.isEmpty()) {
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
            String fileName = "cheatsheet_" + cheatsheetId + "_" + System.currentTimeMillis() + "_" + cleanFileName;

            File serverFile = new File(uploadDir + fileName);
            coverPhoto.transferTo(serverFile);

            String relativePath = request.getContextPath()
                    + "/admin/cheatsheet/uploads/"
                    + fileName;

            CheatsheetMediaEntity media = new CheatsheetMediaEntity();
            media.setCheatsheet(cheatsheet);
            media.setMediaType(MediaType.IMAGE);
            media.setMediaUrl(relativePath);
            media.setCaption(title);
            media.setSortOrder(0);
            media.setCreatedAt(LocalDateTime.now());

            cheatsheetService.saveMedia(media);
        }

        return "redirect:/admin/cheatsheet/create";
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

    private String makeSlug(String text) {
        if (text == null) {
            return "";
        }

        return text.toLowerCase()
                .trim()
                .replaceAll("[^a-z0-9\\s-]", "")
                .replaceAll("\\s+", "-")
                .replaceAll("-+", "-");
    }
}