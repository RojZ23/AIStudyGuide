// StudyGuideRepository.java
package com.example.joke;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudyGuideRepository extends JpaRepository<StudyGuide, Long> {
    List<StudyGuide> findByUserUsernameOrderByCreatedAtDesc(String username);
    List<StudyGuide> findByUserId(Long userId);
}