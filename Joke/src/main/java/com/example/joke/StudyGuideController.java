package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/guides")
public class StudyGuideController {
    private final StudyGuideService studyGuideService;
    private final QuizService quizService;

    public StudyGuideController(StudyGuideService studyGuideService, QuizService quizService) {
        this.studyGuideService = studyGuideService;
        this.quizService = quizService;
    }

    @GetMapping("/create")
    public String showCreateGuide(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";
        model.addAttribute("username", username);
        return "create-guide";
    }

    @PostMapping("/create")
    public String createGuide(@RequestParam String title,
                              @RequestParam(required = false) String notes,
                              @RequestParam(required = false) MultipartFile notesFile,
                              @RequestParam(defaultValue = "basic") String difficulty,
                              HttpSession session) throws IOException {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        String notesContent = notes;
        if (notesFile != null && !notesFile.isEmpty()) {
            notesContent = new String(notesFile.getBytes(), StandardCharsets.UTF_8);
        }
        if (notesContent == null) notesContent = "";

        studyGuideService.createStudyGuide(title, notesContent, username, difficulty);
        return "redirect:/dashboard";
    }

    @PostMapping("/{id}/flashcards")
    public String generateFlashcards(@PathVariable Long id, HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        studyGuideService.generateFlashcardsFromKeyTerms(id);
        return "redirect:/guides/" + id + "/flashcards";
    }

    @GetMapping("/{id}/flashcards")
    public String viewFlashcards(@PathVariable Long id, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        List<Flashcard> flashcards = studyGuideService.getFlashcardsForStudyGuide(id);
        model.addAttribute("flashcards", flashcards);
        model.addAttribute("studyGuideId", id);
        return "view-flashcards";
    }

    @GetMapping("/{id:\\d+}")
    public String viewGuide(@PathVariable Long id, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        Optional<StudyGuide> guide = studyGuideService.getStudyGuideById(id);
        if (guide.isPresent()) {
            model.addAttribute("guide", guide.get());
            return "view-guide";
        }
        return "redirect:/dashboard";
    }

    @GetMapping("/{id}/edit")
    public String editGuide(@PathVariable Long id, HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        Optional<StudyGuide> guide = studyGuideService.getStudyGuideById(id);
        if (guide.isPresent()) {
            model.addAttribute("guide", guide.get());
            return "edit-guide";
        }
        return "redirect:/dashboard";
    }

    @PostMapping("/{id}/edit")
    public String updateGuide(@PathVariable Long id,
                              @RequestParam String title,
                              @RequestParam String notes,
                              @RequestParam(defaultValue = "basic") String difficulty,
                              HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        studyGuideService.updateStudyGuide(id, title, notes, difficulty);
        return "redirect:/guides/" + id;
    }

    @PostMapping("/{id}/regenerate")
    public String regenerateAIContent(@PathVariable Long id,
                                      @RequestParam(defaultValue = "basic") String difficulty,
                                      HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        studyGuideService.regenerateAIContent(id, difficulty);
        return "redirect:/guides/" + id;
    }

    @PostMapping("/{id}/update-ai")
    public String updateAIContent(@PathVariable Long id,
                                  @RequestParam(required = false) String aiSummary,
                                  @RequestParam(required = false) String keyTerms,
                                  @RequestParam(required = false) String practiceQuestions,
                                  HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        studyGuideService.updateAIContent(id, aiSummary, keyTerms, practiceQuestions);
        return "redirect:/guides/" + id;
    }

    @PostMapping("/{id}/delete")
    public String deleteGuide(@PathVariable Long id, HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        studyGuideService.deleteStudyGuide(id);
        return "redirect:/dashboard";
    }

    @PostMapping("/{id}/quiz")
    public String createQuiz(@PathVariable Long id, HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        quizService.createQuizFromStudyGuide(id, username);
        return "redirect:/dashboard";
    }
    // Inside StudyGuideController.java

    @GetMapping("/list")
    public String listGuides(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        List<StudyGuide> guides = studyGuideService.getUserStudyGuides(username);
        model.addAttribute("username", username);
        model.addAttribute("studyGuides", guides);
        return "guides-list";
    }

    @GetMapping("/quizzes-list")
    public String listQuizzes(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) return "redirect:/login";

        List<Quiz> quizzes = quizService.getUserQuizzes(username);
        model.addAttribute("username", username);
        model.addAttribute("quizzes", quizzes);
        return "quizzes-list";
    }

}
