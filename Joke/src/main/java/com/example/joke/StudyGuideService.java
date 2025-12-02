package com.example.joke;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class StudyGuideService {

    private final StudyGuideRepository studyGuideRepository;
    private final UserRepository userRepository;
    private final AIService aiService;
    private final QuizRepository quizRepository;
    private final FlashcardRepository flashcardRepository;

    public StudyGuideService(StudyGuideRepository studyGuideRepository,
                             UserRepository userRepository,
                             AIService aiService,
                             QuizRepository quizRepository,
                             FlashcardRepository flashcardRepository) {
        this.studyGuideRepository = studyGuideRepository;
        this.userRepository = userRepository;
        this.aiService = aiService;
        this.quizRepository = quizRepository;
        this.flashcardRepository = flashcardRepository;
    }

    public StudyGuide createStudyGuide(String title, String notes, String username, String difficulty) {
        Optional<User> user = userRepository.findByUsername(username);
        if (user.isEmpty()) {
            throw new RuntimeException("User not found");
        }

        StudyGuide guide = new StudyGuide(title, notes, user.get());
        generateAIContent(guide, notes, difficulty);

        return studyGuideRepository.save(guide);
    }

    public List<StudyGuide> getUserStudyGuides(String username) {
        return studyGuideRepository.findByUserUsernameOrderByCreatedAtDesc(username);
    }

    public Optional<StudyGuide> getStudyGuideById(Long id) {
        return studyGuideRepository.findById(id);
    }

    public StudyGuide updateStudyGuide(Long id, String title, String notes, String difficulty) {
        Optional<StudyGuide> guideOpt = studyGuideRepository.findById(id);
        if (guideOpt.isPresent()) {
            StudyGuide guide = guideOpt.get();
            guide.setTitle(title);
            guide.setOriginalNotes(notes);
            generateAIContent(guide, notes, difficulty);
            return studyGuideRepository.save(guide);
        }
        throw new RuntimeException("Study guide not found");
    }

    public StudyGuide regenerateAIContent(Long id, String difficulty) {
        Optional<StudyGuide> guideOpt = studyGuideRepository.findById(id);
        if (guideOpt.isPresent()) {
            StudyGuide guide = guideOpt.get();
            generateAIContent(guide, guide.getOriginalNotes(), difficulty);
            return studyGuideRepository.save(guide);
        }
        throw new RuntimeException("Study guide not found");
    }

    public StudyGuide updateAIContent(Long id, String aiSummary, String keyTerms, String practiceQuestions) {
        Optional<StudyGuide> guideOpt = studyGuideRepository.findById(id);
        if (guideOpt.isPresent()) {
            StudyGuide guide = guideOpt.get();
            if (aiSummary != null && !aiSummary.trim().isEmpty()) guide.setAiSummary(aiSummary);
            if (keyTerms != null && !keyTerms.trim().isEmpty()) guide.setKeyTerms(keyTerms);
            if (practiceQuestions != null && !practiceQuestions.trim().isEmpty()) guide.setPracticeQuestions(practiceQuestions);
            return studyGuideRepository.save(guide);
        }
        throw new RuntimeException("Study guide not found");
    }

    /**
     * Strongly specify the key‑term format so parsing is reliable:
     * one per line, "Term - short definition".
     */
    private void generateAIContent(StudyGuide guide, String notes, String difficulty) {
        try {
            String detailLevelPrompt;
            switch (difficulty.toLowerCase()) {
                case "basic":
                    detailLevelPrompt = "Provide a simple and brief summary.";
                    break;
                case "detailed":
                    detailLevelPrompt = "Provide a detailed and comprehensive summary.";
                    break;
                case "very detailed":
                    detailLevelPrompt = "Provide an in-depth, very detailed summary with examples.";
                    break;
                default:
                    detailLevelPrompt = "Provide a concise summary.";
            }

            String summaryPrompt = detailLevelPrompt +
                    " Create a summary of these notes. Use short paragraphs.";
            String keyTermsPrompt =
                    "Extract the most important key terms and definitions from these notes. " +
                            "Respond ONLY as plain text, one term per line, in this exact format:\n" +
                            "Term - short definition\n" +
                            "Do not number the items, do not use bullets, and do not add any extra text before or after the list.";
            String questionsPrompt =
                    "Generate 5 practice questions with answers based on these notes. " +
                            "Keep questions and answers short and clear.";

            String summary = aiService.generateAsset(summaryPrompt + " Notes: " + notes);
            String keyTerms = aiService.generateAsset(keyTermsPrompt + " Notes: " + notes);
            String questions = aiService.generateAsset(questionsPrompt + " Notes: " + notes);

            guide.setAiSummary(summary);
            guide.setKeyTerms(keyTerms);
            guide.setPracticeQuestions(questions);
        } catch (Exception e) {
            guide.setAiSummary("AI summary generation failed. Please try regenerating.");
            guide.setKeyTerms("Key terms generation failed. Please try regenerating.");
            guide.setPracticeQuestions("Practice questions generation failed. Please try regenerating.");
        }
    }

    public void deleteStudyGuide(Long id) {
        List<Quiz> quizzes = quizRepository.findByStudyGuideId(id);
        if (!quizzes.isEmpty()) {
            quizRepository.deleteAll(quizzes);
        }
        studyGuideRepository.deleteById(id);
    }

    /**
     * Regenerate key terms from the raw notes and then parse into flashcards.
     * This is useful if the user wants to refresh based on updated notes.
     */
    public List<Flashcard> generateFlashcardsFromNotes(StudyGuide guide) {
        String notes = guide.getOriginalNotes();
        if (notes != null && !notes.isBlank()) {
            String regeneratedKeyTerms = aiService.generateAsset(
                    "Extract key terms and definitions from these notes. " +
                            "Respond ONLY as plain text, one per line, format: Term - short definition. " +
                            "No numbering, no bullets, no extra commentary. Notes: " + notes
            );
            guide.setKeyTerms(regeneratedKeyTerms);
            studyGuideRepository.save(guide);

            // Delete existing flashcards
            List<Flashcard> existing = flashcardRepository.findByStudyGuideId(guide.getId());
            if (!existing.isEmpty()) {
                flashcardRepository.deleteAll(existing);
            }

            List<Flashcard> newFlashcards = buildFlashcardsFromKeyTermsString(guide, regeneratedKeyTerms);
            flashcardRepository.saveAll(newFlashcards);
            return newFlashcards;
        }
        return List.of();
    }

    public List<Flashcard> generateFlashcardsFromKeyTerms(Long studyGuideId) {
        StudyGuide guide = studyGuideRepository.findById(studyGuideId)
                .orElseThrow(() -> new RuntimeException("Study guide not found"));

        List<Flashcard> existing = flashcardRepository.findByStudyGuideId(studyGuideId);
        if (!existing.isEmpty()) {
            flashcardRepository.deleteAll(existing);
        }

        String keyTerms = guide.getKeyTerms();
        if (keyTerms == null || keyTerms.isBlank()) {
            return List.of();
        }

        List<Flashcard> flashcards = buildFlashcardsFromKeyTermsString(guide, keyTerms);
        flashcardRepository.saveAll(flashcards);
        return flashcards;
    }

    public List<Flashcard> getFlashcardsForStudyGuide(Long studyGuideId) {
        return flashcardRepository.findByStudyGuideId(studyGuideId);
    }

    /**
     * Robust parser that handles:
     * - pure "Term - definition"
     * - numbered lines like "8. Carbon Dioxide (CO2)**: A colorless..."
     * - markdown bold around terms "**Carbon Dioxide (CO2)**: A colorless..."
     */
    private List<Flashcard> buildFlashcardsFromKeyTermsString(StudyGuide guide, String keyTermsRaw) {
        List<Flashcard> flashcards = new ArrayList<>();
        String[] lines = keyTermsRaw.split("\\r?\\n");

        for (String rawLine : lines) {
            String line = rawLine.trim();
            if (line.isEmpty()) continue;

            // Strip leading numbering/bullets: "1. ", "8) ", "- ", "* ", etc.
            line = line.replaceFirst("^[0-9]+[.)]\\s*", "");
            line = line.replaceFirst("^[\\-*•]\\s*", "");

            // Sometimes the model may output "**Term**: definition"
            // Normalize first ":" to "-" so the existing split logic still works.
            if (!line.contains("-") && line.contains(":")) {
                line = line.replaceFirst(":", " -");
            }

            if (!line.contains("-")) {
                continue; // still not in expected format, skip
            }

            String[] parts = line.split("-", 2);
            String term = parts[0].trim();
            String def = parts[1].trim();

            // Remove markdown bold markers from term if present
            term = term.replaceAll("^\\*\\*|\\*\\*$", "").trim();

            if (term.isEmpty() || def.isEmpty()) {
                continue;
            }

            Flashcard flashcard = new Flashcard();
            flashcard.setTerm(term);
            flashcard.setDefinition(def);
            flashcard.setStudyGuide(guide);
            flashcards.add(flashcard);
        }

        return flashcards;
    }
}
