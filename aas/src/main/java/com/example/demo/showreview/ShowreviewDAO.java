package com.example.demo.showreview;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShowreviewDAO {

	public ShowreviewDAO() {
		System.out.println("-----ShowreviewDAO 객체 생성");
	}
	
	@Autowired
	private SqlSession sqlSession;
	
	
	
	
}//class end
