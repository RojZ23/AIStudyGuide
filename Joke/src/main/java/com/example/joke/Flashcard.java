package com.example.joke;

import jakarta.persistence.*;

@Entity
public class Flashcard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String term;
    private String definition;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "study_guide_id")
    private StudyGuide studyGuide;

    public Flashcard() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTerm() { return term; }
    public void setTerm(String term) { this.term = term; }

    public String getDefinition() { return definition; }
    public void setDefinition(String definition) { this.definition = definition; }

    public StudyGuide getStudyGuide() { return studyGuide; }
    public void setStudyGuide(StudyGuide studyGuide) { this.studyGuide = studyGuide; }
}
