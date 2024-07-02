package com.example.demo.show;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class ShowDAO {
	private DBOpen dbopen = null;
    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private StringBuilder sql = null;

    public ShowDAO(){ // DAO 생성시에 DB도 함께 연결
        dbopen = new DBOpen();
    }
    
    // XML에서 태그 값을 가져오는 메소드
    public String getTagValue(String tag, Document doc) {
        NodeList nodeList = doc.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent();
            }
        }
        return "";
    }

    public int create(Map<String, Object> map) {
        int cnt = 0;
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();
            
            sql.append(" insert into tb_show(show_id, title, hall_id, genre, start_day, end_day, runningtime, viewing_age, detail_img, poster) ");
            sql.append(" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, (String) map.get("show_id"));
            pstmt.setString(2, (String) map.get("title"));
            pstmt.setString(3, (String) map.get("hall_id"));
            pstmt.setString(4, (String) map.get("genre"));
            pstmt.setString(5, (String) map.get("start_day"));
            pstmt.setString(6, (String) map.get("end_day"));
            pstmt.setString(7, (String) map.get("runningtime"));
            pstmt.setString(8, (String) map.get("viewing_age"));
            pstmt.setString(9, (String) map.get("detail_img"));
            pstmt.setString(10, (String) map.get("poster"));
            
            cnt = pstmt.executeUpdate();

        } catch (Exception e) {
            System.out.println("공연 정보 추가 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt);
        }
        
        return cnt;
    }
    
    // show_id가 DB에 존재하는지 확인. 1이면 존재, 0이면 없음
    public boolean showIdExists(String showId) {
        boolean exists = false;
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();

            sql.append(" SELECT COUNT(*) FROM tb_show WHERE show_id = ? ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, showId);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            System.out.println("공연 ID 확인 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }

        return exists;
    }
}
