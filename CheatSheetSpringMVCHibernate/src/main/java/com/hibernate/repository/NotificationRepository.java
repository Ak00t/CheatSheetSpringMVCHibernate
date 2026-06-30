package com.hibernate.repository;

import java.util.List;

import com.hibernate.entity.NotificationEntity;

public interface NotificationRepository {

	public Long saveNotification(NotificationEntity notification);

	public NotificationEntity findById(Long id);

	public List<NotificationEntity> findUnreadByUserId(Long userId);

	public void markAsRead(Long notificationId);

	public void markAllAsReadByUserId(Long userId);

}
