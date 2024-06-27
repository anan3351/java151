package com.example.demo.actor;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ActorDAO {
	public ActorDAO() {
		System.out.println("-----ActorDAO객체생성");
	}
	
	@Autowired
	SqlSession sqlSession;
	
	
	public List<ActorDTO> list() {
	    return sqlSession.selectList("actor.list");
	}//getAllActors end
		



}//class end
