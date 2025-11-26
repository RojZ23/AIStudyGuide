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

            String summary = aiService.generateAsset(detailLevelPrompt + " Create a summary of these notes: " + notes);
            String keyTerms = aiService.generateAsset("Extract key terms and definitions from these notes: " + notes);
            String questions = aiService.generateAsset("Generate 5 practice questions with answers based on these notes: " + notes);

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
    public List<Flashcard> generateFlashcardsFromNotes(StudyGuide guide) {
        // Regenerate key terms from notes
        String notes = guide.getOriginalNotes();
        if (notes != null && !notes.isBlank()) {
            String regeneratedKeyTerms = aiService.generateAsset("Extract key terms and definitions from these notes: " + notes);
            guide.setKeyTerms(regeneratedKeyTerms);
            studyGuideRepository.save(guide);  // Persist updated key terms

            // Delete existing flashcards
            List<Flashcard> existing = flashcardRepository.findByStudyGuideId(guide.getId());
            if (!existing.isEmpty()) {
                flashcardRepository.deleteAll(existing);
            }

            // Parse regenerated key terms into flashcards
            List<Flashcard> newFlashcards = new ArrayList<>();
            String[] lines = regeneratedKeyTerms.split("\\r?\\n");
            for (String line : lines) {
                if (line.contains("-")) {
                    String[] parts = line.split("-", 2);
                    String term = parts[0].trim();
                    String def = parts[1].trim();
                    Flashcard flashcard = new Flashcard();
                    flashcard.setTerm(term);
                    flashcard.setDefinition(def);
                    flashcard.setStudyGuide(guide);
                    newFlashcards.add(flashcard);
                }
            }
            flashcardRepository.saveAll(newFlashcards);
            return newFlashcards;
        }
        return List.of();
    }

    // Existing helper methods...

    public List<Flashcard> generateFlashcardsFromKeyTerms(Long studyGuideId) {
        StudyGuide guide = studyGuideRepository.findById(studyGuideId)
                .orElseThrow(() -> new RuntimeException("Study guide not found"));

        List<Flashcard> existing = flashcardRepository.findByStudyGuideId(studyGuideId);
        if (!existing.isEmpty()) {
            flashcardRepository.deleteAll(existing);
        }

        String keyTerms = guide.getKeyTerms();
        List<Flashcard> flashcards = new ArrayList<>();
        if (keyTerms != null && !keyTerms.isBlank()) {
            String[] lines = keyTerms.split("\\r?\\n");
            for (String line : lines) {
                if (line.contains("-")) {
                    String[] parts = line.split("-", 2);
                    String term = parts[0].trim();
                    String def = parts[1].trim();
                    Flashcard flashcard = new Flashcard();
                    flashcard.setTerm(term);
                    flashcard.setDefinition(def);
                    flashcard.setStudyGuide(guide);
                    flashcards.add(flashcard);
                }
            }
            flashcardRepository.saveAll(flashcards);
        }
        return flashcards;
    }

    public List<Flashcard> getFlashcardsForStudyGuide(Long studyGuideId) {
        return flashcardRepository.findByStudyGuideId(studyGuideId);
    }
}