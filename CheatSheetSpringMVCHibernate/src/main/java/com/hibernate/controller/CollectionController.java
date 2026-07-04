package com.hibernate.controller;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/collection")
public class CollectionController {

    @Autowired
    private CollectionService collectionService;
    @Autowired
    private com.hibernate.service.CommentService commentService;
    @Autowired
    private com.hibernate.service.LikeService likeService;
    @Autowired
    private com.hibernate.service.BookmarkService bookmarkService;
    @Autowired
    private com.hibernate.service.CheatsheetService cheatsheetService;

    @GetMapping("/list")
    @ResponseBody
    public List<CollectionEntity> getCollectionList(HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        Long userId = (currentUser != null) ? currentUser.getId() : 1L;
        return collectionService.getCollectionsByInterface(userId, 1, 50);
    }

    @GetMapping("/manage")
    public String viewUserCollections(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/"; 
        }
        
        int pageSize = 6; 
        List<CollectionEntity> collections = collectionService.getCollectionsByInterface(currentUser.getId(), page, pageSize);
        
        List<CollectionEntity> nextPageCheck = collectionService.getCollectionsByInterface(currentUser.getId(), page + 1, pageSize);
        boolean hasMorePages = !nextPageCheck.isEmpty();

        model.addAttribute("collections", collections);
        model.addAttribute("currentPage", page);
        model.addAttribute("hasMorePages", hasMorePages); 
        return "user-collections"; 
    }

    @PostMapping("/create")
    @ResponseBody
    public String createCollection(@RequestParam String name, @RequestParam String visibility, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        Long userId = (currentUser != null) ? currentUser.getId() : 1L;
        collectionService.createCollection(userId, name, visibility);
        return "Collection Created Successfully";
    }

    @PostMapping("/update-visibility")
    @ResponseBody
    public String updateVisibility(@RequestParam Long collectionId, @RequestParam String visibility) {
        collectionService.updateCollectionVisibility(collectionId, visibility);
        return "Collection Privacy Updated Successfully";
    }

    // 💡 URL မူလအတိုင်းရှိစေပြီး ခေါ်ယူမည့် Service အား ပြောင်းလဲထားပါသည်
    @PostMapping("/add-to-playlist")
    @ResponseBody
    public String addToCollection(@RequestParam Long collectionId, @RequestParam Long cheatsheetId) {
        return collectionService.addItemToCollection(collectionId, cheatsheetId);
    }

    @GetMapping("/view/{id}")
    public String viewCollectionDetail(@PathVariable Long id, Model model, HttpSession session) {
        CollectionEntity collection = collectionService.findById(id); 
        if (collection == null) {
            model.addAttribute("errorMessage", "This collection does not exist!");
            return "error-page"; 
        }

        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        Long currentUserId = (currentUser != null) ? currentUser.getId() : null;

        if ("PRIVATE".equals(collection.getVisibility().toString())) {
            if (currentUserId == null || !collection.getUser().getId().equals(currentUserId)) {
                model.addAttribute("errorMessage", "Access Denied! This collection is private.");
                return "error-page"; 
            }
        }

        if (collection.getItems() != null && !collection.getItems().isEmpty()) {
            Long cheatsheetId = collection.getItems().get(0).getCheatsheetId();
            com.hibernate.entity.CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(cheatsheetId);
            
            model.addAttribute("cheatsheet", cheatsheet);
            model.addAttribute("comments", commentService.selectCommentsByCheatsheetId(cheatsheetId));
            model.addAttribute("isBookmarked", currentUserId != null && bookmarkService.isBookmarked(currentUserId, cheatsheetId));
            model.addAttribute("isLiked", currentUserId != null && likeService.isLiked(currentUserId, cheatsheetId));
            model.addAttribute("likeCount", likeService.countLikes(cheatsheetId));
            
            return "cheatsheet-detail"; 
        } else {
            model.addAttribute("errorMessage", "This collection is empty! Add some cheat sheets first.");
            return "error-page";
        }
    }
}