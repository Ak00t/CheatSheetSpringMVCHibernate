package com.hibernate.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class SearchSuggestionDTO {
	private Long id;
	private String name;
	private String type;

}
