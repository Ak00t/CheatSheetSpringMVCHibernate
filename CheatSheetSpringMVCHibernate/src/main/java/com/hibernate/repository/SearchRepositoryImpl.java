package com.hibernate.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hibernate.DTO.SearchResultDTO;
import com.hibernate.entity.CategoryEntity;
import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.SearchLogEntity;
import com.hibernate.entity.UserEntity;

import lombok.RequiredArgsConstructor;

@Repository
@Transactional
@RequiredArgsConstructor
public class SearchRepositoryImpl implements SearchRepository {

	private final SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public SearchResultDTO searchAll(String keyword) {

		String wildcardKeyword = "%" + keyword.toLowerCase() + "%";
		SearchResultDTO results = new SearchResultDTO();

		results
				.setCheatsheets(getSession()
						.createQuery(
								"FROM CheatsheetEntity c WHERE LOWER(c.title) LIKE :kw OR LOWER(c.description) LIKE :kw",
								CheatsheetEntity.class)
							.setParameter("kw", wildcardKeyword)
							.setMaxResults(10)
							.getResultList());

		results
				.setCategories(getSession()
						.createQuery(
								"FROM CategoryEntity cat WHERE LOWER(cat.name) LIKE :kw OR LOWER(cat.description) LIKE :kw",
								CategoryEntity.class)
							.setParameter("kw", wildcardKeyword)
							.setMaxResults(5)
							.getResultList());

		results
				.setUsers(getSession()
						.createQuery("FROM UserEntity u WHERE LOWER(u.name) LIKE :kw OR LOWER(u.email) LIKE :kw",
								UserEntity.class)
							.setParameter("kw", wildcardKeyword)
							.setMaxResults(5)
							.getResultList());
		return results;
	}

	@Override
	public List<SearchLogEntity> getSearchLogByUserId(Long userId) {
		return getSession()
				.createQuery(
						"FROM SearchLogEntity sl LEFT JOIN FETCH  sl.user WHERE sl.user.id = :userId ORDER BY sl.createdAt DESC",
						SearchLogEntity.class)
					.setParameter("userId", userId)
					.setMaxResults(6)
					.getResultList();
	}

	@Override
	public void saveSearchLog(String keyword, int resultCount, Long userId) {
		SearchLogEntity log = new SearchLogEntity();
		log.setKeyword(keyword);
		log.setResultCount(resultCount);

		if (userId != null) {
			UserEntity userSessionRef = new UserEntity();
			userSessionRef.setId(userId);
			log.setUser(userSessionRef);
		} else {
			log.setUser(null); // Anonymous persistent log row
		}

		getSession().save(log);
	}
}
