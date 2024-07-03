package com.example.demo.user;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

    public UserDAO() {
        System.out.println("------------UserDAO()객체생성됨");
    }//UserDAO() end

    @Autowired
    SqlSession sqlSession;

    public void insert(UserDTO userDto) throws Exception {
        // Insert 전에 중복 체크
        if (isUserIdDuplicate(userDto.getUser_id())) {
            throw new Exception("이미 존재하는 사용자 ID입니다.");
        }
        
        if (isEmailDuplicate(userDto.getEmail())) {
            throw new Exception("이미 존재하는 이메일입니다.");
        }
        
        sqlSession.insert("user.insert", userDto);
    }//insert() end

    // ID 중복 확인 메서드
    public boolean isUserIdDuplicate(String userId) {
        try {
            int count = sqlSession.selectOne("user.isUserIdDuplicate", userId);
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    //이메일 중복 확인 메서드
    public boolean isEmailDuplicate(String email) {
        try {
            int count = sqlSession.selectOne("user.isEmailDuplicate", email);
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
}//class end
