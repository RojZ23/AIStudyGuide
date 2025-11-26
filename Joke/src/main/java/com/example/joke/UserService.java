// UserService.java
package com.example.joke;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;

@Service
@Transactional
public class UserService {

    private final UserRepository userRepository;


    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean registerUser(String username, String password) {
        if (userRepository.existsByUsername(username)) {
            return false;
        }
        User user = new User(username, password);
        userRepository.save(user);
        return true;
    }

    public boolean validateUser(String username, String password) {
        Optional<User> user = userRepository.findByUsername(username);
        return user.isPresent() && user.get().getPassword().equals(password);
    }

    public void updatePassword(String username, String newPassword) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            // In a real app you should encode/hash the password here
            user.setPassword(newPassword);
            userRepository.save(user);
        }
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

}