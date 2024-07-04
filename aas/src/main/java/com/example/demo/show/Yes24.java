package com.example.demo.show;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Yes24 {
    public static void main(String[] args) {
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // 동적으로 로드되는 요소를 안정적으로 찾기 위해 10초간 대기

        try {
            String url = "http://ticket.yes24.com/Perf/49701";
            driver.get(url);
            Map<String, String> sectionImages = new HashMap<>();

            // 클래스 순회
            for (int i = 1; i <= 4; i++) {
                String sectionSelector = String.format(".rn-080%d", i);
                WebElement section = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(sectionSelector)));

                // 키(타이틀) 추출
                String sectionTitle = section.findElement(By.cssSelector("p.rn08-tit")).getText();
                if (sectionTitle.equals("유의사항")) {
                    sectionTitle = "notice_img";
                } else if (sectionTitle.equals("할인정보")) {
                    sectionTitle = "dis_img";
                } else if (sectionTitle.equals("공연정보")) {
                    sectionTitle = "detail_img";
                } else if (sectionTitle.equals("캐스팅 일정")) {
                    sectionTitle = "casting_img";
                }

                // 값(이미지) 추출
                // 이미지 요소가 나타날 때까지 반복 시도(로딩 대기)
                for (int attempt = 0; attempt < 3; attempt++) {
                    List<WebElement> imgElements = section.findElements(By.cssSelector("img"));
                    if (!imgElements.isEmpty()) { // 이미지 요소가 비었는지 확인
                        StringBuilder imgUrlsBuilder = new StringBuilder();
                        for (WebElement imgElement : imgElements) {
                            imgUrlsBuilder.append(imgElement.getAttribute("src")).append("\n");
                        }
                        String imgUrls = imgUrlsBuilder.toString().trim();
                        sectionImages.put(sectionTitle, imgUrls);
                        break;
                    } else if (attempt < 2) { // 두번째 시도까지는 추가 대기시간 부여
                        Thread.sleep(2000); // 2초 대기 후 다시 시도
                    }
                }
            }

            // 맵에 저장된 데이터 출력
            for (Map.Entry<String, String> entry : sectionImages.entrySet()) {
                System.out.println("title : " + entry.getKey());
                System.out.println("url :");
                System.out.println(entry.getValue());
                System.out.println();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }
    }
}
