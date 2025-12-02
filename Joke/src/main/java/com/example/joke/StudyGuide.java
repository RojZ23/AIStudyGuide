package com.example.joke;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "study_guides2")
public class StudyGuide {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column(nullable = false)
    public String title;

    @Column(columnDefinition = "TEXT")
    public String originalNotes;

    @Column(columnDefinition = "TEXT")
    public String aiSummary;

    @Column(columnDefinition = "TEXT")
    public String keyTerms;

    @Column(columnDefinition = "TEXT")
    public String practiceQuestions;

    public String subject;

    public LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "studyGuide", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Quiz> quizzes = new ArrayList<>();

    public StudyGuide() {
        this.createdAt = LocalDateTime.now();
    }

    public StudyGuide(String title, String originalNotes, User user) {
        this();
        this.title = title;
        this.originalNotes = originalNotes;
        this.user = user;
    }


    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getOriginalNotes() { return originalNotes; }
    public void setOriginalNotes(String originalNotes) { this.originalNotes = originalNotes; }
    public String getAiSummary() { return aiSummary; }
    public void setAiSummary(String aiSummary) { this.aiSummary = aiSummary; }
    public String getKeyTerms() { return keyTerms; }
    public void setKeyTerms(String keyTerms) { this.keyTerms = keyTerms; }
    public String getPracticeQuestions() { return practiceQuestions; }
    public void setPracticeQuestions(String practiceQuestions) { this.practiceQuestions = practiceQuestions; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public List<Quiz> getQuizzes() { return quizzes; }
    public void setQuizzes(List<Quiz> quizzes) { this.quizzes = quizzes; }
}