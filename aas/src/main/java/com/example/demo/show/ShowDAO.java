package com.example.demo.show;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShowDAO {
	@Autowired
	SqlSession sqlSession;
	
	public void show_insert(Map<String, Object> map) {
		sqlSession.insert("show.show_insert", map);
	}
}
