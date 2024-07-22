package com.example.demo.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
    private static final Logger logger = LoggerFactory.getLogger(MailService.class);

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    public void sendSimpleMail(String to, String subject, String body) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(from);  // 발신자 이메일 설정
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            
            logger.info("Attempting to send email from: {} to: {}", from, to);
            mailSender.send(message);
            logger.info("메일 전송 성공: {}", to);
        } catch (MailException e) {
            logger.error("메일 전송 실패: {}", e.getMessage(), e);
            throw new RuntimeException("메일 전송 중 오류 발생", e);
        }
    }
}
