package com.example.demo.hall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@Repository
public class HallOrderDAO {

	public HallOrderDAO() {
	}
	 private static final Logger logger = LoggerFactory.getLogger(HallOrderDAO.class);
	
	 @Autowired
	SqlSession sqlSession;
	
	public void insertOrder(HallOrderDTO hallOrderDto) {
        sqlSession.insert("hall.insertOrder", hallOrderDto);
    }

    public List<HallOrderDTO> getLatestOrder() {
        return sqlSession.selectList("hall.getLatestOrder");
    }
    
    public List<HallOrderDTO> getLatestOrderCart() {
        return sqlSession.selectList("hall.getLatestOrderCart");
    }
    
    public List<HallOrderDTO> gethallIdOrder() {  //판매자에게 승인요청 보낼 판매자 user_id가져오기위한 조인
        return sqlSession.selectList("hall.gethallIdOrder");
    }
    
    public int updatePayStatus(String hallOrderId, String payStatus) {
        Map<String, String> params = new HashMap<>();
        params.put("hallOrderId", hallOrderId);
        params.put("payStatus", payStatus);
        return sqlSession.update("hall.updatePayStatus", params);
    }


    public List<HallOrderDTO> getPendingOrdersBySellerId(String sellerId){
        return sqlSession.selectList("hall.getPendingOrdersBySellerId", sellerId);
    }
    
    public int hallOrderDel(String hallOrderId) {
    	return sqlSession.update("hall.hallOrderDel", hallOrderId);
    }
    
    public int hallDeleteOrder(String hallOrderId) {
    	return sqlSession.delete("hall.hallDeleteOrder", hallOrderId);
    }
    
       
    public int getCartCount(String userId) {
        return sqlSession.selectOne("hall.countHallOrder", userId);
    }
    
    public int updateOrderStatus(String hallOrderId, String payDate, String payStatus) {
        Map<String, Object> params = new HashMap<>();
        params.put("hallOrderId", hallOrderId);
        params.put("pay_date", payDate);
        params.put("pay_status", payStatus);

        return sqlSession.update("hall.updateOrderStatus", params);
    }
    
    
}// End hallDAO
