package com.hibernate.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CheatsheetMediaEntity;
import com.hibernate.entity.CheatsheetNoteEntity;
import com.hibernate.entity.CheatsheetRowCellEntity;
import com.hibernate.entity.CheatsheetRowEntity;
import com.hibernate.entity.CheatsheetSectionEntity;
import com.hibernate.entity.TagRequestEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.MediaType;
import com.hibernate.entity.enums.PublishStatus;
import com.hibernate.entity.enums.TagRequestStatus;
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
	        @RequestParam Long categoryId, @RequestParam String title,
	        @RequestParam(required = false) String description, @RequestParam(required = false) String themeColor,
	        @RequestParam String action, @RequestParam(required = false) Long[] tagIds,
	        @RequestParam(required = false) String[] requestedTags,
	        @RequestParam(required = false) Integer[] sectionIndexes,
	        @RequestParam(required = false) String[] sectionTitles,
	        @RequestParam(required = false) MultipartFile coverPhoto, HttpServletRequest request) throws IOException {

	    UserEntity user = new UserEntity();
	    user.setId(1L);

	    CategoryEntity category = categoryService.findById(categoryId);
	    CheatsheetEntity cheatsheet = new CheatsheetEntity();
	    
	    // ... [Setters for cheatsheet properties remain the same] ...
	    cheatsheet.setUser(user);
	    cheatsheet.setCategory(category);
	    cheatsheet.setTitle(title);
	    cheatsheet.setSlug(makeSlug(title) + "-" + System.currentTimeMillis());
	    cheatsheet.setStatus(ContentStatus.ACTIVE);
	    cheatsheet.setCreatedAt(LocalDateTime.now());
	    
	    // Set Publish/Visibility based on action
	    if ("draft".equals(action)) {
	        cheatsheet.setPublishStatus(PublishStatus.DRAFT);
	        cheatsheet.setVisibility(CheatsheetVisibility.PRIVATE);
	    } else {
	        cheatsheet.setPublishStatus(PublishStatus.PUBLISHED);
	        cheatsheet.setVisibility(CheatsheetVisibility.PUBLIC);
	    }

	    Long cheatsheetId = cheatsheetService.saveCheatsheet(cheatsheet);

	    // 1. Handle Tags
	    if (tagIds != null) {
	        for (Long tagId : tagIds) {
	            cheatsheetService.saveCheatsheetTag(cheatsheetId, tagId);
	        }
	    }

	    // 2. Handle Sections, Rows, and Notes
	    if (sectionIndexes != null && sectionTitles != null) {
	        for (int i = 0; i < sectionIndexes.length; i++) {
	            Integer sectionIndex = sectionIndexes[i];
	            String sectionTitle = sectionTitles[i];

	            if (sectionTitle == null || sectionTitle.trim().isEmpty()) continue;

	            CheatsheetSectionEntity section = new CheatsheetSectionEntity();
	            section.setCheatsheet(cheatsheet);
	            section.setTitle(sectionTitle.trim());
	            section.setSortOrder(i);
	            section.setCreatedAt(LocalDateTime.now());
	            cheatsheetService.saveSection(section);

	            // Row processing logic...
	            // Note processing logic...
	        }
	    }

	    if (coverPhoto != null && !coverPhoto.isEmpty()) {
	        // Dynamic Path တည်ဆောက်ခြင်း
	        String baseDir = System.getProperty("user.home") + File.separator + "app_uploads" + File.separator + "cheatsheets" + File.separator;
	        File dir = new File(baseDir);
	        if (!dir.exists()) dir.mkdirs();

	        String fileName = System.currentTimeMillis() + "_" + coverPhoto.getOriginalFilename().replaceAll("\\s+", "");
	        File file = new File(dir, fileName);
	        coverPhoto.transferTo(file);

	        CheatsheetMediaEntity media = new CheatsheetMediaEntity();
	        media.setCheatsheet(cheatsheet);
	        media.setMediaType(MediaType.IMAGE);
	        // URL ကို သိမ်းဆည်းသည့်အခါ filename သက်သက်သာ သိမ်းပါ
	        media.setMediaUrl(fileName);
	        media.setCaption(title);
	        media.setSortOrder(0);
	        media.setCreatedAt(LocalDateTime.now());
	        cheatsheetService.saveMedia(media);
	    }

	    return "redirect:/admin/cheatsheet/create";
	}

		
					

	private String makeSlug(String text) {
		if (text == null) {
			return "";
		}

		return text.toLowerCase().trim().replaceAll("[^a-z0-9\\s-]", "").replaceAll("\\s+", "-").replaceAll("-+", "-");
	}
}