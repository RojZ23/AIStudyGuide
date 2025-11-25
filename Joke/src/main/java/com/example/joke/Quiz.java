package com.example.joke;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "quizzes2")
public class Quiz {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    @Column(nullable = false)
    public String title;

    @Column(columnDefinition = "TEXT")
    public String questions;

    public String status; // NOT_STARTED, IN_PROGRESS, COMPLETED

    public Integer score;

    public LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "study_guide_id")
    public StudyGuide studyGuide;

    public Quiz() {
        this.createdAt = LocalDateTime.now();
        this.status = "NOT_STARTED";
    }

    public Quiz(String title, User user, StudyGuide studyGuide) {
        this();
        this.title = title;
        this.user = user;
        this.studyGuide = studyGuide;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getQuestions() { return questions; }
    public void setQuestions(String questions) { this.questions = questions; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public StudyGuide getStudyGuide() { return studyGuide; }
    public void setStudyGuide(StudyGuide studyGuide) { this.studyGuide = studyGuide; }
}