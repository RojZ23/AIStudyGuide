package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Optional;

@Controller
@RequestMapping("/quizzes")
public class QuizController {

    private final QuizService quizService;

    public QuizController(QuizService quizService) {
        this.quizService = quizService;
    }

    @GetMapping("/{id}")
    public String takeQuiz(@PathVariable Long id, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        Optional<Quiz> quiz = quizService.getQuizById(id);
        if (quiz.isPresent()) {
            model.addAttribute("quiz", quiz.get());
            return "take-quiz";
        }
        return "redirect:/dashboard";
    }

    @PostMapping("/{id}/save")
    public String saveQuizProgress(@PathVariable Long id,
                                   @RequestParam String answers,
                                   @RequestParam Integer score,
                                   @RequestParam String status,
                                   HttpSession session) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        quizService.saveQuizProgress(id, answers, score, status);
        return "redirect:/quizzes/" + id;
    }

    @PostMapping("/{id}/submit")
    public String submitQuiz(@PathVariable Long id,
                             @RequestParam Integer score,
                             HttpSession session) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        quizService.completeQuiz(id, score);
        return "redirect:/dashboard";
    }

    @PostMapping("/{id}/delete")
    public String deleteQuiz(@PathVariable Long id, HttpSession session) {
        String username = (String) session.getAttribute("username");
        if(username == null) return "redirect:/login";

        quizService.deleteQuiz(id);
        return "redirect:/dashboard";
    }

}