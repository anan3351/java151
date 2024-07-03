package com.example.demo.show;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Yes24 {
    public static void main(String[] args) {
        // WebDriver와 ChromDriver 설정
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // 최대 10초간 대기

        try {
            String url = "http://ticket.yes24.com/Perf/49701";
            driver.get(url);

            // 데이터를 저장할 Map
            Map<String, String> sectionImages = new HashMap<>();

            // 섹션 순회 및 이미지 URL 추출
            for (int i = 1; i <= 4; i++) {
                String sectionSelector = String.format(".rn-080%d", i);
                WebElement section = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(sectionSelector)));

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
                
                List<WebElement> imgElements = section.findElements(By.cssSelector("img"));

                StringBuilder imgUrlsBuilder = new StringBuilder();
                for (WebElement imgElement : imgElements) {
                    imgUrlsBuilder.append(imgElement.getAttribute("src")).append("\n");
                }

                String imgUrls = imgUrlsBuilder.toString().trim();
                sectionImages.put(sectionTitle, imgUrls);
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
