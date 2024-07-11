package com.example.demo.acsch;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class acschCrawiling {

    public String getShowTitle() {
        // ChromeDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe");

        // WebDriver 인스턴스 생성
        WebDriver driver = new ChromeDriver();

        // 페이지 로드 대기 시간 설정
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

        // URL 접속
        driver.get("https://tickets.interpark.com/goods/24005971");

        // 타이틀 요소 찾기
        WebElement titleElement = driver.findElement(By.cssSelector("h2.prdTitle"));
        String title = titleElement != null ? titleElement.getText() : "Title not found";

        // 브라우저 닫기
        driver.quit();

        return title;
    }

    public List<String> getShowSchedule() {
        // ChromeDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe");

        // WebDriver 인스턴스 생성
        WebDriver driver = new ChromeDriver();

        // 페이지 로드 대기 시간 설정
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

        // URL 접속
        driver.get("https://tickets.interpark.com/goods/24005971");

        // 스케줄 요소 찾기
        List<WebElement> rows = driver.findElements(By.cssSelector("div.contentDetail div.row"));
        List<String> schedules = new ArrayList<>();
        for (WebElement row : rows) {
            List<WebElement> cells = row.findElements(By.cssSelector("div.cell"));
            for (WebElement cell : cells) {
                schedules.add(cell.getText());
            }
        }

        // 브라우저 닫기
        driver.quit();

        return schedules;
    }
}
