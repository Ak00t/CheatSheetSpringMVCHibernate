package com.hibernate.controller;

import com.hibernate.service.TagRequestProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/tag-request-process")
public class TagRequestProcessController {

    @Autowired 
    private TagRequestProcessService service;

    @GetMapping
    public String showPage(Model model) {
        // Pending ဖြစ်နေသော request များအားလုံးကို UI သို့ ပို့ပေးခြင်း
        model.addAttribute("pendingList", service.getPendingRequests());
        return "admin_tag_request_process";
    }

    @PostMapping("/action")
    @ResponseBody
    public ResponseEntity<String> handleAction(@RequestParam("id") Long id, @RequestParam("action") String action) {
        try {
            if ("ACCEPT".equals(action)) {
                // Accept လုပ်သောအခါ Duplicate ဖြစ်မဖြစ် Service ထဲတွင် စစ်ဆေးပြီးမှ အလုပ်လုပ်မည်
                service.approveTagRequest(id);
                return ResponseEntity.ok("Accepted");
                
            } else if ("REJECT".equals(action)) {
                // Reject လုပ်သောအခါ status ကို update လုပ်ပြီး စာရင်းထဲမှ ဖယ်ထုတ်ပေးမည်
                service.rejectTagRequest(id);
                return ResponseEntity.ok("Rejected");
                
            } else {
                return ResponseEntity.badRequest().body("Invalid Action");
            }
        } catch (IllegalArgumentException e) {
            // Duplicate ဖြစ်ပါက 409 Conflict ပြန်ပို့ခြင်း (UI မှ Alert ပြရန်)
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Duplicate");
        } catch (Exception e) {
            // အခြားသော Error များအတွက် Internal Server Error ပြန်ပို့ခြင်း
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error");
        }
    }
}