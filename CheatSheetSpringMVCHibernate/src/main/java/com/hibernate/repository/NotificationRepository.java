package com.hibernate.repository;

import com.hibernate.entity.NotificationEntity;

public interface NotificationRepository {

	public NotificationEntity saveNotification(NotificationEntity notification);

	public NotificationEntity findById(Long id);

}
