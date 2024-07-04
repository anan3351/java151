package com.example.demo.actor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ActorDAO {
    public ActorDAO() {
        System.out.println("-----ActorDAO 객체 생성");
    }

    @Autowired
    private SqlSession sqlSession;

    public List<ActorDTO> list() {
        return sqlSession.selectList("actor.list");
    }
    /*
    public List<ActorDTO> list2(int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return sqlSession.selectList("actor.list2", params);
    }
*/
    public List<ActorDTO> list2(int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return sqlSession.selectList("actor.list2", params);
    }
        
        
    public int totalRowCount() {
        return sqlSession.selectOne("actor.totalRowCount");
    }

}//class end