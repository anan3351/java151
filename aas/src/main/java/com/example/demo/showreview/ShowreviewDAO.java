package com.example.demo.showreview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShowreviewDAO {

	public ShowreviewDAO() {
		System.out.println("-----ShowreviewDAO 객체 생성");
	}
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insert(ShowreviewDTO showreviewDto) {
		sqlSession.insert("showreview.insert", showreviewDto);
	}
	
    public int totalRowCount() {
        return sqlSession.selectOne("showreview.totalRowCount");
    }
    
    public List<ShowreviewDTO> list(int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return sqlSession.selectList("showreview.list", params);
    }
    
    //추가
    public ShowreviewDTO getReviewById(int rev_Id) {
        return sqlSession.selectOne("showreview.getReviewById", rev_Id);
    }

    public void incrementEmpcnt(int rev_Id) {
        sqlSession.update("showreview.incrementEmpcnt", rev_Id);
    }
	
}//class end
