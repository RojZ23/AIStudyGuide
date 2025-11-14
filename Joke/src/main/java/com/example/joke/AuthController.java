package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    private final DataStore store;

    public AuthController(DataStore store) {
        this.store = store;
    }

    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password) {
        if(!store.addUser(new User(username, password))) {
            return "register"; // Could add error message support
        }
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        if(store.validateUser(username, password)) {
            session.setAttribute("username", username);
            return "redirect:/dashboard";
        }
        return "login"; // Could add error message support
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
