package com.hibernate.service;

import com.hibernate.entity.enums.ReferenceType;

public interface NotificationService {

	public void createAndSendNotification(String title, String message, String type, ReferenceType refType, Long refId,
			Long targetUserId, Long actorUserId);

}
