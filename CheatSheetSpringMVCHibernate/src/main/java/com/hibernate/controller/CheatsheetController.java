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
						// 🌟 [ပြင်ဆင်ချက်] fileValues မှ cellValues သို့ စာလုံးပေါင်း အမှန်ပြင်ထားပါသည်
						cell.setCellValue(cellValues != null && r < cellValues.length ? cellValues[r] : "");
						cell.setSortOrder(r);

						cheatsheetService.saveRowCell(cell);
					}
				}

				String[] noteTitles = request.getParameterValues("noteTitles_" + sectionIndex);
				String[] noteContents = request.getParameterValues("noteContents_" + sectionIndex);

				if (noteTitles != null) {
					for (int n = 0; n < noteTitles.length; n++) {

						if ((noteTitles[n] == null || noteTitles[n].trim().isEmpty()) && (noteContents == null
								|| n >= noteContents.length || noteContents[n].trim().isEmpty())) {
							continue;
						}

     // CheatsheetController.java ၏ saveCheatsheet method
        if (coverPhoto != null && !coverPhoto.isEmpty()) {
            
            // Cheatsheet အတွက် သီးသန့် Folder Path
            String uploadDir = "C:/upload/cheatsheets/"; 
            File dir = new File(uploadDir);

		if (coverPhoto != null && !coverPhoto.isEmpty()) {

            String fileName = System.currentTimeMillis() + "_" + coverPhoto.getOriginalFilename();
            File file = new File(dir, fileName);
            coverPhoto.transferTo(file); 

            CheatsheetMediaEntity media = new CheatsheetMediaEntity();
            media.setCheatsheet(cheatsheet);
            media.setMediaType(MediaType.IMAGE);
            media.setMediaUrl(fileName); // ဖိုင်နာမည်အမှန်ကို သိမ်းပါ
            media.setCaption(title);
            media.setSortOrder(0);
            media.setCreatedAt(LocalDateTime.now());

            cheatsheetService.saveMedia(media);
        }
        return "redirect:/admin/cheatsheet/create";
    }

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