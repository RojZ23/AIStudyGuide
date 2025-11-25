package com.example.joke;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class QuizService {

    private final QuizRepository quizRepository;
    private final StudyGuideRepository studyGuideRepository;
    private final UserRepository userRepository;
    private final AIService aiService;

    public QuizService(QuizRepository quizRepository,
                       StudyGuideRepository studyGuideRepository,
                       UserRepository userRepository,
                       AIService aiService) {
        this.quizRepository = quizRepository;
        this.studyGuideRepository = studyGuideRepository;
        this.userRepository = userRepository;
        this.aiService = aiService;
    }

    public Quiz createQuizFromStudyGuide(Long studyGuideId, String username) {
        Optional<User> user = userRepository.findByUsername(username);
        Optional<StudyGuide> studyGuide = studyGuideRepository.findById(studyGuideId);
        if (user.isEmpty() || studyGuide.isEmpty()) {
            throw new RuntimeException("User or study guide not found");
        }
        StudyGuide guide = studyGuide.get();
        String quizContent = generateQuizContent(guide);
        Quiz quiz = new Quiz("Quiz: " + guide.getTitle(), user.get(), guide);
        quiz.setQuestions(quizContent);
        quiz.setStatus("NOT_STARTED");
        return quizRepository.save(quiz);
    }

    public Quiz saveQuizProgress(Long quizId, String answers, Integer score, String status) {
        Optional<Quiz> quizOpt = quizRepository.findById(quizId);
        if (quizOpt.isPresent()) {
            Quiz quiz = quizOpt.get();
            quiz.setQuestions(answers);
            quiz.setScore(score);
            quiz.setStatus(status);
            return quizRepository.save(quiz);
        }
        throw new RuntimeException("Quiz not found");
    }

    public Quiz completeQuiz(Long quizId, Integer score) {
        Optional<Quiz> quizOpt = quizRepository.findById(quizId);
        if (quizOpt.isPresent()) {
            Quiz quiz = quizOpt.get();
            quiz.setScore(score);
            quiz.setStatus("COMPLETED");
            return quizRepository.save(quiz);
        }
        throw new RuntimeException("Quiz not found");
    }

    public List<Quiz> getUserQuizzes(String username) {
        return quizRepository.findByUserUsernameOrderByCreatedAtDesc(username);
    }

    public Optional<Quiz> getQuizById(Long id) {
        return quizRepository.findById(id);
    }


    public void deleteQuiz(Long id) {
        quizRepository.deleteById(id);
    }

    private String generateQuizContent(StudyGuide guide) {
        try {
            String prompt = String.format(
                    "Create a quiz based on this study guide content:\n\n" +
                            "Title: %s\n" +
                            "Summary: %s\n" +
                            "Key Terms: %s\n" +
                            "Original Notes: %s\n\n" +
                            "Generate 5 multiple choice questions with 4 options each. Format each question as:\n" +
                            "Q1: [Question text]\n" +
                            "A) [Option A]\n" +
                            "B) [Option B]\n" +
                            "C) [Option C]\n" +
                            "D) [Option D]\n" +
                            "Correct: [Correct letter]\n\n" +
                            "Then provide the answer key at the end.",
                    guide.getTitle(),
                    guide.getAiSummary(),
                    guide.getKeyTerms(),
                    guide.getOriginalNotes()
            );
            return aiService.generateAsset(prompt);
        } catch (Exception e) {
            return "Quiz generation failed. Please try again.\n\nSample Question:\nQ1: What is the main topic of this study guide?\nA) Option A\nB) Option B\nC) Option C\nD) Option D\nCorrect: A";
        }
    }
}
