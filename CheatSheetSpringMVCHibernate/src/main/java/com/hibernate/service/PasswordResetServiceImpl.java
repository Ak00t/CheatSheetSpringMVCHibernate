package com.hibernate.service;

import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hibernate.entity.UserEntity;
import com.hibernate.repository.UserLoginRegisterRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PasswordResetServiceImpl implements PasswordResetService {

	private final UserLoginRegisterRepository userRepo;
	private final JavaMailSender mailSender;

	@Override
	public String generateResetToken(String email) throws Exception {
		UserEntity user = userRepo.findByEmail(email);
		if (user == null) {
			throw new Exception("No account registered with this email address.");
		}

		String token = UUID.randomUUID().toString();
		user.setResetPasswordToken(token);
		user.setResetPasswordExpiresAt(LocalDateTime.now().plusMinutes(15));
		userRepo.updateUser(user);

		return token;
	}

	@Override
	public void sendResetEmail(String email, String link) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("maungagkyawthu@gmail.com");
		message.setTo(email);
		message.setSubject("Password Reset Request Link");

		String content = "Hello,\n\n" + "You requested to reset your password. Click the link below to proceed:\n"
				+ link + "\n\n" + "Note: This link will expire in 15 minutes.";

		message.setText(content);
		mailSender.send(message);
	}

	@Override
	public void updatePassword(String token, String newPassword) throws Exception {
		UserEntity user = userRepo.findByResetPasswordToken(token);

		if (user == null || user.getResetPasswordExpiresAt().isBefore(LocalDateTime.now())) {
			throw new Exception("Invalid or expired password reset token.");
		}

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		user.setPassword(encoder.encode(newPassword));

		user.setResetPasswordToken(null);
		user.setResetPasswordExpiresAt(null);
		userRepo.updateUser(user);
	}

}
