package com.hibernate.DTO;

import java.time.format.DateTimeFormatter;

import com.hibernate.entity.NotificationEntity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class NotificationDTO {

	public NotificationDTO(NotificationEntity entity) {
		this.id = entity.getId();
		this.title = entity.getTitle();
		this.message = entity.getMessage();
		this.type = entity.getType();
		this.referenceType = entity.getReferenceType() != null ? entity.getReferenceType().name() : null;
		this.referenceId = entity.getReferenceId();
		this.actorName = entity.getActorUser() != null ? entity.getActorUser().getName() : "System";
		this.createdAt = entity.getCreatedAt() != null
				? entity.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"))
				: "";
	}

	private Long id;
	private String title;
	private String message;
	private String type;
	private String referenceType;
	private Long referenceId;
	private String actorName;
	private String createdAt;
}
