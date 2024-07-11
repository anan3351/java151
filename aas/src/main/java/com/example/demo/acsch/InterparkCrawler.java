package com.example.demo.acsch;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class InterparkCrawler {

    public static void main(String[] args) {
        // WebDriver 설정
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe"); // Chromedriver 경로 설정
        WebDriver driver = new ChromeDriver();
        
        // 페이지 로딩 대기 시간 설정
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

        // Interpark 뮤지컬 페이지로 이동
        driver.get("https://tickets.interpark.com/contents/genre/musical");

        // URL 목록 초기화
        List<String> musicalUrls = new ArrayList<>();
        
        // 뮤지컬 페이지가 로드될 때까지 대기
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("div.ProductList_contents__eUxgq")));

        // 모든 뮤지컬 URL 가져오기
        for (int i = 1; i <= 140; i++) { // 최대 140개 항목을 대상으로 함
            try {
                String selector = "#contents > article.ProductList_productListWrapper__frZE_.GProductList.Panel_wrap__b444b > section > div.Panel_contents__f7025.Panel_fill-scroll__8271f > div.ProductList_contents__eUxgq.InfiniteList_list__3c511.InfiniteList_column-desktop-5__9cab3.InfiniteList_column-mobile-1__853f7.InfiniteList_ticket-list__dfe68 > a:nth-child(" + i + ")";
                WebElement musicalElement = driver.findElement(By.cssSelector(selector));
                String url = musicalElement.getAttribute("href");
                if (url != null) {
                    musicalUrls.add(url);
                }
            } catch (Exception e) {
                // 요소를 찾지 못했을 경우 루프를 빠져나옴
                break;
            }
        }

        // URL 출력
        System.out.println("Musical URLs: " + musicalUrls);

        // 브라우저 종료
        driver.quit();
    }
}

