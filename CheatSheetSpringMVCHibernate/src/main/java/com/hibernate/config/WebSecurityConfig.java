package com.hibernate.config;

import java.util.Set;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import com.hibernate.entity.UserEntity;
import com.hibernate.service.UserLoginRegisterService;
import com.hibernate.service.AdminActivityLogService;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurityConfig {
	private final UserDetailsService userDetailsService;
	private final UserLoginRegisterService userRepo;
	private final AdminActivityLogService adminActivityLogService; // Injecting Activity Log Service

	@Bean(name = "mvcHandlerMappingIntrospector")
	public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
		return new HandlerMappingIntrospector();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http
				.csrf()
					.disable()
					.authorizeHttpRequests(auth -> auth
							.requestMatchers("/home", "/register", "/login", "/resources/**")
								.permitAll()
								.anyRequest()
								.authenticated())

					.formLogin()
					.loginPage("/login")
					.loginProcessingUrl("/login")
					.successHandler(customSuccessHandler())

					.failureUrl("/login?error=true")
					.usernameParameter("email")
					.passwordParameter("password")
					.permitAll()

					.and()
					.logout()
					.logoutUrl("/logout")
					.logoutSuccessUrl("/login?logout=true")
					.permitAll()
					.and()
					.rememberMe()
					.key("myToken")
					.tokenValiditySeconds(86400)
					.rememberMeParameter("remember-me");
		return http.build();
	}

	@Bean
	public AuthenticationManager authManager(HttpSecurity http) throws Exception {
		return http
				.getSharedObject(AuthenticationManagerBuilder.class)
					.userDetailsService(userDetailsService)
					.passwordEncoder(passwordEncoder())
					.and()
					.build();
	}

	@Bean
	public AuthenticationSuccessHandler customSuccessHandler() {
		return (request, response, authentication) -> {
			Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());

			String email = authentication.getName();
			UserEntity loggedInUser = userRepo.findByEmail(email);
			
			if (loggedInUser != null) {
				request.getSession().setAttribute("currentUser", loggedInUser);
				
				int userId = loggedInUser.getId().intValue();
				String description;

				if (roles.contains("ROLE_ADMIN")) {
					description = "Admin successfully authenticated via login form.";
					adminActivityLogService.log(userId, "LOGIN", "users", userId, description);
					response.sendRedirect(request.getContextPath() + "/admindashboard");
				} else {
					description = "User '" + loggedInUser.getName() + "' successfully logged in.";
					adminActivityLogService.log(userId, "LOGIN", "users", userId, description);
					response.sendRedirect(request.getContextPath() + "/home");
				}
			} else {
				response.sendRedirect(request.getContextPath() + "/login?error=true");
			}
		};
	}

}