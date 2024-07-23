package com.example.demo;

import java.util.Properties;
import javax.sql.DataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import com.example.demo.acsch.InterparkCrawler;
import com.example.demo.acsch.TicketLinkCrawler;

@SpringBootApplication
public class AasApplication {
   public static void main(String[] args) {
      SpringApplication.run(AasApplication.class, args);
   }

   // MyBatis Framework 관련 환경 설정 // Mapper 객체 생성
   @Bean
   public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
       SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
       sessionFactory.setDataSource(dataSource);
       
       Resource[] res = new PathMatchingResourcePatternResolver().getResources("classpath:mappers/*.xml");
       sessionFactory.setMapperLocations(res);
       
       return sessionFactory.getObject();
   }
   
   @Bean
   public SqlSessionTemplate sqlSession(SqlSessionFactory factory) {
      return new SqlSessionTemplate(factory);
   }

   @Bean
   public JavaMailSender javaMailSender() {
       JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
       mailSender.setHost("smtp.gmail.com");
       mailSender.setPort(587);
       mailSender.setUsername("your-email@gmail.com");
       mailSender.setPassword("your-app-password");
       Properties props = mailSender.getJavaMailProperties();
       props.put("mail.transport.protocol", "smtp");
       props.put("mail.smtp.auth", "true");
       props.put("mail.smtp.starttls.enable", "true");
       props.put("mail.debug", "true");
       return mailSender;
   }
  
   /* 인터파크 배우데이터 크롤링
   @Bean
   public CommandLineRunner run(InterparkCrawler interparkCrawler) {
       return args -> {
           interparkCrawler.crawl();
       };
   }
    */
   /* YES24 배우데이터 크롤링
   @Bean
   public CommandLineRunner run(TicketLinkCrawler ticketLinkCrawler) {
       return args -> {
           ticketLinkCrawler.crawl();
       };
       */
   }
