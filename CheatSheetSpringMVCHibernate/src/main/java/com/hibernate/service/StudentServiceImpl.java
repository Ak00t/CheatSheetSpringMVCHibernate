package com.hibernate.service;

import org.springframework.stereotype.Service;

import com.hibernate.entity.StudentEntity;
import com.hibernate.repository.StudentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StudentServiceImpl implements StudentService {

    private final StudentRepository stuRepo;

    @Override
    public Integer insertStudent(StudentEntity obj) {
	// TODO Auto-generated method stub
	return stuRepo.insertStudent(obj);
    }

}
