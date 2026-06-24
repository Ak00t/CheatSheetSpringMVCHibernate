package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.NotificationEntity;

import lombok.RequiredArgsConstructor;

@Repository
@Transactional
@RequiredArgsConstructor

public class NotificationRepositoryImpl implements NotificationRepository {
	private final SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public NotificationEntity saveNotification(NotificationEntity notification) {
		return (NotificationEntity) getSession().save(notification);

	}

	@Override
	public NotificationEntity findById(Long id) {
		return getSession().get(NotificationEntity.class, id);
	}

}
