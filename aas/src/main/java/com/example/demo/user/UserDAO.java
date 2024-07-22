package com.example.demo.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

	// 회원정보수정을 위해 가져오는 것들
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
			// 네이버 ID로 사용자 찾기
			UserDTO existingUser = findByNaverId(userDTO.getUser_id());
			if (existingUser == null) {
				insertNaverUser(userDTO);
				return findByNaverId(userDTO.getUser_id());
			} else {
				updateNaverUser(userDTO);
				return findByNaverId(userDTO.getUser_id());
			}
		} catch (Exception e) {
			System.err.println("Error in saveOrUpdateNaverUser: " + e.getMessage());
			e.printStackTrace();
			throw new RuntimeException("Failed to save or update user: " + e.getMessage(), e);
		}
	}

	public UserDTO findByNaverId(String naverId) {
		UserDTO user = sqlSession.selectOne("user.findByNaverId", naverId);
		return user;
	}

	private void insertNaverUser(UserDTO userDTO) {
		try {
			int result = sqlSession.insert("user.insertNaverUser", userDTO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	private void updateNaverUser(UserDTO userDTO) {
		try {
			int result = sqlSession.update("user.updateNaverUser", userDTO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public boolean isUserIdExists(String userId) {
		Integer count = sqlSession.selectOne("user.countByUserId", userId);
		return count != null && count > 0;
	}

	public void insertKakaoUser(UserDTO user) {
		sqlSession.insert("user.insertKakaoUser", user);
	}

	public UserDTO getUserByUserId(String userId) {
		return sqlSession.selectOne("user.getUserByUserId", userId);
	}

	public List<Map<String, Object>> sellerHallInsert(String hall_id) {
		return sqlSession.selectList("user.hallList", hall_id);
	}// sellerHallInsert() end

	public List<Map<String, Object>> getSubHalls(String hall_id) {
		return sqlSession.selectList("user.getSubHalls", hall_id);
	}

	public List<Map<String, Object>> getSubHallsWithPrices(String hall_id) {
		return sqlSession.selectList("user.getSubHallsWithPrices", hall_id);
	}

	public void saveHallPrices(Map<String, String> prices, boolean isUpdate) {
		prices.forEach((hallId, price) -> {
			if (!price.isEmpty()) {
				if (isUpdate) {
					sqlSession.update("user.updateHallPrice",
							Map.of("hall_id", hallId, "h_day", Integer.parseInt(price)));
				} else {
					sqlSession.insert("user.insertHallPrice",
							Map.of("hall_id", hallId, "h_day", Integer.parseInt(price)));
				}
			}
		});
	}

	public void insertHallPrice(Map<String, Object> map) {
		sqlSession.insert("user.insertHallPrice", map);
		 sqlSession.update("user.updateHallUser", map);
	}

	public boolean hallPriceExists(String hall_id) {
		int count = sqlSession.selectOne("user.checkHallPriceExists", hall_id);
		return count > 0;
	}

	public void updateHallPrice(Map<String, Object> params) {
		sqlSession.update("user.updateHallPrice", params);
	}

	
	public void saveHallPricesAndUpdateUser(List<Map<String, String>> halls, String userId) {
		 for (Map<String, String> hall : halls) {
			 String hallId = hall.get("hall_id");
		        String hDay = hall.get("h_day");
	        
	        
	        Map<String, Object> params = new HashMap<>();
	        params.put("hall_id", hallId);
	        params.put("h_day", Integer.parseInt(hDay));
	        params.put("user_id", userId);

	        sqlSession.insert("user.insertHallPrice", params);
	        sqlSession.update("user.updateHallUser", params);
	    }
	}

}// class end

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
            // 네이버 ID로 사용자 찾기
            UserDTO existingUser = findByNaverId(userDTO.getUser_id());
            if (existingUser == null) {
                insertNaverUser(userDTO);
                return findByNaverId(userDTO.getUser_id());
            } else {
                updateNaverUser(userDTO);
                return findByNaverId(userDTO.getUser_id());
            }
        } catch (Exception e) {
            System.err.println("Error in saveOrUpdateNaverUser: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to save or update user: " + e.getMessage(), e);
        }
    }

    public UserDTO findByNaverId(String naverId) {
        UserDTO user = sqlSession.selectOne("user.findByNaverId", naverId);
        return user;
    }

    private void insertNaverUser(UserDTO userDTO) {
        try {
            int result = sqlSession.insert("user.insertNaverUser", userDTO);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    private void updateNaverUser(UserDTO userDTO) {
        try {
            int result = sqlSession.update("user.updateNaverUser", userDTO);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public boolean isUserIdExists(String userId) {
        Integer count = sqlSession.selectOne("user.countByUserId", userId);
        return count != null && count > 0;
    }
    
    public void insertKakaoUser(UserDTO user) {
        sqlSession.insert("user.insertKakaoUser", user);
    }

    public UserDTO getUserByUserId(String userId) {
        return sqlSession.selectOne("user.getUserByUserId", userId);
    }
    
    public String getUserAuth(String userId) {
    	String sql = "SELECT auth FROM tb_user WHERE user_id = '" + userId + "'";
        System.out.println("Executing SQL: " + sql);
        return sqlSession.selectOne("User.getUserAuth", userId);
    }
    

    public String findUserId(String user_name, String email) {
        Map<String, String> params = new HashMap<>();
        params.put("user_name", user_name);
        params.put("email", email);
        return sqlSession.selectOne("user.findUserId", params);
    }
    
    public UserDTO findUserByIdNameEmail(String userId, String userName, String email) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("userName", userName);
        params.put("email", email);
        return sqlSession.selectOne("user.findUserByIdNameEmail", params);
    }


}//class end


