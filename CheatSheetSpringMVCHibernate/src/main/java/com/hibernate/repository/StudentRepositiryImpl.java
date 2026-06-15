package com.hibernate.repository;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.StudentEntity;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class StudentRepositiryImpl implements StudentRepository {

    private final SessionFactory sessionFactory;

    public Session getSession() {
	return sessionFactory.getCurrentSession();
    }

    @Override
    public Integer insertStudent(StudentEntity obj) {

	return (Integer) getSession().save(obj);
    }

}
