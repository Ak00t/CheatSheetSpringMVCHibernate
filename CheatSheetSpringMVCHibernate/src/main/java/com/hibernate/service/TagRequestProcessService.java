package com.hibernate.service;

import com.hibernate.entity.TagRequestEntity;
import java.util.List;

public interface TagRequestProcessService {
    List<TagRequestEntity> getPendingRequests();
    long getPendingCount(); // ဒီလိုင်းလေး ထည့်ပေးပါ
    void approveTagRequest(Long requestId);
    void rejectTagRequest(Long requestId);
}