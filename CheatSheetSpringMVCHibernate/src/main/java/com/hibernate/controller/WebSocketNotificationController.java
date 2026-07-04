package com.hibernate.controller;

import java.util.Map;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketNotificationController {

	/**
	 * When a client sends a message to: /app/send-live-notification This method
	 * will capture it, and broadcast it out to everyone subscribed to
	 * /topic/notifications
	 */
	@MessageMapping("/send-live-notification")
	@SendTo("/topic/notifications")
	public Map<String, String> broadcastNotification(Map<String, String> payload) {
		// Example: Payload contains {"title": "New Comment!", "message": "Someone liked
		// your cheatsheet"}
		// This payload gets returned and instantly pushed down the WebSocket pipe to
		// all listening browser clients
		return payload;
	}
}