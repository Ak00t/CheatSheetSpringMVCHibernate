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
	public SearchResultDTO searchAll(String keyword, Long currentUserId) {

		String wildcardKeyword = "%" + keyword.toLowerCase() + "%";
		SearchResultDTO results = new SearchResultDTO();

		results
				.setCheatsheets(getSession()
						.createQuery(
								"FROM CheatsheetEntity c WHERE LOWER(c.title) LIKE :kw OR LOWER(c.description) LIKE :kw",
								CheatsheetEntity.class)
							.setParameter("kw", wildcardKeyword)
							.setMaxResults(10) // Limit output stack size for speed optimization
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
		// 2. Calculate dynamic combined total matching count
		int totalCount = results.getCheatsheets().size() + results.getCategories().size() + results.getUsers().size();

		// 3. Write search log (Handles both logged-in users and anonymous guests)
		SearchLogEntity log = new SearchLogEntity();
		log.setKeyword(keyword);
		log.setResultCount(totalCount);

		if (currentUserId != null) {
			UserEntity userSessionRef = new UserEntity();
			userSessionRef.setId(currentUserId);
			log.setUser(userSessionRef); // Linked authenticated log
		} else {
			log.setUser(null); // Anonymous log (user_id remains NULL)
		}

		getSession().save(log);
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
}
