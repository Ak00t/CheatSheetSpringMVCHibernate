package com.hibernate.controller;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CollectionEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor; // 👈 Lombok သေချာ Import လုပ်ပါ
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/collection")
@RequiredArgsConstructor 
public class CollectionController {

   
    private final CollectionService collectionService;
    
    private final CheatsheetService cheatsheetService;

    @GetMapping("/list")
    @ResponseBody
    public List<CollectionEntity> getCollectionList(HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            System.out.println("⚠️ Session user is null inside /collection/list!");
            return new ArrayList<>();
        }
        
      
        return collectionService.getCollectionsByInterface(currentUser.getId(), 1, 50);
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
        if (currentUser == null) {
            return "User not logged in";
        }
        collectionService.createCollection(currentUser.getId(), name, visibility);
        return "Collection Created Successfully";
    }

    @PostMapping("/update-visibility")
    @ResponseBody
    public String updateVisibility(@RequestParam Long collectionId, @RequestParam String visibility) {
        collectionService.updateCollectionVisibility(collectionId, visibility);
        return "Collection Privacy Updated Successfully";
    }

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

        // Privacy စစ်ဆေးခြင်း
        if ("PRIVATE".equals(collection.getVisibility().toString())) {
            if (currentUserId == null || !collection.getUser().getId().equals(currentUserId)) {
                model.addAttribute("errorMessage", "Access Denied! This collection is private.");
                return "error-page"; 
            }
        }
List<CheatsheetEntity> sheetsInCollection = new ArrayList<>();
        
        if (collection.getItems() != null && !collection.getItems().isEmpty()) {
            for (com.hibernate.entity.CollectionItemEntity item : collection.getItems()) {
                com.hibernate.entity.CheatsheetEntity sheet = cheatsheetService.findDetailsById(item.getCheatsheetId());
                if (sheet != null) {
                    sheetsInCollection.add(sheet);
                }
            }
        }

       
        model.addAttribute("collection", collection);
        model.addAttribute("sheetsInCollection", sheetsInCollection);
        
     
        return "collection-sheets-list"; 
    }
 
    @PostMapping("/delete")
    @ResponseBody
    public String deleteCollection(@RequestParam Long collectionId, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "Unauthorized";
        }

        CollectionEntity collection = collectionService.findById(collectionId);
        if (collection == null) {
            return "NotFound";
        }

       
        if (!collection.getUser().getId().equals(currentUser.getId())) {
            return "Forbidden";
        }

        
        collectionService.deleteCollection(collectionId); 
        
        return "Success";
    }
    @PostMapping("/update-name")
    @ResponseBody
    public String updateCollectionName(@RequestParam Long collectionId, @RequestParam String name, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "Unauthorized";
        }

        CollectionEntity collection = collectionService.findById(collectionId);
        if (collection == null) {
            return "NotFound";
        }

        if (!collection.getUser().getId().equals(currentUser.getId())) {
            return "Forbidden";
        }

        // 💡 အသစ်ပြင်ဆင်ထားသော Service ကို လှမ်းခေါ်လိုက်ပါပြီ
        collectionService.updateCollectionName(collectionId, name);
        
        return "Success";
    }
}