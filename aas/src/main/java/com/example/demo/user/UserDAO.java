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
    
    public int deleteUser(String user_id) {
        if (user_id == null || user_id.trim().isEmpty()) {
            System.err.println("user_id is null or empty");
            return 0;
        }
        try {
            int result = sqlSession.delete("user.deleteUser", user_id);
            return result;
        } catch (Exception e) {
            System.err.println("DAO에서 사용자 삭제 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    

    
    
    public UserDTO findByUserId(String userId) {
        try {
            System.out.println("Searching for user with ID: " + userId);
            UserDTO user = sqlSession.selectOne("user.findByUserId", userId);
            System.out.println("Found user: " + user);
            return user;
        } catch (Exception e) {
            System.err.println("Error in findByUserId: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public UserDTO saveOrUpdateNaverUser(UserDTO userDTO) {
        try {
            System.out.println("Attempting to save or update user: " + userDTO);
            UserDTO existingUser = findByUserId(userDTO.getUser_id());
            if (existingUser == null) {
                System.out.println("User not found. Inserting new user.");
                insertNaverUser(userDTO);
            } else {
                System.out.println("User found. Updating existing user.");
                updateNaverUser(userDTO);
            }
            UserDTO result = findByUserId(userDTO.getUser_id());
            System.out.println("Save or update completed. Result: " + result);
            return result;
        } catch (Exception e) {
            System.err.println("Error in saveOrUpdateNaverUser: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to save or update user: " + e.getMessage(), e);
        }
    }

    private void insertNaverUser(UserDTO userDTO) {
        try {
            System.out.println("Inserting Naver user: " + userDTO);
            int result = sqlSession.insert("user.insertNaverUser", userDTO);
            System.out.println("Insert result: " + result);
        } catch (Exception e) {
            System.err.println("Error inserting Naver user: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void updateNaverUser(UserDTO userDTO) {
        try {
            System.out.println("Updating Naver user: " + userDTO);
            int result = sqlSession.update("user.updateNaverUser", userDTO);
            System.out.println("Update result: " + result);
        } catch (Exception e) {
            System.err.println("Error updating Naver user: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    public boolean isUserIdExists(String userId) {
        Integer count = sqlSession.selectOne("user.countByUserId", userId);
        return count != null && count > 0;
    }
    
    
}//class end

