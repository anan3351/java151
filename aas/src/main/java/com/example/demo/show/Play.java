package com.example.demo.show;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class Play {
	
	// XML에서 태그 값을 가져오는 메소드
    private static String getTagValue(String tag, Document doc) {
        NodeList nodeList = doc.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent();
            }
        }
        return "";
    }
	
    private DBOpen dbopen = null;
    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private StringBuilder sql = null;

    public Play(){ // DAO 생성시에 DB도 함께 연결
        dbopen = new DBOpen();
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

    
    
    public static void main(String[] args) throws IOException {
    	
    	Play play = new Play(); // Play 클래스의 인스턴스 생성
        
        String defaultUrl = "http://www.kopis.or.kr/openApi/restful/pblprfr";
        String serviceKey = "f4acc9d51cc74c92871887e4f695cc85";
        String stdate = "20240101";
        String eddate = "20240630";
        String shcate = "AAAA"; // 연극 : AAAA, 뮤지컬 : GGGA
        String rows = "50";
        int cpage = 1;

        boolean hasMoreData = true;
        
        while (hasMoreData) {
            // 2005~2024 연극 전체 조회
            String listUrl = defaultUrl + "?service=" + serviceKey + "&stdate=" + stdate + "&eddate=" + eddate + "&shcate=" + shcate + "&rows=" + rows + "&cpage=" + cpage;

            // url 객체 생성, 연결
            URL url = new URL(listUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/xml");


            // 연결 성공이라면 코드 200~300 반환
            System.out.println("Response code for page " + cpage + ": " + conn.getResponseCode());

            BufferedReader rd;
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }


            // XML 데이터 response에 저장
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                response.append(line);
            }
            rd.close();
            conn.disconnect();

            // XML 데이터 파싱 -> Document로 저장
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder;
            Document doc = null;

            try {
                builder = factory.newDocumentBuilder();
                doc = builder.parse(new java.io.ByteArrayInputStream(response.toString().getBytes()));
            } catch (Exception e) {
                e.printStackTrace();
            }


            // 공연ID(mt20id)만 추출 후 리스트에 저장
            List<String> mt20idList = new ArrayList<>();
            NodeList nodeList = doc.getElementsByTagName("mt20id");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) node;
                    mt20idList.add(element.getTextContent());
                }
            }

            // 만약 mt20idList가 비어 있다면 루프 종료
            if (mt20idList.isEmpty()) {
                hasMoreData = false;
                break;
            }

            // 공연ID를 이용해 공연 세부 정보 조회
            for (String mt20id : mt20idList) {
                String detailUrl = defaultUrl + "/" + mt20id + "?service=" + serviceKey;
                URL detailApiUrl = new URL(detailUrl);
                HttpURLConnection detailConn = (HttpURLConnection) detailApiUrl.openConnection();

                detailConn.setRequestMethod("GET");
                detailConn.setRequestProperty("Content-type", "application/xml");


                // 연결 성공 200~300
                System.out.println("Response code for " + mt20id + " : " + detailConn.getResponseCode());

                BufferedReader detailReader;
                if (detailConn.getResponseCode() >= 200 && detailConn.getResponseCode() <= 300) {
                    detailReader = new BufferedReader(new InputStreamReader(detailConn.getInputStream(), "UTF-8"));
                } else {
                    detailReader = new BufferedReader(new InputStreamReader(detailConn.getErrorStream()));
                }


                // 공연 세부 정보 detailSb에 저장
                StringBuilder detailSb = new StringBuilder();
                String detailLine;
                while ((detailLine = detailReader.readLine()) != null) {
                    detailSb.append(detailLine);
                }
                detailReader.close();
                detailConn.disconnect();


                // XML 데이터 파싱
                Document detailDoc = null;
                try {
                    builder = factory.newDocumentBuilder();
                    detailDoc = builder.parse(new java.io.ByteArrayInputStream(detailSb.toString().getBytes()));
                } catch (Exception e) {
                    e.printStackTrace();
                }


                // JSON 객체 생성
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("show_id", getTagValue("mt20id", detailDoc));
                jsonObject.put("title", getTagValue("prfnm", detailDoc));
                jsonObject.put("hall_id", getTagValue("mt10id", detailDoc));
                jsonObject.put("genre", getTagValue("genrenm", detailDoc));
                jsonObject.put("start_day", getTagValue("prfpdfrom", detailDoc));
                jsonObject.put("end_day", getTagValue("prfpdto", detailDoc));
                jsonObject.put("runningtime", getTagValue("prfruntime", detailDoc));
                jsonObject.put("viewing_age", getTagValue("prfage", detailDoc));
                jsonObject.put("detail_img", getTagValue("styurl", detailDoc));
                jsonObject.put("poster", getTagValue("poster", detailDoc));

                // JSON 데이터 확인
                // System.out.println(jsonObject.toString(2));
                // System.out.println();
                
                
             	// Map에 삽입
                Map<String, Object> map = new HashMap<>();
                map.put("show_id", jsonObject.getString("show_id"));
                map.put("title", jsonObject.getString("title"));
                map.put("hall_id", jsonObject.getString("hall_id"));
                map.put("genre", jsonObject.getString("genre"));
                map.put("start_day", jsonObject.getString("start_day"));
                map.put("end_day", jsonObject.getString("end_day"));
                map.put("runningtime", jsonObject.getString("runningtime"));
                map.put("viewing_age", jsonObject.getString("viewing_age"));
                map.put("detail_img", jsonObject.getString("detail_img"));
                map.put("poster", jsonObject.getString("poster"));

                // DB에 저장
                int result = play.create(map);
                if(result == 1) {
                	System.out.println(mt20id + " 행 추가 성공");
                }
            }

            // 다음 페이지로 이동
            cpage++;
        }
    }
}
