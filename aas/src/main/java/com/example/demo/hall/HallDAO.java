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
import org.springframework.stereotype.Repository;

@Repository
public class HallDAO {

	private Connection conn;

	public HallDAO() throws ClassNotFoundException, SQLException {
		System.out.println("---------HallDAO 객체 생성완료");
		conn = DBConn.getConnection();
	}

	@Autowired
	SqlSession sqlSession;

	public List<Map<String, Object>> list() {
		return sqlSession.selectList("hall.list");
	}// list() end

	// 공연 코드 임시 테이블에 공연 코드만 먼저 추가
	public int addCodeOnly(String playCode) throws SQLException {
		int result = 0;

		String sql = "INSERT INTO AAS.TB_HALL(HALL_ID) VALUES (?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, playCode);

		result = pstmt.executeUpdate();
		pstmt.close();
		// conn.close();

		return result;
	}

	// 공연 코드 다 조회해서 가져오기
	public ArrayList listPlayCode() throws SQLException {
		ArrayList result = new ArrayList();

		String sql = "SELECT HALL_ID FROM AAS.TB_HALL";

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

		String sql = "INSERT INTO aas.TB_HALL(HALL_ID, H_NAME, MINIHALL, ADDR, H_CALL, URL, SEAT) "
				 + " VALUES (?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, hallDto.getHall_id());
		pstmt.setString(2, hallDto.getH_name());
		pstmt.setString(3, hallDto.getMiniHall());
		pstmt.setString(4, hallDto.getAddr());
		pstmt.setString(5, hallDto.getH_call());
		pstmt.setString(6, hallDto.getUrl());
		pstmt.setString(7, hallDto.getSeat());

		result = pstmt.executeUpdate();
		pstmt.close();
		// conn.close();

		return result;

	}

}// End hallDAO
