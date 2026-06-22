package com.hibernate.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import javax.persistence.*;
import com.hibernate.entity.enums.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "announcements")
public class AnnouncementEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 200, nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('INFO','WARNING','MAINTENANCE','UPDATE')")
    private AnnouncementType type;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('DRAFT','ACTIVE','EXPIRED') DEFAULT 'DRAFT'")
    private AnnouncementStatus status = AnnouncementStatus.DRAFT;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by")
    private UserEntity createdBy;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime createdAt;

    @Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime updatedAt;
}
