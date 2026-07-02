package com.hibernate.service;

import java.util.List;

import com.hibernate.entity.NotificationEntity;
import com.hibernate.entity.enums.ReferenceType;

public interface NotificationService {

	public void createAndSendNotification(String title, String message, String type, ReferenceType refType, Long refId,
			Long targetUserId, Long actorUserId);

	public List<NotificationEntity> findUnreadByUserId(Long userId);

	public List<NotificationEntity> findReadByUserId(Long userId);

	public void markAsRead(Long notificationId);

	public void markAllAsReadByUserId(Long userId);
}
