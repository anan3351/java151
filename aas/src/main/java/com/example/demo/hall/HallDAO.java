package com.example.demo.hall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@Repository
public class HallDAO {
	private Connection conn;

	public HallDAO() throws ClassNotFoundException, SQLException {
		System.out.println("---------HallDAO 객체 생성완료");
		conn = DBConn.getConnection();
	}

	@Autowired
	SqlSession sqlSession;

	// 공연장 상세정보 목록 조회
	public Map<String, Object> detail(String hall_id) {
		return sqlSession.selectOne("hall.detail", hall_id);
	}// detail() end

	 
	// 공연장 상세정보 목록 리스트 뽑기
	public List<Map<String, Object>> hallDetail(String hall_id) {
		return sqlSession.selectList("hall.hallDetail", hall_id);
	}// hallDetail() end
	
	
	// 공연장 상세정보 미니홀목록만 리스트 뽑기
	public List<Map<String, Object>> hallDetailMini(String hall_id) {
		return sqlSession.selectList("hall.hallDetailMini", hall_id);
	}// hallDetail() end
	
	
	
	// 공연 코드 임시 테이블에 공연 코드만 먼저 추가
	public int addCodeOnly(String playCode) throws SQLException {
		int result = 0;

		String sql = "INSERT INTO aas.TB_HALL(HALL_ID) VALUES (?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, playCode);

		result = pstmt.executeUpdate();
		pstmt.close();
		// conn.close();

		return result;
	}

	// 공연 코드 다 조회해서 가져오기

	public ArrayList listPlayCode() throws SQLException {
		ArrayList result = new ArrayList<>();

		String sql = "SELECT HALL_ID FROM aas.TB_HALL";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			String playCd = rs.getString("HALL_ID");
			result.add(playCd);
		}
		pstmt.close();
		return result;
	}

	// 공연 정보 테이블에 데이터 추가
	public int addPlay(HallDTO hallDto) throws SQLException {
		int result = 0;

		String sql = "UPDATE aas.TB_HALL SET HNAME = ?, MINIHALL = ?, ADDR = ?, H_CALL = ?, URL = ?, SEAT = ?, H_CODE = ? "
				+ "WHERE HALL_ID = ?";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, hallDto.getH_name());
		pstmt.setString(2, hallDto.getMiniHall());
		pstmt.setString(3, hallDto.getAddr());
		pstmt.setString(4, hallDto.getH_call());
		pstmt.setString(5, hallDto.getUrl());
		pstmt.setString(6, hallDto.getSeat());
		pstmt.setString(7, hallDto.getH_code());
		pstmt.setString(8, hallDto.getHall_id());

		result = pstmt.executeUpdate();
		pstmt.close();
		// conn.close();

		return result;

	}

	public int addPlay2(HallDTO hallDto) throws SQLException {
		int result = 0;

		String sql = "INSERT INTO aas.TB_HALL(HALL_ID, HNAME, MINIHALL, ADDR, H_CALL, URL, SEAT, H_CODE) "
				+ " VALUES  (?, ?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, hallDto.getHall_id());
		pstmt.setString(2, hallDto.getH_name());
		pstmt.setString(3, hallDto.getPrfplcnm());
		pstmt.setString(4, hallDto.getAddr());
		pstmt.setString(5, hallDto.getH_call());
		pstmt.setString(6, hallDto.getUrl());
		pstmt.setString(7, hallDto.getSeatscale());
		pstmt.setString(8, hallDto.getH_code());

		result = pstmt.executeUpdate();
		pstmt.close();
		// conn.close();

		return result;

	}

	// 태그 값을 읽어올 함수
	public String getTagValue(String tag, Element eElement) {
		Node nValue = null;

		NodeList x = eElement.getElementsByTagName(tag);
		Node test = x.item(0);
		NodeList t = null;
		if (test != null) {
			t = test.getChildNodes();
			if ((Node) t.item(0) != null) {
				nValue = (Node) t.item(0);
			}
		}
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}

	
	
}// End hallDAO
