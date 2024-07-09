package com.example.demo.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

    @Autowired
    SqlSession sqlSession;

    public UserDAO() {
        System.out.println("------------UserDAO()객체생성됨");
    }

    public void insert(UserDTO userDto) throws Exception {
        // Insert 전에 중복 체크
        if (isUserIdDuplicate(userDto.getUser_id())) {
            throw new Exception("이미 존재하는 사용자 ID입니다.");
        }

        if (isEmailDuplicate(userDto.getEmail())) {
            throw new Exception("이미 존재하는 이메일입니다.");
        }

        sqlSession.insert("user.insert", userDto);
    }

    public boolean isUserIdDuplicate(String userId) {
        Integer count = sqlSession.selectOne("user.isUserIdDuplicate", userId);
        return count != null && count > 0;
    }

    public boolean isEmailDuplicate(String email) {
        Integer count = sqlSession.selectOne("user.isEmailDuplicate", email);
        return count != null && count > 0;
    }

    public UserDTO login(String user_id, String pwd) {
        UserDTO user = sqlSession.selectOne("user.login", user_id);
        if (user != null && verifyPassword(pwd, user.getPwd())) {
            return user;
        }
        return null; // 로그인 실패
    }

    private boolean verifyPassword(String inputPassword, String storedPassword) {
        return inputPassword != null && inputPassword.equals(storedPassword);
    }

 // 사용자 정보를 가져오는 메서드 추가
    public UserDTO getUserById(String user_id) {
        return sqlSession.selectOne("user.getUserById", user_id);
    }

    

    
    //회원정보수정을 위해 가져오는 것들
    public UserDTO getUserInfo(String user_id) {
        return sqlSession.selectOne("user.getUserInfo", user_id);
    }

    public int updateUserInfo(UserDTO userDto) {
        return sqlSession.update("user.updateUserInfo", userDto);
    }
    
    public void updatePassword(String userId, String newPassword) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        params.put("pwd", newPassword);
        sqlSession.update("user.updatePassword", params);
    }
    

}//class end

