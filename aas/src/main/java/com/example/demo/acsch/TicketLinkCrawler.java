package com.example.demo.acsch;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.NoSuchElementException;

import java.time.Duration;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class TicketLinkCrawler {
    private static final List<String> URLS = Arrays.asList(
            "https://www.ticketlink.co.kr/performance/16",
            "https://www.ticketlink.co.kr/performance/15"
    );

    public static void main(String[] args) {
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");

        WebDriver driver = new ChromeDriver(options);

        List<Map<String, String>> showsData = new ArrayList<>();

        for (String url : URLS) {
            driver.get(url);

            try {
                WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(60));
                wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.product_grid_list")));

                // 팝업 닫기 (필요시)
                try {
                    WebElement closePopup = driver.findElement(By.cssSelector("div.popup.is-visible button"));
                    if (closePopup.isDisplayed()) {
                        closePopup.click();
                        System.out.println("Popup closed.");
                    }
                } catch (Exception e) {
                    System.out.println("No popup found or failed to close it.");
                }

                // 모든 뮤지컬 항목의 이미지 요소 수집
                List<WebElement> items = driver.findElements(By.cssSelector("div.product_grid_item a.product_link img"));
                System.out.println("Found " + items.size() + " items.");

                // 각 이미지 클릭하여 상세 정보 및 출연 일정 수집
                for (int i = 0; i < items.size(); i++) {
                    try {
                        List<WebElement> currentItems = driver.findElements(By.cssSelector("div.product_grid_item a.product_link img"));
                        WebElement item = currentItems.get(i);
                        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", item);

                        // 상세 페이지가 로드될 때까지 대기
                        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h1.product_title")));

                        // 뮤지컬 제목 수집
                        WebElement titleElement = driver.findElement(By.cssSelector("h1.product_title"));
                        String title = titleElement.getText();
                        System.out.println("Title: " + title);

                        // 출연 일정 보기 버튼 클릭
                        try {
                            WebElement castingButton = driver.findElement(By.cssSelector("button.common_btn.btn_ghost.btn_small"));
                            ((JavascriptExecutor) driver).executeScript("arguments[0].click();", castingButton);

                            // 출연 일정이 로드될 때까지 대기
                            wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.result_table_box")));

                            // 시작일 및 종료일 추출
                            WebElement startDayElement = driver.findElement(By.cssSelector("a.btn_calendar.active span.date"));
                            WebElement endDayElement = driver.findElements(By.cssSelector("span.date")).get(1); // 두 번째 date 요소

                            String startDay = startDayElement.getText();
                            String endDay = endDayElement.getText();

                            // 날짜 형식 변환 (2024년 07월 15일 (월) -> 2024-07-15)
                            startDay = startDay.replaceAll("[^0-9]", "-").replaceAll("-{2,}", "-").replaceAll("-$", "");
                            endDay = endDay.replaceAll("[^0-9]", "-").replaceAll("-{2,}", "-").replaceAll("-$", "");

                            System.out.println("Start Day: " + startDay);
                            System.out.println("End Day: " + endDay);

                            // 출연 일정 정보 수집
                            WebElement castingTable = driver.findElement(By.cssSelector("div.result_table_box table"));
                            List<WebElement> rows = castingTable.findElements(By.tagName("tr"));
                            List<String> showTimes = new ArrayList<>();
                            for (WebElement row : rows) {
                                List<WebElement> cells = row.findElements(By.tagName("td"));
                                StringBuilder rowData = new StringBuilder();
                                for (WebElement cell : cells) {
                                    if (!cell.getText().contains("예매하기") && !cell.getText().contains("판매종료")) {
                                        rowData.append(cell.getText()).append("\t");
                                    }
                                }
                                if (!rowData.toString().trim().isEmpty()) {
                                    showTimes.add(rowData.toString().trim());
                                    System.out.println(rowData.toString().trim());
                                }
                            }

                            // 배우 이름과 역할 정보 수집
                            List<WebElement> actorElements = driver.findElements(By.cssSelector("li.casting_item"));
                            Map<String, String> actorRoles = new HashMap<>();
                            for (WebElement actorElement : actorElements) {
                                try {
                                    String actorName = actorElement.findElement(By.cssSelector("dd.actor_name")).getText().trim();
                                    String actorRole = actorElement.findElement(By.cssSelector("dd.actor_role")).getText().trim();
                                    if (!actorName.isEmpty() && !actorRole.isEmpty()) {
                                        actorRoles.put(actorName, actorRole);
                                        System.out.println("Actor: " + actorName + ", Role: " + actorRole);
                                    }
                                } catch (NoSuchElementException e) {
                                    // Actor or role element not found, skip this element
                                }
                            }

                            // 데이터 저장
                            Map<String, String> showData = new HashMap<>();
                            showData.put("title", title);
                            showData.put("start_day", startDay);
                            showData.put("end_day", endDay);
                            showData.put("showTimes", String.join("|", showTimes));
                            actorRoles.forEach((actor, role) -> {
                                showData.put("actor_" + actor, role);
                            });
                            showsData.add(showData);

                        } catch (NoSuchElementException e) {
                            System.out.println("No '출연 일정 보기' button found for: " + title + ". Skipping this entry.");
                        }

                        // 이전 페이지로 돌아가기
                        driver.navigate().back();
                        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.product_grid_list")));
                    } catch (Exception e) {
                        System.out.println("Error processing item: " + e.getMessage());
                    }
                }
            } catch (Exception e) {
                System.out.println("Main error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        driver.quit();

        // 데이터베이스 저장 로직
        for (Map<String, String> showData : showsData) {
            // 데이터베이스 저장 구현
            System.out.println("Saving show data: " + showData);
        }
    }
}
