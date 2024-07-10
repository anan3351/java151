package com.example.demo.seat;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Seat {

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
                try {
                    driver.get(url);

                    // <div class="dropdown"></div> 요소가 존재하는지 확인
                    List<WebElement> dropdownElements = driver.findElements(By.cssSelector(".dropdown"));
                    if (dropdownElements.isEmpty()) {
                        continue; // .dropdown 요소가 없으면 다음 페이지로 넘어감
                    }

                    // .dropdown 요소의 텍스트 값을 추출
                    String hall_id = dropdownElements.get(0).getText();

                    // 페이지에 좌석 정보가 있는지 확인
                    List<WebElement> seatElements = driver.findElements(By.cssSelector(".box")); // 실제 CSS 선택자로 업데이트
                    if (seatElements.isEmpty()) {
                        System.out.println("페이지 " + url + ": 좌석 정보가 없습니다.");
                        continue; // 페이지가 비어 있으면 다음 반복으로 넘어감
                    }

                    for (WebElement seatElement : seatElements) {
                        try {
                            // <div> 태그의 모든 floor 클래스 값을 추출
                            List<WebElement> floorElements = seatElement.findElements(By.cssSelector(".floor"));
                            for (WebElement floorElement : floorElements) {
                                // floor 안에 있는 seattable_floor, row, seat p 태그 값 추출
                                List<WebElement> seattableFloorElements = floorElement.findElements(By.cssSelector(".seattable_floor"));
                                List<WebElement> seattableZoneElements = floorElement.findElements(By.cssSelector(".seattable_zone_container"));
                                List<WebElement> seatNumberElements = floorElement.findElements(By.cssSelector(".seat_num"));
                                List<WebElement> seatPElements = floorElement.findElements(By.cssSelector("#seat p"));

                                // 각 클래스의 값 추출
                                for (WebElement seattableFloorElement : seattableFloorElements) {
                                    String s_floor = seattableFloorElement.getText();
                                    System.out.println("층 : " + s_floor);
                                }
                                for (WebElement seattableZoneElement : seattableZoneElements) {
                                    String s_section = seattableZoneElement.getText();
                                    System.out.println("구역 : " + s_section);
                                }
                                for (WebElement seatNumberElement : seatNumberElements) {
                                    String s_row = seatNumberElement.getText();
                                    System.out.println(s_row + "열");
                                }
                                for (WebElement seatPElement : seatPElements) {
                                    String s_number = seatPElement.getText();
                                    System.out.println("좌석번호 : " + s_number);
                                }

                                // 추가 정보 출력
                                String seat_level = "";
                                System.out.println("공연장 : " + hall_id);
                                System.out.println("seat_level: " + seat_level);
                                System.out.println("------------------------------");
                            }
                        } catch (Exception e) {
                            System.out.println("페이지 " + hall_id + "의 좌석 요소에서 데이터 추출 오류: " + e.getMessage());
                        }
                    }
                } catch (Exception e) {
                    System.out.println("페이지 " + url + " 처리 중 오류: " + e.getMessage());
                }
            }
        } finally {
            // WebDriver 종료
            driver.quit();
        }
    }
}
