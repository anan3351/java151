package com.example.demo.like;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LikeDAO {

	@Autowired
	private SqlSession sqlSession;
		
		public LikeDAO() {
			System.out.println("-----LikeDAO 객체 생성");
		}
	
    public void insertLike(String user_Id, int rev_Id) {
        Map<String, Object> params = new HashMap<>();
        params.put("user_Id", user_Id);
        params.put("rev_Id", rev_Id);
        sqlSession.insert("like.insertLike", params);
    }

    public boolean checkIfLiked(String user_Id, int rev_Id) {
        Map<String, Object> params = new HashMap<>();
        params.put("user_Id", user_Id);
        params.put("rev_Id", rev_Id);
        Integer count = sqlSession.selectOne("like.checkIfLiked", params);
        return count != null && count > 0;
    }	
	
	
}//class end
