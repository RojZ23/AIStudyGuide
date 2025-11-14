package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class DashboardController {

    private final DataStore store;
    private final AIService aiService;

    public DashboardController(DataStore store, AIService aiService) {
        this.store = store;
        this.aiService = aiService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        model.addAttribute("username", username);
        model.addAttribute("assets", store.getAssets(username));
        return "dashboard";
    }

    @PostMapping("/generate")
    public String generateAsset(@RequestParam String prompt, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        // Use AI service to create an asset
        String generatedAsset = aiService.generateAsset(prompt);
        store.addAsset(username, generatedAsset);

        return "redirect:/dashboard";
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }


}
