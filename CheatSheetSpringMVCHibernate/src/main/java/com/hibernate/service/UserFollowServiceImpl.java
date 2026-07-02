package com.hibernate.service;

import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hibernate.entity.UserFollowEntity;
import com.hibernate.repository.UserFollowRepository;
import com.hibernate.service.UserFollowService;

@Service
public class UserFollowServiceImpl implements UserFollowService {

    @Autowired
    private UserFollowRepository followRepo;

    @Override
    public void toggleFollow(Long followerId, Long followingId) {
        // ၁။ Validation: ကိုယ့်ကိုယ်ကို Follow မလုပ်ရအောင် စစ်ပါ
        if (followerId.equals(followingId)) {
            throw new IllegalArgumentException("You cannot follow yourself!");
        }

        // ၂။ Business Logic: ရှိရင် ဖျက် (Unfollow)၊ မရှိရင် ထည့် (Follow)
        boolean isAlreadyFollowing = followRepo.exists(followerId, followingId);
        
        if (isAlreadyFollowing) {
            followRepo.delete(followerId, followingId);
        } else {
            UserFollowEntity follow = new UserFollowEntity();
            follow.setFollowerId(followerId);
            follow.setFollowingId(followingId);
            follow.setCreatedAt(LocalDateTime.now());
            
            followRepo.save(follow);
        }
    }
    @Override
    public boolean isFollowing(Long followerId, Long followingId) {
        // Repository ထဲက exists method ကို ပြန်ခေါ်သုံးပေးခြင်း
        return followRepo.exists(followerId, followingId);
    }
}