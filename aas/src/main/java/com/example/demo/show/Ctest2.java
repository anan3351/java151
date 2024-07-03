package com.example.demo.show;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Ctest2 {
    public static void main(String[] args) {
        // WebDriver와 ChromDriver 설정
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        try {
            String url = "https://tickets.interpark.com/goods/24006851";
            driver.get(url);

            // 데이터 추출
            List<WebElement> contentElements = driver.findElements(By.cssSelector(".prdContents.detail .content"));
            Map<String, String> contentImagesMap = new HashMap<>();
            String casting = "";

            // content 별 이미지 URL 추출하여 "\n"과 함께 map에 저장
            for (WebElement contentElement : contentElements) {
                StringBuilder images = new StringBuilder();
                String title = contentElement.findElement(By.tagName("h3")).getText();
                List<WebElement> contentDetailImages = contentElement.findElements(By.cssSelector(".contentDetail img"));

                // img 요소가 존재할 때만 map에 저장
                if (!contentDetailImages.isEmpty()) {
                	
                	// 캐스팅 이미지 따로 저장
                    if (title.equals("공연상세 / 캐스팅일정")) {
                        for (int i = 0; i < contentDetailImages.size(); i++) {
                            if (i == 1) {
                                casting = contentDetailImages.get(i).getAttribute("src");
                            } else {
                                images.append(contentDetailImages.get(i).getAttribute("src"));
                                images.append("\n");
                            }
                        }
                    } else { // 일반 이미지 저장
                        for (WebElement imgElement : contentDetailImages) {
                            images.append(imgElement.getAttribute("src"));
                            images.append("\n");
                        }
                    }
                    

                    String image = images.toString().trim();
                    contentImagesMap.put(title, image);
                }
            }

            // 추출한 데이터 출력
            for (Map.Entry<String, String> entry : contentImagesMap.entrySet()) {
                String title = entry.getKey();
                String image = entry.getValue();

                System.out.println("title : " + title);
                System.out.println("url : ");
                System.out.println(image);
                System.out.println();
            }

            // 캐스팅 정보 출력
            if (!casting.isEmpty()) {
                System.out.println("캐스팅 일정 : " + casting);
                System.out.println();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }
    }
}
