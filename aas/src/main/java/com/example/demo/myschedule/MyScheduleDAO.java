package com.example.demo.myschedule;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.orderdetail.OrderDetailDTO;

@Repository
public class MyScheduleDAO {

    // Constructor
    public MyScheduleDAO() {
        System.out.println("-----MyScheduleDAO 객체 생성");
    }

    @Autowired
    private SqlSession sqlSession;

    // 사용자 ID에 따른 전체 스케줄 조회
    public List<MyScheduleDTO> getAllSchedules(String user_id) {
        return sqlSession.selectList("myschedule.getAllSchedules", user_id);
    }

    // 새로운 스케줄 저장
    public void saveSchedule(MyScheduleDTO schedule) {
        sqlSession.insert("myschedule.saveSchedule", schedule);
    }

    // 스케줄 ID에 따른 스케줄 조회
    public MyScheduleDTO getScheduleById(int mysch_id) {
        return sqlSession.selectOne("myschedule.getScheduleById", mysch_id);
    }

    // 스케줄 업데이트
    public void updateSchedule(MyScheduleDTO schedule) {
        sqlSession.update("myschedule.updateSchedule", schedule);
    }

    // 스케줄 삭제
    public void deleteSchedule(int mysch_id) {
        sqlSession.delete("myschedule.deleteSchedule", mysch_id);
    }
    
    // 사용자 예매내역 조회
    public List<OrderDetailDTO> getOrderDetailsByUserId(String user_id) {
        return sqlSession.selectList("myschedule.getOrderDetailsByUserId", user_id);
    }

    // 특정 예매내역 조회
    public OrderDetailDTO getOrderDetailById(int order_id) {
        return sqlSession.selectOne("myschedule.getOrderDetailById", order_id);
    }
}
