// AuthController.java
package com.example.joke;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password) {
        if(!userService.registerUser(username, password)) {
            return "register";
        }
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        if(userService.validateUser(username, password)) {
            session.setAttribute("username", username);
            return "redirect:/dashboard";
        }
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    @GetMapping("/forgot-password")
    public String showForgotPassword(Model model,
                                     @RequestParam(required = false) String username) {
        // Keep username in the form if it was previously entered
        if (username != null) {
            model.addAttribute("username", username);
        }
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String username,
                                        @RequestParam String newPassword,
                                        @RequestParam String confirmPassword,
                                        Model model) {

        model.addAttribute("username", username); // keep filled in

        // Check if user exists
        var userOpt = userService.findByUsername(username);
        if (userOpt.isEmpty()) {
            model.addAttribute("error", "No account found with that username.");
            return "forgot-password";
        }

        // Check password confirmation
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "New password and confirmation do not match.");
            return "forgot-password";
        }

        // Basic length check (you can add more validation if you want)
        if (newPassword.length() < 8) {
            model.addAttribute("error", "Password must be at least 8 characters long.");
            return "forgot-password";
        }

        // Update and save the new password
        userService.updatePassword(username, newPassword);

        model.addAttribute("message", "Your password has been updated. You can now log in with the new password.");
        return "forgot-password";
    }
}