package com.example.joke;

public class User {
    private String username;
    private String password; // For production, hash passwords!

    public User() {}
    public User(String username, String password) {
        this.username = username;
        this.password = password;
    }
    // Getters & setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
