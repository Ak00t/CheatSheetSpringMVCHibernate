package com.hibernate.repository;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.CheatsheetEntity;
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
    
    //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
	
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
                        "and c.status = :status " +
                        "order by c.id asc",
                        CheatsheetEntity.class)
                .setParameter("categoryId", categoryId)
                .setParameter("publishStatus", PublishStatus.PUBLISHED)
                .setParameter("status", ContentStatus.ACTIVE)
                .getResultList();
    }
 // child tag နှိပ်ရင် ပေါ်လာမယ့် view -- cheatsheetcard list
 // 🌟 Tag ID အလိုက် စစ်ထုတ်ပေးမည့် HQL Query အသစ် 🌟
    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId) {
        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "inner join c.tags t " + // Many-to-Many Tags ကို Join ခြင်း
                        "left join fetch c.mediaList " +
                        "left join fetch c.user " +
                        "left join fetch c.category " +
                        "where t.id = :tagId " +
                        "and c.publishStatus = :publishStatus " +
                        "and c.status = :status " +
                        "order by c.id asc",
                        CheatsheetEntity.class)
                .setParameter("tagId", tagId)
                .setParameter("publishStatus", PublishStatus.PUBLISHED)
                .setParameter("status", ContentStatus.ACTIVE)
                .getResultList();
    }
    //cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
   
    @Override
    public CheatsheetEntity findDetailsById(Long id) {
        
        // ၁။ Cheatsheet အဓိက အချက်အလက်၊ ၎င်းနှင့်ဆိုင်သော sections, user နှင့် category အား Fetch လုပ်ယူသည်
        CheatsheetEntity cheatsheet = sessionFactory.getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.sections s " +
                        "left join fetch c.user " +
                        "left join fetch c.category " +
                        "where c.id = :id", CheatsheetEntity.class)
                .setParameter("id", id)
                .getSingleResult();

        // ၂။ Cheatsheet အဆင့်ရှိ notes ကို ခွဲထုတ်ပြီး Fetch လုပ်သည်
        sessionFactory.getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.notes " +
                        "where c.id = :id", CheatsheetEntity.class)
                .setParameter("id", id)
                .getSingleResult();

        // ၃။ mediaList ကို ခွဲထုတ်ပြီး Fetch လုပ်သည်
        sessionFactory.getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.mediaList " +
                        "where c.id = :id", CheatsheetEntity.class)
                .setParameter("id", id)
                .getSingleResult();

        // ၄။ 🌟 [ပြင်ဆင်ချက်] Section အလိုက်ရှိသော Rows, Cells များနှင့် Section Notes များကိုပါ အဆင့်ဆင့် Fetch လုပ်ခြင်း
        if (cheatsheet.getSections() != null) {
            for (com.hibernate.entity.CheatsheetSectionEntity sec : cheatsheet.getSections()) {
                
                // (က) ဆက်ရှင်အလိုက် rows များကို Fetch လုပ်သည်
                sessionFactory.getCurrentSession()
                        .createQuery(
                                "select distinct s from CheatsheetSectionEntity s " +
                                "left join fetch s.rows r " +
                                "where s.id = :secId", com.hibernate.entity.CheatsheetSectionEntity.class)
                        .setParameter("secId", sec.getId())
                        .getSingleResult();

                // (ခ) 🌟 [အသစ်တိုးမြှင့်ချက်] Section အလိုက်ရှိသော Notes များကိုပါ ဒုတိယ MultipleBag မဖြစ်အောင် သီးသန့် Fetch လုပ်ပေးခြင်း
                sessionFactory.getCurrentSession()
                        .createQuery(
                                "select distinct s from CheatsheetSectionEntity s " +
                                "left join fetch s.notes " +
                                "where s.id = :secId", com.hibernate.entity.CheatsheetSectionEntity.class)
                        .setParameter("secId", sec.getId())
                        .getSingleResult();

                // (ဂ) ရလာတဲ့ rows တစ်ခုချင်းစီရဲ့ အောက်က cells များကို ထပ်မံခွဲပြီး Fetch လုပ်သည်
                if (sec.getRows() != null) {
                    for (com.hibernate.entity.CheatsheetRowEntity row : sec.getRows()) {
                        sessionFactory.getCurrentSession()
                                .createQuery(
                                        "select distinct r from CheatsheetRowEntity r " +
                                        "left join fetch r.cells " +
                                        "where r.id = :rowId", com.hibernate.entity.CheatsheetRowEntity.class)
                                .setParameter("rowId", row.getId())
                                .getSingleResult();
                    }
                }
            }
        }
        
        return cheatsheet;
    }
 // profile view မှာ userId အလိုက် cheatsheet list ထုတ်ရန်
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
                        "order by c.id asc", CheatsheetEntity.class)
                .setParameter("userId", userId)
                .setParameter("deletedStatus", com.hibernate.entity.enums.ContentStatus.DELETED)
                .getResultList(); 
    }
 // 🌟 ၂။ [နာမည်အသစ်] Profile Detail View အတွက် တစ်စောင်တည်းကို အသေးစိတ် ပြသမည့် မိတ်သတ် (Single Object ပြန်ပေးရမည်)
    @Override
    public CheatsheetEntity findProfileDetailById(Long id) {
        return sessionFactory
                .getCurrentSession()
                .createQuery(
                        "select distinct c from CheatsheetEntity c " +
                        "left join fetch c.category " +  
                        "left join fetch c.user " +      
                        "left join fetch c.mediaList " + 
                        "where c.id = :id", CheatsheetEntity.class)
                .setParameter("id", id)
                .uniqueResult(); 
    }
    
    
 
   
    
    
}