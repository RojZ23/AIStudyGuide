package com.example.joke;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface QuizRepository extends JpaRepository<Quiz, Long> {
    List<Quiz> findByUserUsernameOrderByCreatedAtDesc(String username);
    List<Quiz> findByStudyGuideId(Long studyGuideId);

    @Modifying
    @Query("DELETE FROM Quiz q WHERE q.studyGuide.id = :studyGuideId")
    void deleteByStudyGuideId(@Param("studyGuideId") Long studyGuideId);
}