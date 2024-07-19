package com.example.demo.acsch;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class InterparkCrawler {
    private static final String[] URLS = {
        "https://tickets.interpark.com/goods/24008817",
        "https://tickets.interpark.com/goods/24009039",
        "https://tickets.interpark.com/goods/24005971#",
        "https://tickets.interpark.com/goods/24007345",
        "https://tickets.interpark.com/goods/24006851",
        "https://tickets.interpark.com/goods/24006816",
        "https://tickets.interpark.com/goods/24009834",
        "https://tickets.interpark.com/goods/24006741#",
        "https://tickets.interpark.com/goods/24007239",
        "https://tickets.interpark.com/goods/24005266#",
        "https://tickets.interpark.com/goods/24007631",
        "https://tickets.interpark.com/goods/24004835#",
        "https://tickets.interpark.com/goods/24005912#",
        "https://tickets.interpark.com/goods/24006677#",
        "https://tickets.interpark.com/goods/24006932",
        "https://tickets.interpark.com/goods/24006970",
        "https://tickets.interpark.com/goods/24006515",
        "https://tickets.interpark.com/goods/24008917",
        "https://tickets.interpark.com/goods/24006256",
        "https://tickets.interpark.com/goods/24008248",
        "https://tickets.interpark.com/goods/24008817",
        "https://tickets.interpark.com/goods/24006746",
        "https://tickets.interpark.com/goods/24008373",
        "https://tickets.interpark.com/goods/24008592",
        "https://tickets.interpark.com/goods/24007996",
        "https://tickets.interpark.com/goods/24007991",
        "https://tickets.interpark.com/goods/24008814",
        "https://tickets.interpark.com/goods/L0000091",
        "https://tickets.interpark.com/goods/24004604",
        "https://tickets.interpark.com/goods/24010138",
        "https://tickets.interpark.com/goods/24009007",
        "https://tickets.interpark.com/goods/24009304",
        "https://tickets.interpark.com/goods/24007874",
        "https://tickets.interpark.com/goods/24008589",
        "https://tickets.interpark.com/goods/24006797#",
        "https://tickets.interpark.com/goods/24009913",
        "https://tickets.interpark.com/goods/24005706",
        "https://tickets.interpark.com/goods/24006307",
        "https://tickets.interpark.com/goods/22001006",
        "https://tickets.interpark.com/goods/L0000092",
        "https://tickets.interpark.com/goods/23015628",
        "https://tickets.interpark.com/goods/24008310",
        "https://tickets.interpark.com/goods/24007080",
        "https://tickets.interpark.com/goods/23005252",
        "https://tickets.interpark.com/goods/24007393"
    };

    public static void main(String[] args) {
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");

        WebDriver driver = new ChromeDriver(options);

        for (String url : URLS) {
            driver.get(url);

            try {
                WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(60));
                wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h2.prdTitle")));

                // 타이틀 가져오기
                WebElement titleElement = driver.findElement(By.cssSelector("h2.prdTitle"));
                String title = titleElement.getText();
                System.out.println("Title: " + title);

                // 공연 기간 추출
                try {
                    WebElement periodElement = driver.findElement(By.cssSelector("li.infoItem div.infoDesc p.infoText"));
                    String periodText = periodElement.getText();
                    String[] period = periodText.split("~");
                    if (period.length == 2) {
                        String startDay = period[0].trim().replaceAll("\\.", "-");
                        String endDay = period[1].trim().replaceAll("\\.", "-");
                        System.out.println("Start Day: " + startDay);
                        System.out.println("End Day: " + endDay);
                    } else {
                        System.out.println("No valid period found for: " + title);
                    }
                } catch (Exception e) {
                    System.out.println("Error retrieving period for: " + title + " - " + e.getMessage());
                }

                // 팝업 닫기
                try {
                    WebElement popupCloseButton = driver.findElement(By.cssSelector("div#popup-prdGuide button.btn-close"));
                    popupCloseButton.click();
                } catch (Exception e) {
                    System.out.println("No popup found or failed to close it.");
                }

                // "캐스팅정보" 탭 클릭하기
                WebElement castingTab = driver.findElement(By.cssSelector("a[data-target='CASTING']"));
                JavascriptExecutor js = (JavascriptExecutor) driver;
                js.executeScript("arguments[0].click();", castingTab);

                // 캐스팅 정보가 로드될 때까지 기다리기
                wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.castingDetailResult")));

                // 캐스팅 정보 테이블 가져오기
                WebElement tableElement = driver.findElement(By.cssSelector("div.castingDetailResult table.castingDetailTable"));
                List<WebElement> rows = tableElement.findElements(By.tagName("tr"));

                // 배우와 역할 정보를 중복 없이 저장하기 위한 Set
                Set<String> actorRolesSet = new HashSet<>();

                for (WebElement row : rows) {
                    List<WebElement> cells = row.findElements(By.tagName("td"));
                    if (cells.size() > 0) {
                        String date = cells.get(0).getText();
                        String time = cells.get(1).getText();
                        StringBuilder rowData = new StringBuilder();
                        for (int j = 2; j < cells.size(); j++) {
                            String actorName = cells.get(j).getText();
                            if (!actorName.isEmpty()) {
                                String role = tableElement.findElement(By.cssSelector("th:nth-child(" + (j + 1) + ") span")).getText();
                                String actorRole = "Actor: " + actorName + ", Role: " + role;
                                actorRolesSet.add(actorRole);
                            }
                            rowData.append(cells.get(j).getText()).append(", ");
                        }
                        // Remove last comma and space
                        if (rowData.length() > 0) {
                            rowData.setLength(rowData.length() - 2);
                        }
                        // Remove duplicate time and date entries
                        System.out.println(date + "\t" + time + "\t" + rowData.toString().replaceFirst(date + ", " + time + ", ", ""));
                    }
                }

                // 중복되지 않는 배우와 역할 정보를 출력
                for (String actorRole : actorRolesSet) {
                    System.out.println(actorRole);
                }
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        driver.quit();
    }
}
