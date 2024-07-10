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
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // 10초간 대기
        Map<String, String> sectionImages = new HashMap<>();
        
        try {
            String url = "http://ticket.yes24.com/Perf/49272?Gcode=009_400";
            driver.get(url);

            // 클래스 순회
            for (int i = 1; i <= 4; i++) {
                String sectionSelector = String.format(".rn-080%d", i);
                WebElement section = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(sectionSelector)));

                // 섹션 타이틀 추출
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
                for (int attempt = 0; attempt < 2; attempt++) {
                    List<WebElement> imgElements = section.findElements(By.cssSelector("img"));
                    if (!imgElements.isEmpty()) { // 이미지 요소가 비었는지 확인
                        StringBuilder imgUrlsBuilder = new StringBuilder();
                        for (WebElement imgElement : imgElements) {
                            imgUrlsBuilder.append(imgElement.getAttribute("src")).append("\n");
                        }
                        String imgUrls = imgUrlsBuilder.toString().trim();
                        sectionImages.put(sectionTitle, imgUrls);
                        break;
                    } else if (attempt < 1) { // 추가 대기시간 부여
                        Thread.sleep(2000); // 2초 대기 후 다시 시도
                    }
                }
            }
            
            
            // 배우 이름 추출
            WebElement castSection = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".rn-product-area1 dt:nth-of-type(3) + dd"))); // 세번째 요소에서 추출
            List<WebElement> cast = castSection.findElements(By.cssSelector("a"));
            StringBuilder actors = new StringBuilder();

            for (int i = 0; i < cast.size(); i++) {
                String actorName = cast.get(i).getText();
                
                if (i != cast.size() - 1) actors.append(actorName).append(", ");
                else actors.append(actorName);
            }
            
            if (actors.length() >= 3) {
            	sectionImages.put("cast", actors.toString());
            }

            // 맵에 저장된 데이터 출력
            for (Map.Entry<String, String> entry : sectionImages.entrySet()) {
                System.out.println(entry.getKey() + " : ");
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
