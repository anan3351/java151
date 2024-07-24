
package com.example.demo.seat;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Seat {

    private static final Map<String, String> theaterNameToIdMap = new HashMap<>();

    static {
        theaterNameToIdMap.put("고양아람누리 아람극장", "FC000127-03");
        theaterNameToIdMap.put("광림아트센터 BBCH홀", "FC001370-02");
        theaterNameToIdMap.put("국립정동극장", "FC000006-01");
        theaterNameToIdMap.put("국립중앙박물관 극장 용", "FC000008-01");
        theaterNameToIdMap.put("계명아트센터", "FC001239-01");
        theaterNameToIdMap.put("공연예술센터 코튼홀", "FC000528-01");
        theaterNameToIdMap.put("드림씨어터", "FC002162");
        theaterNameToIdMap.put("디큐브아트센터", "FC000011-01");
        theaterNameToIdMap.put("두산아트센터 연강홀", "FC000402-02");
        theaterNameToIdMap.put("명동예술극장", "FC000005-01");
        theaterNameToIdMap.put("블루스퀘어 신한카드홀", "FC000031-01");
        theaterNameToIdMap.put("브릭스씨어터", "FC001199");
        theaterNameToIdMap.put("백암아트홀", "FC000062");
        theaterNameToIdMap.put("샤롯데씨어터", "FC000012");
        theaterNameToIdMap.put("서경대학교 공연예술센터 SKON1관", "FC001877-03");
        theaterNameToIdMap.put("서경대학교 공연예술센터 SKON2관", "FC001877-02");
        theaterNameToIdMap.put("세종문화회관 M씨어터", "FC000020-03");
        theaterNameToIdMap.put("세종문화회관 S씨어터", "FC000020-07");
        theaterNameToIdMap.put("세종문화회관 대극장", "FC000020-01");
        theaterNameToIdMap.put("소향씨어터 신한카드홀", "FC001347");
        theaterNameToIdMap.put("성남아트센터 오페라하우스", "FC000016-02");
        theaterNameToIdMap.put("예그린씨어터", "FC001212");
        theaterNameToIdMap.put("예술의전당 CJ토월극장", "FC000001-01");
        theaterNameToIdMap.put("예술의전당 오페라극장", "FC000001-06");
        theaterNameToIdMap.put("예스24스테이지 1관", "FC001236-01");
        theaterNameToIdMap.put("예스24스테이지 2관", "FC001236-02");
        theaterNameToIdMap.put("예스24스테이지 3관", "FC001236-03");
        theaterNameToIdMap.put("예스24아트원 1관", "FC000833-01");
        theaterNameToIdMap.put("예스24아트원 2관", "FC000833-02");
        theaterNameToIdMap.put("예스24아트원 3관(2024.03 이후)", "FC000833-03");
        theaterNameToIdMap.put("유니버설아트센터", "FC000010");
        theaterNameToIdMap.put("유니플렉스 1관", "FC001233-01");
        theaterNameToIdMap.put("유니플렉스 2관", "FC001233-02");
        theaterNameToIdMap.put("JTN 아트홀 1관", "FC000139-01");
        theaterNameToIdMap.put("충무아트센터 대극장", "FC000014-02");
        theaterNameToIdMap.put("충무아트센터 블랙", "FC000014-03");
        theaterNameToIdMap.put("KT&G 상상마당 대치아트홀", "FC000052");
        theaterNameToIdMap.put("홍익대아트센터 대극장", "FC001208-01");
        theaterNameToIdMap.put("아르코예술극장 소극장", "FC002632-02");
        theaterNameToIdMap.put("아르코예술극장 대극장", "FC002632-01");
        theaterNameToIdMap.put("링크아트센터드림 드림1관", "FC001528-01");
        theaterNameToIdMap.put("링크아트센터드림 드림2관", "FC001528-02");
        theaterNameToIdMap.put("링크아트센터드림 드림3관", "FC001528-03");
        theaterNameToIdMap.put("링크아트센터드림 드림4관", "FC001528-04");
        theaterNameToIdMap.put("링크아트센터 페이코홀", "FC003244-01");
        theaterNameToIdMap.put("링크아트센터 벅스홀", "FC003244-02");
        theaterNameToIdMap.put("LG아트센터 서울 LG Signature 홀", "FC003045-01");
        theaterNameToIdMap.put("대학로예술극장 소극장", "FC002633-02");
        theaterNameToIdMap.put("대학로예술극장 대극장", "FC002633-01");
        theaterNameToIdMap.put("대학로 자유극장", "FC000785-01");
        theaterNameToIdMap.put("한전아트센터", "FC000113");
    }
    
    public static void main(String[] args) {
        // chromedriver 실행 파일의 경로 설정
        System.setProperty("webdriver.chrome.driver", "D:\\Java202401\\java151\\aas\\src\\main\\resources\\driver\\chromedriver.exe");

        // WebDriver 초기화
        WebDriver driver = new ChromeDriver();

        try {
            // 웹사이트의 기본 URL 설정
            String baseUrl = "https://musicalseeya.com/search/all_theater_play/#fh";
            driver.get(baseUrl);

            // 모든 링크 요소 가져오기
            List<WebElement> allLinks = driver.findElements(By.tagName("a"));
            Set<String> theaterLinks = new HashSet<>();

            // 링크 중에서 'seeyatheater'를 포함하는 링크만 필터링
            for (WebElement link : allLinks) {
                String url = link.getAttribute("href");
                if (url != null && url.contains("seeyatheater")) {
                    theaterLinks.add(url);
                }
            }

            // 필터링된 링크들에 대해 처리 수행
            for (String url : theaterLinks) {
                // 공연장별로 중복 좌석 정보를 추적하기 위한 Map
                Map<String, Set<String>> theaterSeats = new HashMap<>();

                processURL(driver, url, theaterSeats);

                // 추가 URL 처리 (type=1부터 type=10까지 검사)
                for (int i = 1; i <= 10; i++) {
                    String newUrl = url + "?type=" + i;
                    processURL(driver, newUrl, theaterSeats);
                }

                // SQL INSERT 문 생성 및 출력
                generateSQLInsertStatements(theaterSeats);
            }
        } finally {
            // WebDriver 종료
            driver.quit();
        }
    }

    private static void processURL(WebDriver driver, String url, Map<String, Set<String>> theaterSeats) {
        try {
            driver.get(url);

            // <div class="dropdown"></div> 요소가 존재하는지 확인
            List<WebElement> dropdownElements = driver.findElements(By.cssSelector(".dropdown"));
            if (dropdownElements.isEmpty()) {
                return; // .dropdown 요소가 없으면 이 페이지를 건너뜀
            }

            // .dropdown 요소의 텍스트 값을 추출
            String hallName = dropdownElements.get(0).getText();

            // 페이지에 seat_all seat-all 클래스를 가진 요소가 있는지 확인
            List<WebElement> seatElements = driver.findElements(By.cssSelector(".seat_all.seat-all"));
            if (seatElements.isEmpty()) {
                return; // 페이지가 비어 있으면 다음 반복으로 넘어감
            }

            if (!theaterSeats.containsKey(hallName)) {
                theaterSeats.put(hallName, new HashSet<>());
            }

            for (WebElement seatElement : seatElements) {
                try {
                    // seat_all seat-all 클래스 안의 .seats 클래스 내의 <p> 요소에서 필요한 값 추출
                    String seatInfo = s_number(seatElement);
                    if (!seatInfo.trim().isEmpty() && !theaterSeats.get(hallName).contains(seatInfo)) {
                        theaterSeats.get(hallName).add(seatInfo);
                    }
                } catch (Exception e) {
                    System.out.println("페이지 " + hallName + "의 좌석 요소에서 데이터 추출 오류: " + e.getMessage());
                }
            }
        } catch (Exception e) {
            System.out.println("페이지 " + url + " 처리 중 오류: " + e.getMessage());
        }
    }

    private static String s_number(WebElement seatElement) {
        // "seattable_floor" 요소가 존재하는지 확인
        List<WebElement> floorElements = seatElement.findElements(By.cssSelector(".seattable_floor"));
        if (floorElements.isEmpty()) {
            return ""; // .seattable_floor 요소가 없으면 빈 문자열 반환
        }

        String floorInfo = floorElements.get(0).getText();

        // 좌석 번호 추출
        List<WebElement> seatsElements = seatElement.findElements(By.cssSelector(".seats p"));
        StringBuilder seatNumbers = new StringBuilder();

        for (WebElement pElement : seatsElements) {
            String seatNumber = pElement.getText();
            if (!seatNumber.trim().isEmpty()) {
                if (seatNumbers.length() > 0) {
                    seatNumbers.append(", ");
                }
                seatNumbers.append(seatNumber);
            }
        }

        if (floorInfo.isEmpty() && seatNumbers.length() == 0) {
            return ""; // 층수 정보와 좌석 번호가 모두 없는 경우 빈 문자열 반환
        } else if (floorInfo.isEmpty()) {
            return seatNumbers.toString(); // 층수 정보만 없는 경우
        } else if (seatNumbers.length() == 0) {
            return floorInfo; // 좌석 번호만 없는 경우
        } else {
            return "층수: " + floorInfo + ", 좌석 번호: " + seatNumbers.toString(); // 층수 정보와 좌석 번호 모두 있는 경우
        }
    }

    private static void generateSQLInsertStatements(Map<String, Set<String>> theaterSeats) {
        String jdbcUrl = "jdbc:mariadb://192.168.14.14:3306/aas";
        String dbUser = "team";
        String dbPassword = "1234";

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            for (String hallName : theaterSeats.keySet()) {
                if (!theaterNameToIdMap.containsKey(hallName)) {
                    continue; // hallName이 theaterNameToIdMap에 없으면 건너뜀
                }

                String hallId = theaterNameToIdMap.get(hallName);
                Set<String> seats = theaterSeats.get(hallName);
                for (String seat : seats) {
                    if (seat.contains("층수: ")) {
                        // SQL INSERT 문 생성
                        String[] seatInfoParts = seat.split(", ");
                        String floor = seatInfoParts[0].replace("층수: ", "").trim();

                        for (int i = 1; i < seatInfoParts.length; i++) {
                            String seatNumber = seatInfoParts[i].replace("좌석 번호: ", "").trim();
                            String seatLevel = "NULL"; // seat_level은 예제 코드에서 추출되지 않으므로 임시로 NULL로 설정

                            // 데이터가 이미 존재하는지 확인하는 SQL 문
                            String checkSql = "SELECT COUNT(*) FROM tb_seat WHERE s_floor = ? AND s_number = ? AND hall_id = ?";

                            try (PreparedStatement checkPstmt = conn.prepareStatement(checkSql)) {
                                checkPstmt.setString(1, floor);
                                checkPstmt.setString(2, seatNumber);
                                checkPstmt.setString(3, hallId);

                                // 존재 여부 확인
                                ResultSet rs = checkPstmt.executeQuery();
                                rs.next();
                                int count = rs.getInt(1);

                                if (count == 0) { // 데이터가 존재하지 않으면 삽입
                                    String sql = "INSERT INTO tb_seat (s_floor, s_number, hall_id, seat_level) VALUES (?, ?, ?, ?)";

                                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                                        pstmt.setString(1, floor);
                                        pstmt.setString(2, seatNumber);
                                        pstmt.setString(3, hallId);
                                        pstmt.setString(4, seatLevel);

                                        // SQL 쿼리 실행
                                        pstmt.executeUpdate();
                                    } catch (Exception e) {
                                        System.out.println("SQL 쿼리 실행 중 오류: " + e.getMessage());
                                    }
                                }
                            } catch (Exception e) {
                                System.out.println("데이터 중복 확인 중 오류: " + e.getMessage());
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("데이터베이스 연결 중 오류: " + e.getMessage());
        }
    }
}
