package com.example.demo.crawler;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.io.IOException;

public class PlayDbCrawler {

    private static final String DB_URL = "jdbc:mariadb://192.168.14.14:3306/aas";
    private static final String DB_USER = "team";
    private static final String DB_PASSWORD = "1234";

    public static void main(String[] args) {
        try {
            String baseUrl = "http://www.playdb.co.kr";
            String[] actorListUrls = {
                baseUrl + "/artistdb/list.asp?code=013003", // 뮤지컬배우
                baseUrl + "/artistdb/list.asp?code=013004"  // 연극배우
            };

            for (String actorListUrl : actorListUrls) {
                // 배우 리스트 페이지 크롤링
                Document doc = Jsoup.connect(actorListUrl).get();
                Elements actorLinks = doc.select("a[href*='/artistdb/detail.asp?']");

                for (Element link : actorLinks) {
                    String actorUrl = baseUrl + link.attr("href");
                    getActorDetails(actorUrl);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void getActorDetails(String url) {
        try {
            Document doc = Jsoup.connect(url).get();

            // 배우 상세 정보 추출
            String name = doc.select("span.title").text();
            String photo = doc.select(".photo a img").attr("src");
            String job = "배우"; // Assuming all are actors
            String birth = doc.select("li:contains(생년월일)").text().replace("생년월일 : ", "").trim();
            String physical = doc.select("li:contains(신체사항)").text().replace("신체사항 : ", "").trim();
            String agency = doc.select("li:contains(소속사)").text().replace("소속사 : ", "").trim();
            String site = url;

            saveActorToDatabase(name, photo, job, birth, physical, agency, site);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void saveActorToDatabase(String name, String photo, String job, String birth, String physical, String agency, String site) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO tb_actor (a_name, photo, job, birth, physical, agency, site) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, name);
                pstmt.setString(2, photo);
                pstmt.setString(3, job);
                pstmt.setString(4, birth.isEmpty() ? null : birth);
                pstmt.setString(5, physical);
                pstmt.setString(6, agency);
                pstmt.setString(7, site);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}