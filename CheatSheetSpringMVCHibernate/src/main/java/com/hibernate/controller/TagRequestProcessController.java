package com.hibernate.controller;

import com.hibernate.service.TagRequestProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/tag-request-process")
public class TagRequestProcessController {

    @Autowired private TagRequestProcessService service;

    @GetMapping
    public String showPage(Model model) {
        model.addAttribute("pendingList", service.getPendingRequests());
        return "admin_tag_request_process";
    }

    @PostMapping("/action")
    public String handleAction(@RequestParam("id") Long id, @RequestParam("action") String action) {
        if ("ACCEPT".equals(action)) {
            service.approveTagRequest(id);
        } else if ("REJECT".equals(action)) {
            service.rejectTagRequest(id);
        }
        return "redirect:/admin/tag-request-process";
    }
}