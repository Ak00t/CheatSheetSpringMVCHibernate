package com.hibernate.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hibernate.entity.LikeEntity;
import com.hibernate.entity.ids.LikeId;
@Repository

public class LikeRepositoryImpl implements LikeRepository {

		@Autowired
		private SessionFactory sessionFactory;
		public Session getSession() {
			return sessionFactory.openSession();
		    }
	@Override
	public void save(LikeEntity like) {
		sessionFactory.getCurrentSession().saveOrUpdate(like);
	}
	

	@Override
	public void delete(LikeId likeId) {
		Session session = sessionFactory.getCurrentSession();
		LikeEntity like = session.get(LikeEntity.class,likeId);
		if(null!=like) {
			session.delete(like);
		}
		
	}

	@Override
	public boolean exsits(LikeId likeId) {
	
		return sessionFactory.getCurrentSession().get(LikeEntity.class,likeId)!=null;
	}

	@Override
	public List<LikeEntity> getAlllike() {
		
		return getSession().createQuery("from LikeEntity",LikeEntity.class).list();
	}

}
