package com.example.joke;

import org.springframework.stereotype.Component;
import java.util.*;

@Component
public class DataStore {

    private final Map<String, User> users = new HashMap<>();
    private final Map<String, List<String>> assets = new HashMap<>();

    public boolean addUser(User user) {
        if (users.containsKey(user.getUsername())) {
            return false;
        }
        users.put(user.getUsername(), user);
        assets.put(user.getUsername(), new ArrayList<>());
        return true;
    }

    public boolean validateUser(String username, String password) {
        User existing = users.get(username);
        return existing != null && existing.getPassword().equals(password);
    }

    public void addAsset(String username, String asset) {
        assets.computeIfAbsent(username, k -> new ArrayList<>()).add(asset);
    }

    public List<String> getAssets(String username) {
        return assets.getOrDefault(username, Collections.emptyList());
    }
}
