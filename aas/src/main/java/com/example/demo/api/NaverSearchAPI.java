package com.example.demo.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class NaverSearchAPI {

    private static final String CLIENT_ID = "9dTgNr7dfHhPYMG6tq3Z"; // 네이버 개발자 센터에서 발급받은 Client ID
    private static final String CLIENT_SECRET = "cadsujaQ1i"; // 네이버 개발자 센터에서 발급받은 Client Secret

    public String search(String query) {
        try {
            String text = URLEncoder.encode(query, "UTF-8"); // 검색어 URL 인코딩
            String apiURL = "https://openapi.naver.com/v1/search/encyc?query=" + text;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", "9dTgNr7dfHhPYMG6tq3Z");
            con.setRequestProperty("X-Naver-Client-Secret", "cadsujaQ1i");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            // 응답 출력하여 확인
            String responseString = response.toString();
            //System.out.println("API 응답: " + responseString);

            // JSON 데이터 파싱
            if (!responseString.startsWith("{")) {
                System.out.println("응답이 JSON 형식이 아닙니다: " + responseString);
                return "Invalid JSON response";
            }

            JSONObject jsonResponse = new JSONObject(responseString);
            JSONArray items = jsonResponse.getJSONArray("items");
            StringBuilder result = new StringBuilder();
            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                String title = item.getString("title");
                String link = item.getString("link");
                String description = item.getString("description");
                result.append("Title: ").append(title).append("\n");
                result.append("Link: ").append(link).append("\n");
                result.append("Description: ").append(description).append("\n\n");
            }
            return result.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return e.toString();
        }
    }
}