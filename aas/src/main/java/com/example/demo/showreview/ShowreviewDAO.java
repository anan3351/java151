package com.example.demo.showreview;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ImportRuntimeHints;
import org.springframework.stereotype.Repository;

import com.example.demo.show.DBOpen;
import com.example.demo.show.ShowDTO;



@Repository
public class ShowreviewDAO {
    private DBOpen dbopen = null;
    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private StringBuilder sql = null;

	public ShowreviewDAO() {
		System.out.println("-----ShowreviewDAO 객체 생성");
		 dbopen = new DBOpen();
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
    
    //공연 제목으로 검색하는 메서드 추가
    
    public List<ShowDTO> searchShows(String keyword) {
        List<ShowDTO> shows = new ArrayList<>();
        try {
            Connection con = dbopen.getConnection();
            String sql = "SELECT show_id, title, genre, start_day, end_day FROM tb_show WHERE title LIKE ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ShowDTO show = new ShowDTO();
                show.setShow_id(rs.getString("show_id"));
                show.setTitle(rs.getString("title"));
                show.setGenre(rs.getString("genre"));
                show.setStart_day(rs.getString("start_day"));
                show.setEnd_day(rs.getString("end_day"));
                shows.add(show);
            }
            DBClose.close(con, pstmt, rs);
        } catch (Exception e) {
            System.out.println("공연 검색 실패: " + e.getMessage());
        }
        return shows;
    }
    
    
}//class end
