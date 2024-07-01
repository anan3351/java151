package com.example.demo.show;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class Play {
    public static void main(String[] args) throws IOException {
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


            // xml 데이터 파싱 -> Document로 저장
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder;
            Document doc = null;

            try {
                builder = factory.newDocumentBuilder();
                doc = builder.parse(url.openStream());
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

            rd.close();
            conn.disconnect();


            // 만약 mt20idList가 비어 있다면 루프 종료
            if (mt20idList.isEmpty()) {
                hasMoreData = false;
                break;
            }

            // 공연ID를 이용해 공연 세부 정보 조회
            for (String mt20id : mt20idList) {
                String playDetailUrl = defaultUrl + "/" + mt20id + "?service=" + serviceKey;
                URL playUrl = new URL(playDetailUrl);
                HttpURLConnection playConn = (HttpURLConnection) playUrl.openConnection();
                playConn.setRequestMethod("GET");
                playConn.setRequestProperty("Content-type", "application/xml");


                // 연결코드 200~300
                System.out.println("Response code for " + mt20id + " : " + playConn.getResponseCode());

                BufferedReader playReader;
                if (playConn.getResponseCode() >= 200 && playConn.getResponseCode() <= 300) {
                    playReader = new BufferedReader(new InputStreamReader(playConn.getInputStream(), "UTF-8"));
                } else {
                    playReader = new BufferedReader(new InputStreamReader(playConn.getErrorStream()));
                }


                // 데이터 읽기
                StringBuilder playSb = new StringBuilder();
                String playLine;
                while ((playLine = playReader.readLine()) != null) {
                    playSb.append(playLine);
                }
                playReader.close();
                playConn.disconnect();

                // 데이터 확인
                // String playResponse = playSb.toString();
                // System.out.println(playResponse);
                // System.out.println();
            }

            // 다음 페이지로 이동
            cpage++;
        }
    }
}