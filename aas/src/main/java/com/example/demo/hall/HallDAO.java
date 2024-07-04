package com.example.demo.hall;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class HallDAO {
	public HallDAO() {
		System.out.println("---------HallDAO 객체 생성완료");
	}
	
	@Autowired
	SqlSession sqlSession;
	
	public List<Map<String, Object>> list(){
        return sqlSession.selectList("hall.list");
    }//list() end
	
}// End hallDAO
