package com.example.demo.actor;

import java.util.List;
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
}