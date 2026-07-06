package com.hibernate.service;

import com.hibernate.entity.*;
import com.hibernate.entity.enums.TagRequestStatus;
import com.hibernate.repository.TagRequestProcessRepository;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
            String slug = request.getName().toLowerCase().replaceAll("\\s+", "-");
            
            // Database ထဲမှာ slug ရှိပြီးသားလား စစ်ဆေးခြင်း
            final boolean[] isDuplicate = {false};
            sessionFactory.getCurrentSession().doWork(connection -> {
                String sql = "SELECT COUNT(*) FROM tags WHERE slug = ?";
                try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                    pstmt.setString(1, slug);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next() && rs.getInt(1) > 0) isDuplicate[0] = true;
                    }
                }
            });

            // Duplicate ဖြစ်ရင် Controller က 409 အဖြစ်ဖမ်းနိုင်အောင် Exception ပစ်မယ်
            if (isDuplicate[0]) {
                throw new IllegalArgumentException("Duplicate"); 
            }

            // Tag အသစ်ဖန်တီးခြင်း
            TagEntity newTag = new TagEntity();
            newTag.setName(request.getName());
            newTag.setSlug(slug);
            newTag.setCategory(request.getCategory());
            repository.save(newTag);
            
            // Request Status ကို APPROVED ပြောင်းခြင်း
            request.setStatus(TagRequestStatus.APPROVED);
            repository.update(request);
        }
    }

    @Override
    public void rejectTagRequest(Long requestId) {
        TagRequestEntity request = repository.findById(requestId);
        if (request != null) {
            // Request Status ကို REJECTED ပြောင်းခြင်း
            request.setStatus(TagRequestStatus.REJECTED);
            repository.update(request);
        }
    }

    @Override
    public long getPendingCount() {
        // PENDING ဖြစ်နေတဲ့ အရေအတွက်ကို ပြန်ပေးခြင်း
        return repository.findByStatus(TagRequestStatus.PENDING).size();
    }
}