package com.hibernate.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.hibernate.entity.CollectionEntity;
import com.hibernate.service.CollectionService;

@Controller
@RequestMapping("/collection")
public class CollectionController {

    @Autowired
    private CollectionService collectionService;

    // ၁။ Playlist List များယူရန် (AJAX အတွက်)
    @GetMapping(value = "/list", produces = "application/json")
    @ResponseBody
    public List<CollectionEntity> getCollections(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return collectionService.getCollections(userId);
    }

    @PostMapping("/create")
    @ResponseBody
    public String createPlaylist(@RequestParam String name, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        
        // Console မှာ ဒါလေးပေါ်လားကြည့်ပါ
        System.out.println("DEBUG: Creating playlist '" + name + "' for User: " + userId);
        
        if (userId == null) {
            return "Error: Session expired or User not logged in";
        }
        
        collectionService.createNewPlaylist(userId, name);
        return "Success";
    }

    // ၃။ Cheatsheet ကို Playlist ထဲ သိမ်းရန်
    @PostMapping("/add-to-playlist")
    @ResponseBody
    public String addToPlaylist(@RequestParam Long collectionId, 
                                @RequestParam Long cheatsheetId) {
        try {
            collectionService.addToPlaylist(collectionId, cheatsheetId);
            return "Added Successfully";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}