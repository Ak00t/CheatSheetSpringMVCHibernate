package com.hibernate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.entity.TagEntity;
import com.hibernate.entity.enums.TagStatus;
import com.hibernate.repository.TagRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TagServiceImpl implements TagService {

	private final TagRepository tagRepository;

	@Override
	@Transactional
	public Long save(TagEntity tag) {
		return tagRepository.save(tag);
	}

	@Override
	@Transactional
	public List<TagEntity> findAll() {
		return tagRepository.findAll();
	}

	@Override
	@Transactional
	public TagEntity findById(Long id) {
		return tagRepository.findById(id);
	}

	@Override
	@Transactional
	public void update(TagEntity tag) {
		tagRepository.update(tag);
	}

	
	
	@Override
	@Transactional
	public void delete(Long id) {
	    TagEntity tag = tagRepository.findById(id);

	    if (tag != null) {
	        tag.setStatus(TagStatus.INACTIVE);
	        tagRepository.update(tag);
	    }
	}
	
	
	 //child category နှိပ်ရင်ပေါ်လာမယ့် view -- cheatcheatcard list / tag list 
	@Override
	@Transactional
	public List<TagEntity> findActiveTagsByCategoryId(Long categoryId) {
	    return tagRepository.findActiveTagsByCategoryId(categoryId);
	}
	
	
	
	
	
}