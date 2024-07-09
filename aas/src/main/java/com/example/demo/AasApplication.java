package com.example.demo;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.example.demo.actor.PlayDbCrawler;

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
	} // sqlSessionFactory() end
	
	@Bean
	public SqlSessionTemplate sqlSession(SqlSessionFactory factory) { // SqlSessionTemplate : MyBatis 쿼리문을 수행. 내부에 있는 SqlSessionFactory를 이용하여 SqlSession을 관리
		return new SqlSessionTemplate(factory);
	} // sqlSession() end

	/* 크롤링할때 주석풀기
	@Bean
	public CommandLineRunner run() {
	    return args -> {
	        PlayDbCrawler.main(new String[]{});
	    };
	} 
	*/

}