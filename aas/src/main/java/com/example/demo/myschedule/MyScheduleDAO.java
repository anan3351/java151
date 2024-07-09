package com.example.demo.myschedule;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyScheduleDAO {

	public MyScheduleDAO() {
		System.out.println("-----MyScheduleDAO 객체 생성");
	}
	
	@Autowired
	private SqlSession sqlSession;
	
    public List<MyScheduleDTO> getAllSchedules(String user_id) {
        return sqlSession.selectList("myschedule.getAllSchedules");
    }
	
}//class end
