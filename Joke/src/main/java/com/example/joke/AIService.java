package com.example.joke;

import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.stereotype.Service;

@Service
public class AIService {

    private final OpenAiChatModel openAiChatModel;

    public AIService(OpenAiChatModel openAiChatModel) {
        this.openAiChatModel = openAiChatModel;
    }

    public String generateAsset(String prompt) {
        try {
            // Build Prompt (wrap user input if needed)
            UserMessage userMessage = new UserMessage(prompt);
            Prompt chatPrompt = new Prompt(userMessage);

            // Call the model
            ChatResponse response = openAiChatModel.call(chatPrompt);

            // Get generated content
            if (response != null && response.getResults() != null && !response.getResults().isEmpty()) {
                return response.getResults().get(0).getOutput().getText();
            } else {
                return "AI did not return a response. Try again.";
            }
        } catch (Exception e) {
            return "Error while generating study guide: " + e.getMessage();
        }

    }
}
