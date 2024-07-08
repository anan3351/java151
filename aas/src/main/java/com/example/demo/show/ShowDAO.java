package com.example.demo.show;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.w3c.dom.*;

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
    
    public String getTagValue2(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent();
            }
        }
        return "";
    }

    
    // 공연 정보 insert
    public int create(Map<String, Object> map) {
        int cnt = 0;
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();
            
            sql.append(" insert into tb_show(show_id, title, hall_id, genre, cast, start_day, end_day, runningtime, viewing_age, detail_img, poster) ");
            sql.append(" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, (String) map.get("show_id"));
            pstmt.setString(2, (String) map.get("title"));
            pstmt.setString(3, (String) map.get("hall_id"));
            pstmt.setString(4, (String) map.get("genre"));
            pstmt.setString(5, (String) map.get("cast"));
            pstmt.setString(6, (String) map.get("start_day"));
            pstmt.setString(7, (String) map.get("end_day"));
            pstmt.setString(8, (String) map.get("runningtime"));
            pstmt.setString(9, (String) map.get("viewing_age"));
            pstmt.setString(10, (String) map.get("detail_img"));
            pstmt.setString(11, (String) map.get("poster"));
            
            cnt = pstmt.executeUpdate();

        } catch (Exception e) {
            System.out.println("공연 정보 추가 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt);
        }
        
        return cnt;
    }
    
    
    // 공연장 - 관 이름 찾는 필터(hall_id 이용)
    public List<String> theater_search(String theater) {
        List<String> theater_name = new ArrayList<>();
        
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();
            
            sql.append("SELECT h_name, miniHall FROM tb_hall WHERE hall_id = ? ");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, theater);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String h_name = rs.getString("h_name"); // 공연장 이름
                String miniHall = rs.getString("miniHall"); // 세부관 이름
                
                theater_name.add(h_name);
                theater_name.add(miniHall);
            } else {
            	// 공연 상세정보에는 공연장ID가 있으나, 공연장에서 해당 아이디를 찾을 수 없는 경우
                theater_name.add("정보없음");
                theater_name.add("");
            }

        } catch (Exception e) {
            System.out.println("공연장 조회 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }
        
        return theater_name;
    }

    
    
    // 관 ID 조회
    public String mini_search(String mini) {
        String hall_id = null;
        
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();
            
            sql.append("SELECT hall_id FROM tb_hall WHERE miniHall = ? ");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, mini);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
            	hall_id = rs.getString("hall_id");
            }

        } catch (Exception e) {
            System.out.println("세부 공연장 조회 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }
        
        return hall_id;
    }

    
    // hall_id 검색 -> 값이 딱 두개 나온다면 "-"가 붙은걸로 저장
    public String mini_search2(String theater) {
        String hall_id = null;
        int cnt = 0;

        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();

            sql.append("SELECT count(hall_id) as cnt FROM tb_hall WHERE hall_id LIKE ? ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, theater + "%");

            rs = pstmt.executeQuery();

            if (rs.next()) {
                cnt = rs.getInt("cnt");
            }

            if (cnt == 2) {
                // 자원 정리
                rs.close();
                pstmt.close();

                sql = new StringBuilder();
                sql.append("SELECT hall_id FROM tb_hall WHERE hall_id LIKE ? ");

                pstmt = con.prepareStatement(sql.toString());
                pstmt.setString(1, theater + "-%");

                rs = pstmt.executeQuery();

                if (rs.next()) {
                    hall_id = rs.getString("hall_id");
                }
            } else {
                hall_id = null;
            }

        } catch (Exception e) {
            System.out.println("세부 공연장 조회 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }

        return hall_id;
    }


    
    
    // 중복 데이터 필터링
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
    
    
    
    // 인터파크 크롤링 메소드
    public Map<String, String> interpart_data(String link){
    	Map<String, String> sectionImages = new HashMap<>();
    	return null;
    }
    
    // 예스24 크롤링 메소드
    public List<String> yes24_data(String link){
    	return null;
    }
    
    // 티켓링크 크롤링 메소드
    public List<String> ticketlink_data(String link){
    	return null;
    }
    
    
    
    
}
