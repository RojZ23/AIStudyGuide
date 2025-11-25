// DashboardController.java
package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    @GetMapping("/dashboard/progress")
    public String progressAnalytics(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }

        List<StudyGuide> guides = studyGuideService.getUserStudyGuides(username);
        List<Quiz> quizzes = quizService.getUserQuizzes(username);

        long totalGuides = guides.size();
        long totalQuizzes = quizzes.size();
        long quizzesCompleted = quizzes.stream().filter(q -> "COMPLETED".equals(q.getStatus())).count();
        long quizzesInProgress = quizzes.stream().filter(q -> "IN_PROGRESS".equals(q.getStatus())).count();

        // Calculate average quiz score (assuming Quiz has getScore returning Integer or Double)
        double averageScore = quizzes.stream()
                .filter(q -> q.getScore() != null)
                .mapToInt(Quiz::getScore)
                .average()
                .orElse(0.0);

        model.addAttribute("username", username);
        model.addAttribute("totalGuides", totalGuides);
        model.addAttribute("totalQuizzes", totalQuizzes);
        model.addAttribute("quizzesCompleted", quizzesCompleted);
        model.addAttribute("quizzesInProgress", quizzesInProgress);
        model.addAttribute("averageScore", averageScore);

        return "progress-analytics";
    }
}