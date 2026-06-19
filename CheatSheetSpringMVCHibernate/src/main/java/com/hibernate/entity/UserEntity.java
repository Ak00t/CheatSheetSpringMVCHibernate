package com.hibernate.entity;

import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.*;
import com.hibernate.entity.enums.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100, nullable = false)
    private String name;

    @Column(length = 150, nullable = false, unique = true)
    private String email;

    @Column(length = 255, nullable = false)
    private String password;

    @Column(name = "profile_img", length = 255)
    private String profileImg;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('USER','ADMIN','MODERATOR') DEFAULT 'USER'")
    private UserRole role = UserRole.USER;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('ACTIVE','INACTIVE','BANNED') DEFAULT 'ACTIVE'")
    private UserStatus status = UserStatus.ACTIVE;

    @Enumerated(EnumType.STRING)
    @Column(name = "theme_mode", columnDefinition = "ENUM('LIGHT','DARK','SYSTEM') DEFAULT 'SYSTEM'")
    private ThemeMode themeMode = ThemeMode.SYSTEM;

    @Enumerated(EnumType.STRING)
    @Column(name = "profile_visibility", columnDefinition = "ENUM('PUBLIC','PRIVATE') DEFAULT 'PUBLIC'")
    private ProfileVisibility profileVisibility = ProfileVisibility.PUBLIC;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime createdAt;

    @Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RememberTokenEntity> rememberTokens;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<CheatsheetEntity> cheatsheets;

    @OneToMany(mappedBy = "createdBy")
    private List<TagEntity> createdTags;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BookmarkEntity> bookmarks;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<LikeEntity> likes;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<ShareEntity> shares;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RatingEntity> ratings;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<CommentEntity> comments;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CollectionEntity> collections;

    @OneToMany(mappedBy = "follower", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserFollowEntity> followingUsers;

    @OneToMany(mappedBy = "following", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserFollowEntity> followerUsers;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserFollowedCategoryEntity> followedCategories;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserFollowedTagEntity> followedTags;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<SearchLogEntity> searchLogs;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<UserActivityLogEntity> activityLogs;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<NotificationEntity> notifications;

    @OneToMany(mappedBy = "actorUser")
    private List<NotificationEntity> actorNotifications;

    @OneToMany(mappedBy = "reporterUser")
    private List<ReportEntity> reports;

    @OneToMany(mappedBy = "reviewedBy")
    private List<ReportEntity> reviewedReports;

    @OneToMany(mappedBy = "user")
    private List<BanEntity> bans;

    @OneToMany(mappedBy = "bannedBy")
    private List<BanEntity> createdBans;

    @OneToMany(mappedBy = "user")
    private List<WarningEntity> warnings;

    @OneToMany(mappedBy = "createdBy")
    private List<WarningEntity> createdWarnings;

    @OneToMany(mappedBy = "createdBy")
    private List<AnnouncementEntity> announcements;

    @OneToMany(mappedBy = "adminUser")
    private List<AuditLogEntity> auditLogs;
}
