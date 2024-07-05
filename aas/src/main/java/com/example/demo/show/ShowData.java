package com.example.demo.show;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class ShowData {
	public static void main(String[] args) {
	    ShowDAO showDao = new ShowDAO();

	    String defaultUrl = "http://www.kopis.or.kr/openApi/restful/pblprfr";
	    String serviceKey = "f4acc9d51cc74c92871887e4f695cc85";
	    String stdate = "20050101";
	    String eddate = "20101231";
	    String shcate = "GGGA"; // 연극 : AAAA, 뮤지컬 : GGGA
	    String rows = "200";
	    int cpage = 1;

	    boolean hasMoreData = true;

	    while (hasMoreData) {
	        // 2005~2024 연극 전체 조회
	        String listUrl = defaultUrl + "?service=" + serviceKey + "&stdate=" + stdate + "&eddate=" + eddate + "&shcate=" + shcate + "&rows=" + rows + "&cpage=" + cpage;

	        try {
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
	            DocumentBuilder builder = factory.newDocumentBuilder();
	            Document doc = builder.parse(new java.io.ByteArrayInputStream(response.toString().getBytes("UTF-8")));

	            
	            // 공연ID(mt20id)만 추출 후 리스트에 저장
	            NodeList nodeList = doc.getElementsByTagName("mt20id");
	            List<String> showList = new ArrayList<>();
	            for (int i = 0; i < nodeList.getLength(); i++) {
	                Element element = (Element) nodeList.item(i);
	                showList.add(element.getTextContent());
	            }

	            // 만약 mt20idList가 비어 있다면 루프 종료
	            if (showList.isEmpty()) {
	                hasMoreData = false;
	                break;
	            }

	            // 공연ID를 이용해 공연 세부 정보 조회
	            for (String mt20id : showList) {
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
	                Document detailDoc = builder.parse(new java.io.ByteArrayInputStream(detailSb.toString().getBytes("UTF-8")));

	                String theater1 = showDao.getTagValue("fcltynm", detailDoc); // 공연장 이름(세부관 포함)
	                String theater2 = showDao.getTagValue("mt10id", detailDoc); // 공연장id
	                List<String> theater_name = showDao.theater_search(theater2); // 공연장(부모) 이름 찾기
	                String mini = null;
	                
	                int n = theater_name.get(0).length();
	                
	                // 세부관 이름 추출
	                if (n < theater1.length()) {
	                	mini = theater1.substring(n).trim();
		                int start = mini.indexOf("(") + 1;
		        	    int end = mini.lastIndexOf(")");
		        	    mini = mini.substring(start, end); // 세부관 이름(miniHall)
		        	    
		        	    mini = showDao.mini_search(mini); // 세부관 ID(hall_id)
		        	    
		        	    if (mini == "" || mini == null) {
		        	    	mini = showDao.mini_search2(theater2); // 세부관 ID(hall_id)
		        	    	if (mini == null) {
		        	    		mini = theater2;
		        	    	}
		        	    }
	                } else { // 길이가 같다면 공연장 이름 반환
	                	mini = showDao.mini_search2(theater2); // 세부관 ID(hall_id)
	                	if (mini == null) {
	        	    		mini = theater2;
	        	    	}
	                }
	                
	                //System.out.println(mini);

	                
	                // JSON 객체 생성
	                JSONObject jsonObject = new JSONObject();
	                jsonObject.put("show_id", showDao.getTagValue("mt20id", detailDoc));
	                jsonObject.put("title", showDao.getTagValue("prfnm", detailDoc));
	                jsonObject.put("hall_id", mini);
	                jsonObject.put("genre", showDao.getTagValue("genrenm", detailDoc));
	                jsonObject.put("cast", showDao.getTagValue("prfcast", detailDoc));
	                jsonObject.put("start_day", showDao.getTagValue("prfpdfrom", detailDoc));
	                jsonObject.put("end_day", showDao.getTagValue("prfpdto", detailDoc));
	                jsonObject.put("runningtime", showDao.getTagValue("prfruntime", detailDoc));
	                jsonObject.put("viewing_age", showDao.getTagValue("prfage", detailDoc));
	                jsonObject.put("detail_img", showDao.getTagValue("styurl", detailDoc));
	                jsonObject.put("poster", showDao.getTagValue("poster", detailDoc));

	                // JSON 데이터 확인
	                //System.out.println(jsonObject.toString(2));
	                //System.out.println();

	                
	                // Map에 삽입
	                Map<String, Object> map = new HashMap<>();
	                map.put("show_id", jsonObject.getString("show_id"));
	                map.put("title", jsonObject.getString("title"));
	                map.put("hall_id", jsonObject.getString("hall_id"));
	                map.put("genre", jsonObject.getString("genre"));
	                map.put("cast", jsonObject.getString("cast"));
	                map.put("start_day", jsonObject.getString("start_day"));
	                map.put("end_day", jsonObject.getString("end_day"));
	                map.put("runningtime", jsonObject.getString("runningtime"));
	                map.put("viewing_age", jsonObject.getString("viewing_age"));
	                map.put("detail_img", jsonObject.getString("detail_img"));
	                map.put("poster", jsonObject.getString("poster"));

	                // DB에 저장
	                if (!showDao.showIdExists(mt20id)) { // DB에 show_id가 존재하지 않는 경우에만 삽입
	                    int result = showDao.create(map);
	                    if (result == 1) {
	                        System.out.println("ID : " + mt20id + ", 행 추가 성공");
	                    }
	                } else {
	                    System.out.println(mt20id + " 이미 존재하는 공연정보");
	                }
	            }

	            // 다음 페이지로 이동
	            cpage++;

	        } catch (Exception e) {
	            e.printStackTrace();
	            break; // 예외 발생 시 루프 종료
	        }
	    }
	}
}