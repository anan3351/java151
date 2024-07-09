
package com.example.demo.actor;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@Service
public class PlayDbCrawler {

    private static final String DB_URL = "jdbc:mariadb://192.168.14.14:3306/aas";
    private static final String DB_USER = "team";
    private static final String DB_PASSWORD = "1234";

    /* 크롤링 사용할때 aasapplication에 주석 풀기
    public static void main(String[] args) {
       
    	try {
            String baseUrl = "http://www.playdb.co.kr/artistdb/detail.asp?ManNo=";
            int maxManNo = 54212;

            for (int manNo = 1; manNo <= maxManNo; manNo++) {
                try {
                    String url = baseUrl + manNo + "&part=013003"; // 뮤지컬배우
                    crawlActor(url);

                    url = baseUrl + manNo + "&part=013004"; // 연극배우
                    crawlActor(url);
                } catch (Exception e) {
                    e.printStackTrace();
                    continue; // 오류 발생 시 다음 번호로 넘어감
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    */

    private static void crawlActor(String url) throws IOException {
        try {
            Document doc = Jsoup.connect(url).get();
            if (doc.select("span.title").isEmpty()) {
                return; // 유효한 페이지가 아니면 건너뜀
            }

            // 배우 상세 정보 추출
            String name = getValue(doc.select("span.title"));
            if (name != null && name.contains("|")) {
                name = name.split("\\|")[0].trim(); // 한글 이름만 추출
            }
            String photo = getValue(doc.select(".psdetail_photo img"), "src");
            String job = getValue(doc.select("dt:contains(직업) + dd"));
            String birth = getValue(doc.select("dt:contains(생년월일) + dd"));
            String physical = getValue(doc.select("dt:contains(신체조건) + dd"));
            String agency = getValue(doc.select("dt:contains(소속사) + dd"));
            String site = getSites(doc.select("dd.pssite"));

            // 뮤지컬 배우 또는 연극 배우만 저장
            if (job != null && (job.contains("뮤지컬배우") || job.contains("연극배우"))) {
                saveActorToDatabase(name, photo, job, birth, physical, agency, site);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String getValue(Elements elements) {
        return elements.isEmpty() ? null : elements.text();
    }

    private static String getValue(Elements elements, String attribute) {
        return elements.isEmpty() ? null : elements.attr(attribute);
    }

    private static String getSites(Elements elements) {
        StringBuilder sites = new StringBuilder();
        for (Element element : elements) {
            Elements links = element.select("a");
            for (Element link : links) {
                sites.append(link.text()).append(": ").append(link.attr("href")).append("\n");
            }
        }
        return sites.toString().trim().isEmpty() ? null : sites.toString().trim();
    }

    private static void saveActorToDatabase(String name, String photo, String job, String birth, String physical, String agency, String site) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // 중복 체크
            if (isActorExists(connection, name, birth, photo)) {
                System.out.println("Actor " + name + " already exists. Skipping...");
                return;
            }

            String sql = "INSERT INTO tb_actor (a_name, photo, job, birth, physical, agency, site) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, photo);
                pstmt.setString(3, job);
                pstmt.setString(4, birth);
                pstmt.setString(5, physical);
                pstmt.setString(6, agency);
                pstmt.setString(7, site);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static boolean isActorExists(Connection connection, String name, String birth, String photo) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tb_actor WHERE (a_name = ? AND birth = ?) OR (a_name = ? AND photo = ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, birth);
            pstmt.setString(3, name);
            pstmt.setString(4, photo);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
