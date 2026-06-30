package com.hibernate.repository;

import java.util.List;

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
	public Long saveNotification(NotificationEntity notification) {
		return (Long) getSession().save(notification);

	}

	@Override
	public NotificationEntity findById(Long id) {
		return getSession().get(NotificationEntity.class, id);
	}

	@Override
	public List<NotificationEntity> findUnreadByUserId(Long userId) {

		return getSession()
				.createQuery("FROM NotificationEntity n WHERE n.user.id = :userId AND n.isRead = false",
						NotificationEntity.class)
					.setParameter("userId", userId)
					.getResultList();
	}

	@Override
	public void markAsRead(Long notificationId) {
		getSession()
				.createQuery("UPDATE NotificationEntity n SET n.isRead = true WHERE n.id = :id")
					.setParameter("id", notificationId)
					.executeUpdate();

	}

	@Override
	public void markAllAsReadByUserId(Long userId) {
		getSession()
				.createQuery("UPDATE NotificationEntity n SET n.isRead = true WHERE n.user.id = :userId")
					.setParameter("userId", userId)
					.executeUpdate();
	}

}
