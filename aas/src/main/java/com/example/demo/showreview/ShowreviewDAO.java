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
    //기존 LIST
    public List<Map<String, Object>> list(int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return sqlSession.selectList("showreview.list", params);
    }
    //리스트 시도
    // ShowreviewDTO를 사용하는 새로운 list1 메서드
    public List<ShowreviewDTO> list1(int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return sqlSession.selectList("showreview.list1", params);
    }

    // 개별 리뷰 조회 메서드
    public ShowreviewDTO getReviewById(int rev_id) {
        ShowreviewDTO review = sqlSession.selectOne("showreview.getReviewById", rev_id);
        if (review != null) {
            incrementViewCount(rev_id);
        }
        return review;
    }
    
    
    //추가
    //public ShowreviewDTO getReviewById(int rev_Id) {
    //    return sqlSession.selectOne("showreview.getReviewById", rev_Id);
    //}

    public void incrementEmpcnt(int rev_Id) {
        sqlSession.update("showreview.incrementEmpcnt", rev_Id);
    }
	
    public void incrementViewCount(int rev_Id) {
        sqlSession.update("showreview.incrementViewCount", rev_Id);
    }
    
    public void update(ShowreviewDTO showreviewDto) {
        sqlSession.update("showreview.update", showreviewDto);
    }

    public void delete(int rev_id) {
        sqlSession.delete("showreview.delete", rev_id);
    }
    
}//class end
