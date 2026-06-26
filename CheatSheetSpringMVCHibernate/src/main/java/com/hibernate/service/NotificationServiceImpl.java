package com.hibernate.service;

import java.time.LocalDateTime;

import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.DTO.NotificationDTO;
import com.hibernate.entity.NotificationEntity;
import com.hibernate.entity.UserEntity;
import com.hibernate.entity.enums.ReferenceType;
import com.hibernate.repository.NotificationRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

	private final NotificationRepository notificationRepository;
	private final SimpMessagingTemplate messagingTemplate;

	@Transactional
	@Override
	public void createAndSendNotification(String title, String message, String type, ReferenceType refType, Long refId,
			Long targetUserId, Long actorUserId) {

		// 1. Create and populate the core entity properties
		NotificationEntity notification = new NotificationEntity();
		notification.setTitle(title);
		notification.setMessage(message);
		notification.setType(type);
		notification.setReferenceType(refType);
		notification.setReferenceId(refId);
		notification.setIsRead(false);
		notification.setCreatedAt(LocalDateTime.now());

		// 2. Set up relational mappings (proxies are resolved within the @Transactional
		// session)
		UserEntity targetUser = new UserEntity();
		targetUser.setId(targetUserId);
		notification.setUser(targetUser);

		if (actorUserId != null) {
			UserEntity actorUser = new UserEntity();
			actorUser.setId(actorUserId);
			notification.setActorUser(actorUser);
		}

		// 3. Save to database using the repository layer
		notificationRepository.saveNotification(notification);

		// 4. Map to clean DTO payload and dispatch over WebSockets
		NotificationDTO payload = new NotificationDTO(notification);
		messagingTemplate.convertAndSend("/queue/notifications-" + targetUserId, payload);
	}

}