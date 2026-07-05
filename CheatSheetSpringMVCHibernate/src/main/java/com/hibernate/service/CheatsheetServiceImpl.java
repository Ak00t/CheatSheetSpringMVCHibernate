package com.hibernate.service;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.*;
import com.hibernate.entity.enums.CheatsheetVisibility;
import com.hibernate.entity.enums.ContentStatus;
import com.hibernate.entity.enums.PublishStatus;
import com.hibernate.repository.*;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class CheatsheetServiceImpl implements CheatsheetService {

    private final CheatsheetRepository cheatsheetRepository;
    private final CheatsheetTagRepository cheatsheetTagRepository;
    private final CheatsheetSectionRepository cheatsheetSectionRepository;
    private final CheatsheetRowRepository cheatsheetRowRepository;
    private final CheatsheetRowCellRepository cheatsheetRowCellRepository;
    private final CheatsheetNoteRepository cheatsheetNoteRepository;
    private final CheatsheetMediaRepository cheatsheetMediaRepository;
    private final TagRequestRepository tagRequestRepository;
    private final SessionFactory sessionFactory;

    @Override
    public Long saveCheatsheet(CheatsheetEntity cheatsheet) {
        return cheatsheetRepository.save(cheatsheet);
    }

    @Override
    public void saveCheatsheetTag(Long cheatsheetId, Long tagId) {
        cheatsheetTagRepository.save(cheatsheetId, tagId);
    }

    @Override
    public void saveSection(CheatsheetSectionEntity section) {
        cheatsheetSectionRepository.save(section);
    }

    @Override
    public void saveRow(CheatsheetRowEntity row) {
        cheatsheetRowRepository.save(row);
    }

    @Override
    public void saveRowCell(CheatsheetRowCellEntity cell) {
        cheatsheetRowCellRepository.save(cell);
    }

    @Override
    public void saveNote(CheatsheetNoteEntity note) {
        cheatsheetNoteRepository.save(note);
    }

    @Override
    public void saveMedia(CheatsheetMediaEntity media) {
        cheatsheetMediaRepository.save(media);
    }

    @Override
    public void saveTagRequest(TagRequestEntity request) {
        tagRequestRepository.save(request);
    }

    // child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list

    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByCategoryId(Long categoryId) {
        return cheatsheetRepository
                .findPublishedCheatsheetsByCategoryId(categoryId);
    }
    // child tag နှိပ်ရင် ပေါ်လာမယ့် view -- cheatsheetcard list

    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByTagId(Long tagId) {
        return cheatsheetRepository.findPublishedCheatsheetsByTagId(tagId);
    }

    // cheatsheet card နှိပ်လိုက်ရင် ပေါ်လာမယ့် cheatsheet view detail
    // CheatsheetServiceImpl.java ထဲတွင် တိုးရန်
    @Override
    public CheatsheetEntity findDetailsById(Long id) {
        return cheatsheetRepository.findDetailsById(id);
    }

    // profile view မှာ userId အလိုက် cheatsheet list ထုတ်ရန်
    @Override
    public List<CheatsheetEntity> findProfileCheatsheetByUserId(Long userId) {
        return cheatsheetRepository.findProfileCheatsheetByUserId(userId);
    }

    @Override
    public CheatsheetEntity findById(Long id) {
        return cheatsheetRepository.findById(id);
    }

    @Override
    public void updateCheatsheet(CheatsheetEntity cheatsheet) {
        cheatsheetRepository.update(cheatsheet);
    }

    @Override
    public void softDeleteCheatsheet(Long id) {

        CheatsheetEntity cheatsheet = cheatsheetRepository.findById(id);

        if (cheatsheet != null) {
            cheatsheet.setStatus(ContentStatus.DELETED);
            cheatsheetRepository.update(cheatsheet);
        }
    }

    // profile view မှာ userId အလိုက် cheatsheet detail view ထုတ်ရန်
    @Override
    public CheatsheetEntity findProfileDetailById(Long id) {
        return cheatsheetRepository.findProfileDetailById(id);
    }

    // profile edit အတွက် edit view မှာ မူလ old data များ ပြန်ပေါ်ရန်
    // 🌟 CheatsheetServiceImpl.java ထဲတွင် ဤမိတ်သတ်အသစ်အား တိုးပေးပါ
    @Override
    public CheatsheetEntity findDetailsForEdit(Long id) {
        // ၁။ Sections, Rows, Cells ပါဝင်ပြီးသား entity အား ဆွဲထုတ်သည်
        CheatsheetEntity cheatsheet = cheatsheetRepository.findDetailsById(id);

        if (cheatsheet != null && cheatsheet.getTags() != null) {
            // ၂။ 🌟 Transaction Session မပိတ်ခင် tags collection အား အတင်း initialize
            // လုပ်ပေးလိုက်ခြင်းဖြင့် JSP တွင် Lazy Error မတက်တော့ပါ။
            cheatsheet.getTags().size();
        }

        return cheatsheet;
    }
    // profile cheatsheet update အတွက် လိုအပ်သော method( profile cheatsheet
    // controller ရဲ့ update method နဲ့ အတွဲ)
    // profile cheatsheet update အတွက် လိုအပ်သော method( profile cheatsheet
    // controller ရဲ့ update method နဲ့ အတွဲ)

    @Override
    public CheatsheetEntity findVisibleCheatsheet(
            Long cheatsheetId,
            Long loginUserId) {

        return cheatsheetRepository.findVisibleCheatsheet(
                cheatsheetId,
                loginUserId);
    }

    // final
    // =========================
    // Home Page Statistics
    // =========================

    @Override
    public long countPublicCheatsheets() {
        return cheatsheetRepository.countPublicCheatsheets();
    }

    @Override
    public List<CheatsheetEntity> findPopularCheatsheets(int limit) {
        return cheatsheetRepository.findPopularCheatsheets(limit);
    }

    @Override
    public List<CheatsheetEntity> findRecentCheatsheets(int limit) {
        return cheatsheetRepository.findRecentCheatsheets(limit);
    }

    @Override
    public List<CheatsheetEntity> findPopularByParentCategoryId(Long parentId) {
        return cheatsheetRepository.findPopularByParentCategoryId(parentId);
    }

    @Override
    public List<CheatsheetEntity> findRecentByParentCategoryId(Long parentId) {
        return cheatsheetRepository.findRecentByParentCategoryId(parentId);
    }

    // =========================
    // Child Category View
    // =========================

    @Override
    public List<CheatsheetEntity> findPopularByCategoryId(
            Long categoryId) {

        return cheatsheetRepository
                .findPopularByCategoryId(
                        categoryId);
    }

    @Override
    public List<CheatsheetEntity> findRecentByCategoryId(
            Long categoryId) {

        return cheatsheetRepository
                .findRecentByCategoryId(
                        categoryId);
    }

    // 💡 CheatsheetServiceImpl.java ရဲ့ အတွင်းထဲတွင် ဤကုဒ်ကို ထည့်သွင်းပါ
    @Override
    @Transactional(readOnly = true)
    public List<CheatsheetEntity> findBookmarkedByUserId(Long userId) {
        // 💡 🛑 အဓိကပြင်ဆင်ချက်: b.cheatsheet ရဲ့ နောက်မှာ category နဲ့ user ကို JOIN
        // FETCH ခံပြီး တစ်ခါတည်း ဆွဲထုတ်ခိုင်းလိုက်ပါတယ်
        String hql = "SELECT c FROM BookmarkEntity b "
                + "JOIN b.cheatsheet c "
                + "JOIN FETCH c.category "
                + "JOIN FETCH c.user "
                + "WHERE b.userId = :userId";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, CheatsheetEntity.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    // pagination
    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByCategoryIdWithPagination(
            Long categoryId,
            int page,
            int size) {

        return cheatsheetRepository
                .findPublishedCheatsheetsByCategoryIdWithPagination(
                        categoryId,
                        page,
                        size);
    }

    @Override
    public long countPublishedCheatsheetsByCategoryId(Long categoryId) {

        return cheatsheetRepository
                .countPublishedCheatsheetsByCategoryId(categoryId);
    }

    @Override
    public List<CheatsheetEntity> findPublishedCheatsheetsByTagIdWithPagination(
            Long tagId,
            int page,
            int size) {

        return cheatsheetRepository
                .findPublishedCheatsheetsByTagIdWithPagination(
                        tagId,
                        page,
                        size);
    }

    @Override
    public long countPublishedCheatsheetsByTagId(Long tagId) {

        return cheatsheetRepository
                .countPublishedCheatsheetsByTagId(tagId);
    }

    @Override
    public List<CheatsheetEntity> findPublishedByUserId(
            Long userId) {

        return cheatsheetRepository
                .findPublishedByUserId(userId);
    }

    @Override
    public List<CheatsheetEntity> findDraftByUserId(
            Long userId) {

        return cheatsheetRepository
                .findDraftByUserId(userId);
    }

    @Override
    public List<CheatsheetEntity> findArchivedByUserId(
            Long userId) {

        return cheatsheetRepository
                .findArchivedByUserId(userId);
    }

    @Override
    public List<CheatsheetEntity> findPrivateByUserId(
            Long userId) {

        return cheatsheetRepository
                .findPrivateByUserId(userId);
    }

    @Override
    public long countAllByUserId(Long userId) {

        return cheatsheetRepository
                .countAllByUserId(userId);
    }

    @Override
    public List<CheatsheetEntity> findUnlistedByUserId(Long userId) {
        return cheatsheetRepository.findUnlistedByUserId(userId);
    }
    @Override
    public List<CheatsheetEntity> findPublicSheetsOfFollowersByUserId(Long userId) {
        String hql = "select distinct c from CheatsheetEntity c " +
                     "left join fetch c.user " +
                     "left join fetch c.category " +
                     "left join fetch c.mediaList " +
                     "where c.user.id in (" +
                     "    select f.followerId from UserFollowEntity f where f.followingId = :userId" +
                     ") " +
                     "and c.publishStatus = :publishStatus " +
                     // 🌟 ဤနေရာတွင် PUBLIC အပြင် UNLISTED (Followers Only) ကိုပါ OR ခံပြီး တိုးမြှင့်လိုက်သည်
                     "and (c.visibility = :pubVisibility or c.visibility = :unlistedVisibility) " + 
                     "and c.status = :status " +
                     "order by c.createdAt desc";

        return sessionFactory.getCurrentSession()
                .createQuery(hql, CheatsheetEntity.class)
                .setParameter("userId", userId)
                .setParameter("publishStatus", PublishStatus.PUBLISHED)
                .setParameter("pubVisibility", CheatsheetVisibility.PUBLIC)
                .setParameter("unlistedVisibility", CheatsheetVisibility.UNLISTED) 
                .setParameter("status", ContentStatus.ACTIVE)
                .getResultList();
    }
    

}
