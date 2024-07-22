package com.example.demo.orderdetail;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDetailDAO {

    @Autowired
    private SqlSession sqlSession;

    // user_id 기준으로 예매내역 조회
    public List<OrderDetailDTO> getOrderDetailsByUserId(String user_id) {
        return sqlSession.selectList("orderdetail.getOrderDetailsByUserId", user_id);
    }

    // order_id 기준으로 특정 예매내역 조회
    public OrderDetailDTO getOrderDetailById(int order_id) {
        return sqlSession.selectOne("orderdetail.getOrderDetailById", order_id);
    }
}
