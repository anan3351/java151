package com.example.demo.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
    private SqlSession sqlSession;

    public String getUserAuth(String userId) {
        return sqlSession.selectOne("notice.getUserAuth", userId);
    }
}
