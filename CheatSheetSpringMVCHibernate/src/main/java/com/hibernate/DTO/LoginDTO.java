package com.hibernate.DTO;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginDTO {
	@NotBlank
	public String email;
	@NotBlank
	public String password;

}
