package com.hibernate.service;

import com.hibernate.entity.*;
import com.hibernate.entity.enums.TagRequestStatus;
import com.hibernate.repository.TagRequestProcessRepository;
import com.hibernate.service.TagRequestProcessService;
import org.hibernate.SessionFactory; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class TagRequestProcessServiceImpl implements TagRequestProcessService {

    @Autowired 
    private TagRequestProcessRepository repository;
    
    @Autowired 
    private SessionFactory sessionFactory; 

    @Override
    public List<TagRequestEntity> getPendingRequests() {
        return repository.findByStatus(TagRequestStatus.PENDING);
    }

    @Override
    public void approveTagRequest(Long requestId) {
        TagRequestEntity request = repository.findById(requestId);
        
        if (request != null) {
            // 1. Create and populate new Tag
            TagEntity newTag = new TagEntity();
            newTag.setName(request.getName());
            newTag.setCategory(request.getCategory());
            
            String slug = request.getName().toLowerCase().replaceAll("\\s+", "-");
            newTag.setSlug(slug);
            
            repository.save(newTag);

            // Force Hibernate to flush and populate the auto-generated identity ID into newTag
            sessionFactory.getCurrentSession().flush(); 

            // 2. Link Tag to User if requestedBy exists
            if (request.getRequestedBy() != null) {
                UserFollowedTagEntity followedTag = new UserFollowedTagEntity();
                
                // Explicitly set primitive ID fields due to insertable = false mapping on objects
                followedTag.setUserId(request.getRequestedBy().getId());
                followedTag.setTagId(newTag.getId()); 
                
                // Sync object associations to maintain persistence context state
                followedTag.setUser(request.getRequestedBy());
                followedTag.setTag(newTag);
                
                repository.save(followedTag);
            }

            // 3. Update Request Status to APPROVED
            request.setStatus(TagRequestStatus.APPROVED);
            repository.update(request);
        }
    }

    @Override
    public void rejectTagRequest(Long requestId) {
        TagRequestEntity request = repository.findById(requestId);
        if (request != null) {
            request.setStatus(TagRequestStatus.REJECTED);
            repository.update(request);
        }
    }

    @Override
    public long getPendingCount() {
        return repository.findByStatus(TagRequestStatus.PENDING).size();
    }
}