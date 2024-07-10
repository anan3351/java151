package com.example.demo.show.scraping;

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

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.example.demo.show.ShowDAO;

public class CrawlingTest {
    public static void main(String[] args) throws Exception {

        ShowDAO showDao = new ShowDAO();

        String defaultUrl = "http://www.kopis.or.kr/openApi/restful/pblprfr";
        String serviceKey = "f4acc9d51cc74c92871887e4f695cc85";
        String stdate = "20190101";
        String eddate = "20190630";
//        String stdate = "20190701";
//        String eddate = "20191231";
        String shcate = "GGGA"; // 연극 : AAAA, 뮤지컬 : GGGA
        String rows = "50";
        int cpage = 1;

        // 공연별 (모든)예매처 링크를 저장하기 위한 리스트
        List<Map<String, String>> relateList = new ArrayList<>();
        Map<String, String> linkMap = new HashMap<>();
        Map<String, String> contentImagesMap = new HashMap<>();
        boolean hasMoreData = true;

        while (hasMoreData) {
            // 2005~2024 연극 전체 조회
            String listUrl = defaultUrl + "?service=" + serviceKey + "&stdate=" + stdate + "&eddate=" + eddate
                    + "&shcate=" + shcate + "&rows=" + rows + "&cpage=" + cpage;

            // url 객체 생성, 연결
            URL url = new URL(listUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/xml");


            // 연결 성공이라면 코드 200~300 반환
            System.out.println("Response code for page " + cpage + " : " + conn.getResponseCode());

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
            Document doc = builder.parse(new java.io.ByteArrayInputStream(response.toString().getBytes()));


            // db 태그의 내용을 노드리스트에 저장
            NodeList showList = doc.getElementsByTagName("db");
            for (int i = 0; i < showList.getLength(); i++) {
                Node itemNode = showList.item(i);
                if (itemNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element itemElement = (Element) itemNode;
                    // mt20id 태그를 찾아서 저장
                    String mt20id = showDao.getTagValue2("mt20id", itemElement);

                    // mt20id를 이용해 공연 세부 정보 조회
                    String detailUrl = defaultUrl + "/" + mt20id + "?service=" + serviceKey + "&newsql=Y";
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

                    // relates 태그의 모든 relate 태그 정보 추출
                    NodeList relateNodeList = detailDoc.getElementsByTagName("relate");
                    for (int j = 0; j < relateNodeList.getLength(); j++) {
                        Node relateNode = relateNodeList.item(j);
                        if (relateNode.getNodeType() == Node.ELEMENT_NODE) {
                            Element relateElement = (Element) relateNode;
                            String relatenm = showDao.getTagValue2("relatenm", relateElement); // 예매처
                            String relateurl = showDao.getTagValue2("relateurl", relateElement);

                            // mt20id, relatenm, relateurl를 relateMap에 저장 -> relateList에 맵들을 저장
                            Map<String, String> relateMap = new HashMap<>();
                            relateMap.put("mt20id", mt20id); // mt20id 추가
                            relateMap.put("relatenm", relatenm);
                            relateMap.put("relateurl", relateurl);
                            relateList.add(relateMap);
                        }
                    }
                }
            }

            // showList가 비어 있다면 루프 종료
            if (showList.getLength() == 0) {
                hasMoreData = false;
                break;
            }

            cpage++; // 다음 페이지로 이동
        }

        // relates 출력 (테스트)
        /* for (Map<String, String> relateMap : relateList) {
            System.out.println("mt20id : " + relateMap.get("mt20id"));
            System.out.println("relatenm : " + relateMap.get("relatenm"));
            System.out.println("relateurl : " + relateMap.get("relateurl"));
            System.out.println();
        } */



        // 공연코드 기준으로 예매처만 따로 저장 -> 예매처별 스크래핑
        for(int i=0; i<relateList.size(); i++) {
            Map<String, String> linklist = new HashMap<>();

            for (int j = 0; j < relateList.size(); j++) {
                if (relateList.get(i).get("mt20id").equals(relateList.get(j).get("mt20id"))) { // 중복 데이터 발생 -> 같은 아이디, 다른 예매처마다 검사됨
                    linklist.put(relateList.get(j).get("relatenm"), relateList.get(j).get("relateurl")); // 공연ID, 예매처
                }
            }

            // 한 공연코드에 예매처가 둘 이상이라면, 그중 예매처 검색
            String selectedUrl = null;
            if (linklist.size() > 1) {
                for (Map.Entry<String, String> entry : linklist.entrySet()) {
                    String relateurl = entry.getValue();
                    if (relateurl.contains("interpark")) {
                        selectedUrl = relateurl;
                        break;
                    } else if (relateurl.contains("yes24")) {
                        selectedUrl = relateurl;
                        break;
                    } else if (relateurl.contains("ticketlink")) {
                        selectedUrl = relateurl;
                        break;
                    }
                }
                if (selectedUrl == null) {
                    selectedUrl = linklist.values().iterator().next();
                }
            } else {
                selectedUrl = linklist.values().iterator().next();
            }

            linkMap.put(relateList.get(i).get("mt20id"), selectedUrl); // 중복되지 않게 저장
        }


        for (Map.Entry<String, String> entry : linkMap.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();

            if(value.contains("interpark")) {
                contentImagesMap = showDao.interpart_data(value);
                contentImagesMap.put("showID", key);
                showDao.update(contentImagesMap, key, value);

                System.out.println(key + ", " + value);
                for (Map.Entry<String, String> entry1 : contentImagesMap.entrySet()) {
                    System.out.println(entry1.getKey() + " : ");
                    System.out.println(entry1.getValue());
                }
                System.out.println("--------------------------------\n");

            } else if(value.contains("yes24")) {
                contentImagesMap = showDao.yes24_data(value);
                contentImagesMap.put("showID", key);
                showDao.update(contentImagesMap, key, value);

                System.out.println(key + ", " + value);
                for (Map.Entry<String, String> entry1 : contentImagesMap.entrySet()) {
                    System.out.println(entry1.getKey() + " : ");
                    System.out.println(entry1.getValue());
                }
                System.out.println("--------------------------------\n");

            } else if(value.contains("ticketlink")) {
                contentImagesMap = showDao.ticketlink_data(value);
                contentImagesMap.put("showID", key);
                showDao.update(contentImagesMap, key, value);

                System.out.println(key + ", " + value);
                for (Map.Entry<String, String> entry1 : contentImagesMap.entrySet()) {
                    System.out.println(entry1.getKey() + " : ");
                    System.out.println(entry1.getValue());
                }
                System.out.println("--------------------------------\n");

            } else {
                showDao.update(key, value);
                System.out.println(key + ", " + value);
                System.out.println("3사 미포함");
                System.out.println("--------------------------------\n");
            }
        }
    }
}
