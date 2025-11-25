// DashboardController.java
package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class DashboardController {

    private final UserService userService;
    private final StudyGuideService studyGuideService;
    private final QuizService quizService;

    public DashboardController(UserService userService,
                               StudyGuideService studyGuideService,
                               QuizService quizService) {
        this.userService = userService;
        this.studyGuideService = studyGuideService;
        this.quizService = quizService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        model.addAttribute("username", username);
        model.addAttribute("studyGuides", studyGuideService.getUserStudyGuides(username));
        model.addAttribute("quizzes", quizService.getUserQuizzes(username));
        return "dashboard";
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }
}