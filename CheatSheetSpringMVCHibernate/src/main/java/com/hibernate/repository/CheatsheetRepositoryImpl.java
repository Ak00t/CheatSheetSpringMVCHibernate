package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.PublishStatus;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CheatsheetRepositoryImpl implements CheatsheetRepository {

    private final SessionFactory sessionFactory;

    @Override
    public Long save(CheatsheetEntity cheatsheet) {
        return (Long) sessionFactory
                .getCurrentSession()
                .save(cheatsheet);
    }

    @Override
    public CheatsheetEntity findById(Long id) {
        return sessionFactory
                .getCurrentSession()
                .get(CheatsheetEntity.class, id);
    }

    @Override
    public void update(CheatsheetEntity cheatsheet) {
        sessionFactory
                .getCurrentSession()
                .update(cheatsheet);
    }

    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByCategoryId(Long categoryId) {

        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.mediaList " +
                        "left join fetch c.user " +
                        "left join fetch c.category " +
                        "where c.category.id = :categoryId " +
                        "and c.publishStatus = :publishStatus " +
                        "and c.visibility = :visibility " +
                        "and c.status = :status " +
                        "order by c.id asc",
                        CheatsheetEntity.class)
                .setParameter("categoryId", categoryId)
                .setParameter("publishStatus", PublishStatus.PUBLISHED)
                .setParameter("visibility", CheatsheetVisibility.PUBLIC)
                .setParameter("status", ContentStatus.ACTIVE)
                .getResultList();
    }

    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId) {

        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "inner join c.tags t " +
                        "left join fetch c.mediaList " +
                        "left join fetch c.user " +
                        "left join fetch c.category " +
                        "where t.id = :tagId " +
                        "and c.publishStatus = :publishStatus " +
                        "and c.visibility = :visibility " +
                        "and c.status = :status " +
                        "order by c.id asc",
                        CheatsheetEntity.class)
                .setParameter("tagId", tagId)
                .setParameter("publishStatus", PublishStatus.PUBLISHED)
                .setParameter("visibility", CheatsheetVisibility.PUBLIC)
                .setParameter("status", ContentStatus.ACTIVE)
                .getResultList();
    }

    @Override
    public CheatsheetEntity findDetailsById(Long id) {

        CheatsheetEntity cheatsheet = sessionFactory.getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.sections s " +
                        "left join fetch c.user " +
                        "left join fetch c.category " +
                        "where c.id = :id",
                        CheatsheetEntity.class)
                .setParameter("id", id)
                .getSingleResult();

        sessionFactory.getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.notes " +
                        "where c.id = :id",
                        CheatsheetEntity.class)
                .setParameter("id", id)
                .getSingleResult();

        sessionFactory.getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.mediaList " +
                        "where c.id = :id",
                        CheatsheetEntity.class)
                .setParameter("id", id)
                .getSingleResult();

        if (cheatsheet.getSections() != null) {
            for (com.hibernate.entity.CheatsheetSectionEntity sec : cheatsheet.getSections()) {

                sessionFactory.getCurrentSession()
                        .createQuery(
                                "select distinct s from CheatsheetSectionEntity s " +
                                "left join fetch s.rows r " +
                                "where s.id = :secId",
                                com.hibernate.entity.CheatsheetSectionEntity.class)
                        .setParameter("secId", sec.getId())
                        .getSingleResult();

                sessionFactory.getCurrentSession()
                        .createQuery(
                                "select distinct s from CheatsheetSectionEntity s " +
                                "left join fetch s.notes " +
                                "where s.id = :secId",
                                com.hibernate.entity.CheatsheetSectionEntity.class)
                        .setParameter("secId", sec.getId())
                        .getSingleResult();

                if (sec.getRows() != null) {
                    for (com.hibernate.entity.CheatsheetRowEntity row : sec.getRows()) {
                        sessionFactory.getCurrentSession()
                                .createQuery(
                                        "select distinct r from CheatsheetRowEntity r " +
                                        "left join fetch r.cells " +
                                        "where r.id = :rowId",
                                        com.hibernate.entity.CheatsheetRowEntity.class)
                                .setParameter("rowId", row.getId())
                                .getSingleResult();
                    }
                }
            }
        }

        return cheatsheet;
    }

    @Override
    public List<CheatsheetEntity> findProfileCheatsheetByUserId(Long userId) {

        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.user " +
                        "left join fetch c.category " +
                        "left join fetch c.mediaList " +
                        "where c.user.id = :userId " +
                        "and c.status != :deletedStatus " +
                        "order by c.id asc",
                        CheatsheetEntity.class)
                .setParameter("userId", userId)
                .setParameter("deletedStatus", ContentStatus.DELETED)
                .getResultList();
    }

    @Override
    public CheatsheetEntity findProfileDetailById(Long id) {

        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.category " +
                        "left join fetch c.user " +
                        "left join fetch c.mediaList " +
                        "where c.id = :id",
                        CheatsheetEntity.class)
                .setParameter("id", id)
                .uniqueResult();
    }

    public CheatsheetEntity findVisibleCheatsheet(Long cheatsheetId, Long loginUserId) {

        CheatsheetEntity cheatsheet = findDetailsById(cheatsheetId);

        if (cheatsheet == null) {
            return null;
        }

        if (loginUserId != null
                && cheatsheet.getUser() != null
                && cheatsheet.getUser().getId().equals(loginUserId)
                && cheatsheet.getStatus() != ContentStatus.DELETED) {

            return cheatsheet;
        }

        if (cheatsheet.getPublishStatus() == PublishStatus.PUBLISHED
                && cheatsheet.getVisibility() == CheatsheetVisibility.PUBLIC
                && cheatsheet.getStatus() == ContentStatus.ACTIVE) {

            return cheatsheet;
        }

        return null;
    }
    
    
    
    //fianl
 // =========================
 // Home Page Statistics
 // =========================

 @Override
 public long countPublicCheatsheets() {
     return sessionFactory
             .getCurrentSession()
             .createQuery(
                     "select count(c.id) from CheatsheetEntity c " +
                     "where c.publishStatus = :publishStatus " +
                     "and c.visibility = :visibility " +
                     "and c.status = :status",
                     Long.class)
             .setParameter("publishStatus", PublishStatus.PUBLISHED)
             .setParameter("visibility", CheatsheetVisibility.PUBLIC)
             .setParameter("status", ContentStatus.ACTIVE)
             .getSingleResult();
 }

 @Override
 public List<CheatsheetEntity> findPopularCheatsheets(int limit) {
     return sessionFactory
             .getCurrentSession()
             .createQuery(
                     "select distinct c from CheatsheetEntity c " +
                     "left join fetch c.user " +
                     "left join fetch c.category " +
                     "left join fetch c.mediaList " +
                     "where c.publishStatus = :publishStatus " +
                     "and c.visibility = :visibility " +
                     "and c.status = :status " +
                     "order by c.viewCount desc, c.likeCount desc, c.bookmarkCount desc",
                     CheatsheetEntity.class)
             .setParameter("publishStatus", PublishStatus.PUBLISHED)
             .setParameter("visibility", CheatsheetVisibility.PUBLIC)
             .setParameter("status", ContentStatus.ACTIVE)
             .setMaxResults(limit)
             .getResultList();
 }

 @Override
 public List<CheatsheetEntity> findRecentCheatsheets(int limit) {
     return sessionFactory
             .getCurrentSession()
             .createQuery(
                     "select distinct c from CheatsheetEntity c " +
                     "left join fetch c.user " +
                     "left join fetch c.category " +
                     "left join fetch c.mediaList " +
                     "where c.publishStatus = :publishStatus " +
                     "and c.visibility = :visibility " +
                     "and c.status = :status " +
                     "order by c.createdAt desc",
                     CheatsheetEntity.class)
             .setParameter("publishStatus", PublishStatus.PUBLISHED)
             .setParameter("visibility", CheatsheetVisibility.PUBLIC)
             .setParameter("status", ContentStatus.ACTIVE)
             .setMaxResults(limit)
             .getResultList();
 }

 @Override
 public List<CheatsheetEntity> findPopularByParentCategoryId(Long parentId) {
     return sessionFactory
             .getCurrentSession()
             .createQuery(
                     "select distinct c from CheatsheetEntity c " +
                     "left join fetch c.user " +
                     "left join fetch c.category cat " +
                     "left join fetch c.mediaList " +
                     "where cat.parent.id = :parentId " +
                     "and c.publishStatus = :publishStatus " +
                     "and c.visibility = :visibility " +
                     "and c.status = :status " +
                     "order by c.viewCount desc, c.likeCount desc, c.bookmarkCount desc",
                     CheatsheetEntity.class)
             .setParameter("parentId", parentId)
             .setParameter("publishStatus", PublishStatus.PUBLISHED)
             .setParameter("visibility", CheatsheetVisibility.PUBLIC)
             .setParameter("status", ContentStatus.ACTIVE)
             .setMaxResults(5)
             .getResultList();
 }

 @Override
 public List<CheatsheetEntity> findRecentByParentCategoryId(Long parentId) {
     return sessionFactory
             .getCurrentSession()
             .createQuery(
                     "select distinct c from CheatsheetEntity c " +
                     "left join fetch c.user " +
                     "left join fetch c.category cat " +
                     "left join fetch c.mediaList " +
                     "where cat.parent.id = :parentId " +
                     "and c.publishStatus = :publishStatus " +
                     "and c.visibility = :visibility " +
                     "and c.status = :status " +
                     "order by c.createdAt desc",
                     CheatsheetEntity.class)
             .setParameter("parentId", parentId)
             .setParameter("publishStatus", PublishStatus.PUBLISHED)
             .setParameter("visibility", CheatsheetVisibility.PUBLIC)
             .setParameter("status", ContentStatus.ACTIVE)
             .setMaxResults(5)
             .getResultList();
 }
 
 
 
//=========================
//Child Category View
//=========================

@Override
public List<CheatsheetEntity> findPopularByCategoryId(
      Long categoryId) {

  return sessionFactory
          .getCurrentSession()
          .createQuery(
                  "select distinct c from CheatsheetEntity c " +
                  "left join fetch c.user " +
                  "left join fetch c.category " +
                  "left join fetch c.mediaList " +
                  "where c.category.id = :categoryId " +
                  "and c.publishStatus = :publishStatus " +
                  "and c.visibility = :visibility " +
                  "and c.status = :status " +
                  "order by c.viewCount desc, c.likeCount desc, c.bookmarkCount desc",
                  CheatsheetEntity.class)
          .setParameter("categoryId", categoryId)
          .setParameter("publishStatus", PublishStatus.PUBLISHED)
          .setParameter("visibility", CheatsheetVisibility.PUBLIC)
          .setParameter("status", ContentStatus.ACTIVE)
          .setMaxResults(5)
          .getResultList();
}

@Override
public List<CheatsheetEntity> findRecentByCategoryId(
      Long categoryId) {

  return sessionFactory
          .getCurrentSession()
          .createQuery(
                  "select distinct c from CheatsheetEntity c " +
                  "left join fetch c.user " +
                  "left join fetch c.category " +
                  "left join fetch c.mediaList " +
                  "where c.category.id = :categoryId " +
                  "and c.publishStatus = :publishStatus " +
                  "and c.visibility = :visibility " +
                  "and c.status = :status " +
                  "order by c.createdAt desc",
                  CheatsheetEntity.class)
          .setParameter("categoryId", categoryId)
          .setParameter("publishStatus", PublishStatus.PUBLISHED)
          .setParameter("visibility", CheatsheetVisibility.PUBLIC)
          .setParameter("status", ContentStatus.ACTIVE)
          .setMaxResults(5)
          .getResultList();
}

//pagination
    
@Override
public List<CheatsheetEntity> findPublishedCheatsheetsByCategoryIdWithPagination(
        Long categoryId,
        int page,
        int size) {

    return sessionFactory.getCurrentSession()
            .createQuery(
                    "select distinct c from CheatsheetEntity c " +
                    "left join fetch c.mediaList " +
                    "left join fetch c.user " +
                    "left join fetch c.category " +
                    "where c.category.id = :categoryId " +
                    "and c.publishStatus = :publishStatus " +
                    "and c.visibility = :visibility " +
                    "and c.status = :status " +
                    "order by c.createdAt desc",
                    CheatsheetEntity.class)
            .setParameter("categoryId", categoryId)
            .setParameter("publishStatus", PublishStatus.PUBLISHED)
            .setParameter("visibility", CheatsheetVisibility.PUBLIC)
            .setParameter("status", ContentStatus.ACTIVE)
            .setFirstResult(page * size)
            .setMaxResults(size)
            .getResultList();
}

@Override
public long countPublishedCheatsheetsByCategoryId(Long categoryId) {

    return sessionFactory.getCurrentSession()
            .createQuery(
                    "select count(c.id) from CheatsheetEntity c " +
                    "where c.category.id = :categoryId " +
                    "and c.publishStatus = :publishStatus " +
                    "and c.visibility = :visibility " +
                    "and c.status = :status",
                    Long.class)
            .setParameter("categoryId", categoryId)
            .setParameter("publishStatus", PublishStatus.PUBLISHED)
            .setParameter("visibility", CheatsheetVisibility.PUBLIC)
            .setParameter("status", ContentStatus.ACTIVE)
            .getSingleResult();
}

@Override
public List<CheatsheetEntity> findPublishedCheatsheetsByTagIdWithPagination(
        Long tagId,
        int page,
        int size) {

    return sessionFactory.getCurrentSession()
            .createQuery(
                    "select distinct c from CheatsheetEntity c " +
                    "inner join c.tags t " +
                    "left join fetch c.mediaList " +
                    "left join fetch c.user " +
                    "left join fetch c.category " +
                    "where t.id = :tagId " +
                    "and c.publishStatus = :publishStatus " +
                    "and c.visibility = :visibility " +
                    "and c.status = :status " +
                    "order by c.createdAt desc",
                    CheatsheetEntity.class)
            .setParameter("tagId", tagId)
            .setParameter("publishStatus", PublishStatus.PUBLISHED)
            .setParameter("visibility", CheatsheetVisibility.PUBLIC)
            .setParameter("status", ContentStatus.ACTIVE)
            .setFirstResult(page * size)
            .setMaxResults(size)
            .getResultList();
}


//pagination
@Override
public long countPublishedCheatsheetsByTagId(Long tagId) {

    return sessionFactory.getCurrentSession()
            .createQuery(
                    "select count(distinct c.id) from CheatsheetEntity c " +
                    "inner join c.tags t " +
                    "where t.id = :tagId " +
                    "and c.publishStatus = :publishStatus " +
                    "and c.visibility = :visibility " +
                    "and c.status = :status",
                    Long.class)
            .setParameter("tagId", tagId)
            .setParameter("publishStatus", PublishStatus.PUBLISHED)
            .setParameter("visibility", CheatsheetVisibility.PUBLIC)
            .setParameter("status", ContentStatus.ACTIVE)
            .getSingleResult();
}


    
}