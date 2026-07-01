package com.hibernate.service;

public interface PasswordResetService {

	public String generateResetToken(String email) throws Exception;

	public void sendResetEmail(String email, String link);

	public void updatePassword(String token, String newPassword) throws Exception;
}
