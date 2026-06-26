package com.hibernate.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hibernate.DTO.SearchResultDTO;
import com.hibernate.DTO.SearchSuggestionDTO;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.SearchService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/search")
public class SearchController {

	private final SearchService searchService;

	@GetMapping
	public String renderSearchResultsPage(@RequestParam(value = "query", required = false) String query,
			HttpSession session, Model model) {

		if (query != null && !query.trim().isEmpty()) {
			String cleanQuery = query.trim();
			UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
			Long userId = (currentUser != null) ? currentUser.getId() : null;

			// Fetch results and persist DB log if user is logged in
			SearchResultDTO searchResults = searchService.searchAll(cleanQuery, userId);
			model.addAttribute("results", searchResults);

			// Track history for guests via session
			if (userId == null) {
				List<String> guestHistory = (List<String>) session.getAttribute("guestSearchHistory");
				if (guestHistory == null) {
					guestHistory = new ArrayList<>();
				}

				if (!guestHistory.contains(cleanQuery)) {
					guestHistory.add(0, cleanQuery);
				}

				if (guestHistory.size() > 5) {
					guestHistory.remove(guestHistory.size() - 1);
				}

				session.setAttribute("guestSearchHistory", guestHistory);
			}
		}

		model.addAttribute("query", query);
		return "search-results"; // Returns search-results.jsp
	}

	@GetMapping("/live")
	@ResponseBody
	public List<SearchSuggestionDTO> liveSearch(@RequestParam("query") String query) {
		List<SearchSuggestionDTO> suggestions = new ArrayList<>();

		if (query == null || query.trim().isEmpty()) {
			return suggestions;
		}

		// Fetch your normal entities. This still triggers the SQL work beautifully.
		SearchResultDTO results = searchService.searchAll(query.trim(), null);

		// Manually extract just the fields the UI needs to display in the dropdown list
		if (results.getCheatsheets() != null) {
			for (CheatsheetEntity cs : results.getCheatsheets()) {

				suggestions.add(new SearchSuggestionDTO(cs.getId(), cs.getTitle(), "cheatsheet"));
			}
		}

		if (results.getCategories() != null) {
			for (CategoryEntity cat : results.getCategories()) {
				suggestions.add(new SearchSuggestionDTO(cat.getId(), cat.getName(), "category"));
			}
		}
		if (results.getUsers() != null) {
			for (UserEntity usr : results.getUsers()) {
				suggestions.add(new SearchSuggestionDTO(usr.getId(), usr.getName(), "user"));
			}
		}

		return suggestions;
	}

	@GetMapping("/history")
	@ResponseBody
	public List<?> getHistory(HttpSession session) {
		UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
		if (currentUser != null) {
			// Returns DB rows: List<SearchLogEntity>
			return searchService.getSearchLogByUserId(currentUser.getId());
		}
		List<String> guestHistory = (List<String>) session.getAttribute("guestSearchHistory");
		if (guestHistory == null) {
			return new java.util.ArrayList<String>();
		}
		return guestHistory;
	}
}