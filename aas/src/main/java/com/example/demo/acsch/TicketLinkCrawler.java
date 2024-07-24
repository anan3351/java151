package com.example.demo.acsch;

import com.example.demo.ticket.TicketDTO;
import com.example.demo.showcasting.ShowCastingDTO;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.Duration;
import java.util.*;

@Component
public class TicketLinkCrawler {
    private final AcschMapper acschMapper;

    @Autowired
    public TicketLinkCrawler(AcschMapper acschMapper) {
        this.acschMapper = acschMapper;
    }

    private static final String URL = "https://www.ticketlink.co.kr/product/50420";
    private static final String SHOW_ID = "PF242396";

    @Transactional
    public void crawl() {
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");

        WebDriver driver = new ChromeDriver(options);

        driver.get(URL);

        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(60));
            wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h1.product_title")));

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

            // 뮤지컬 제목 수집
            WebElement titleElement = driver.findElement(By.cssSelector("h1.product_title"));
            String title = titleElement.getText();
            System.out.println("Title: " + title);

            // 제목에서 "뮤지컬"이나 "연극"을 제거하고 특수문자와 공백 제거
            String cleanedTitle = title.replaceAll("뮤지컬|연극", "")
                    .replaceAll("[^가-힣a-zA-Z0-9\\s]", "")
                    .replaceAll("\\s+", "")
                    .trim();
            System.out.println("Cleaned Title: " + cleanedTitle);

            // JavaScript를 사용하여 배우 정보 추출
            List<Map<String, String>> actorRoles = (List<Map<String, String>>) ((JavascriptExecutor) driver).executeScript(
                    "var elements = document.querySelectorAll('li.swiper-slide.product_casting_item');" +
                    "var results = [];" +
                    "elements.forEach(function(e) {" +
                    "  var name = e.querySelector('span.product_casting_name').innerText.trim();" +
                    "  var role = e.querySelector('span.product_casting_role').innerText.trim();" +
                    "  results.push({name: name, role: role});" +
                    "});" +
                    "return results;"
            );

            // 배우 정보를 콘솔에 출력
            for (Map<String, String> actorRole : actorRoles) {
                String actorName = actorRole.get("name");
                String role = actorRole.get("role");
                System.out.println("Actor: " + actorName + ", Role: " + role);
            }

            // 출연 일정 보기 버튼 클릭
            try {
                WebElement castingButton = driver.findElement(By.cssSelector("button.common_btn.btn_ghost.btn_small"));
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", castingButton);

                // 출연 일정이 로드될 때까지 대기
                wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.result_table_box")));

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

                // 데이터베이스에 삽입
                Set<TicketDTO> ticketSet = new HashSet<>();
                Set<ShowCastingDTO> showCastingSet = new HashSet<>();
                Set<AcschDTO> acschSet = new HashSet<>();

                for (String showTime : showTimes) {
                    String[] parts = showTime.split("\t");
                    if (parts.length >= 2) {
                        String date = "2024-" + parts[0].trim().replaceAll("\\([가-힣]\\)", "").replace('.', '-'); // 연도 고정, 요일 제거
                        String time = parts[1].trim();
                        String dateTime = date + " " + time;

                        TicketDTO ticketDTO = new TicketDTO();
                        ticketDTO.setShow_id(SHOW_ID);

                        try {
                            // LocalDateTime 객체 생성
                            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                            LocalDateTime localDateTime = LocalDateTime.parse(dateTime, dateTimeFormatter);
                            Date dateTimeAsDate = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
                            ticketDTO.setTicket_Date(dateTimeAsDate);

                            // 디버깅을 위해 출력
                            System.out.println(ticketDTO);
                        } catch (DateTimeParseException e) {
                            System.out.println("Error parsing date: " + dateTime + " - " + e.getMessage());
                            continue;
                        }

                        ticketSet.add(ticketDTO);

                        for (Map<String, String> actorRole : actorRoles) {
                            String actorName = actorRole.get("name");
                            String role = actorRole.get("role");

                            Integer actorId = null;
                            try {
                                //actorId = acschMapper.findActorIdByRecentWork(actorName, cleanedTitle);
                                if (actorId != null) {
                                    System.out.println("Found actorId: " + actorId + " for actorName: " + actorName + " with recentWork: " + cleanedTitle);
                                    ShowCastingDTO showCastingDTO = new ShowCastingDTO();
                                    showCastingDTO.setShow_id(SHOW_ID);
                                    showCastingDTO.setActor_id(actorId);
                                    showCastingDTO.setCasting(role);

                                    // 중복 캐스팅 체크
                                    Integer duplicateCount = acschMapper.checkDuplicateCasting(SHOW_ID, actorId, role);
                                    if (duplicateCount == 0) {
                                        showCastingSet.add(showCastingDTO);
                                        System.out.println("Added ShowCastingDTO to set: " + showCastingDTO);
                                    } else {
                                        System.out.println("Duplicate casting found for show_id: " + SHOW_ID + ", actor_id: " + actorId + ", role: " + role);
                                    }
                                } else {
                                    System.out.println("Actor ID not found for actorName: " + actorName + " and recentWork: " + cleanedTitle);
                                }
                            } catch (Exception e) {
                                System.out.println("Error finding actor: " + e.getMessage());
                            }


                        }
                    }
                }

                for (ShowCastingDTO showCasting : showCastingSet) {
                    System.out.println("Inserting ShowCasting: " + showCasting);
                    //acschMapper.insertShowCasting(showCasting);
                    System.out.println("Inserted casting_id: " + showCasting.getCasting_id());

                    for (TicketDTO ticket : ticketSet) {
                        AcschDTO acschDTO = new AcschDTO();
                        acschDTO.setCasting_id(showCasting.getCasting_id());
                        acschDTO.setTicket_id(ticket.getTicket_id());

                        // AcschDTO 디버깅을 위해 출력
                        System.out.println(acschDTO);

                        acschSet.add(acschDTO);
                    }
                }


                // AcschDTO 데이터 출력
                for (AcschDTO acsch : acschSet) {
                    System.out.println("Inserting Acsch: " + acsch);
                    //acschMapper.insertAcsch(acsch);
                }

            } catch (NoSuchElementException e) {
                System.out.println("No '출연 일정 보기' button found for: " + title + ". Skipping this entry.");
            }

        } catch (Exception e) {
            System.out.println("Main error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            driver.quit();
        }
    }
}
