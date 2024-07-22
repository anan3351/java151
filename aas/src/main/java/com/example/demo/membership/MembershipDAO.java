package com.example.demo.membership;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;

@Repository
@Mapper
public class MembershipDAO {

	public MembershipDAO() {
	}

	@Autowired
	SqlSession sqlSession;

	public void insertMembership(String userId, String mbName, Date adminDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("mbName", mbName);
		params.put("adminDate", adminDate);
		sqlSession.insert("membership.insertMembership", params);
	}

	public void insertCouponDetail(String userId, String couponId, int leftCount) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("couponId", couponId);
		params.put("leftCount", leftCount);
		sqlSession.insert("membership.insertCouponDetail", params);
	}

	public void updateUserPoints(String userId, int points) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("points", points);
		sqlSession.update("membership.updateUserPoints", params);
	}
	
	public boolean isAlreadyMember(String userId, String mbName) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("mbName", mbName);
		Integer count = sqlSession.selectOne("membership.isAlreadyMember", params);
	    return count != null && count > 0;
	}
	
	

}
