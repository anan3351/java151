package com.example.demo.coupon;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public class CouponDAO {

	@Autowired
	SqlSession sqlsession;
	
	// 공연장 상세정보 목록 리스트 뽑기
		//public List<Map<String, Object>> couponList(@Param("userId") String user_id) {
		//	return sqlsession.selectList("coupon.list", user_id);
	//	}// couponList end
		
		@Autowired
	    public CouponDAO(SqlSession sqlSession) {
	        this.sqlsession = sqlSession;
	    }
		
		public List<CouponDTO> getCouponsByUserId(String user_id) {
	        return sqlsession.selectList("coupon.list", user_id);
	    }
		
}
