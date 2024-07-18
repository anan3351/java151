package com.example.demo.qna;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class QnaDAO {

	@Autowired
    private SqlSession sqlSession;

    public String getUserAuth(String userId) {
        return sqlSession.selectOne("notice.getUserAuth", userId);
    }
}
