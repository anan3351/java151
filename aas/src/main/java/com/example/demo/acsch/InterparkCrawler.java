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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.Duration;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Component
public class InterparkCrawler {
    private final AcschMapper acschMapper;

    @Autowired
    public InterparkCrawler(AcschMapper acschMapper) {
        this.acschMapper = acschMapper;
    }

    private static final Map<String, String> URLS = Map.of(
    		"https://tickets.interpark.com/goods/24007393", "PF241880"
            // 추가 URL과 show_id를 여기에 추가
    );

    @Transactional
    public void crawl() {
        System.setProperty("webdriver.chrome.driver", "C:\\selenium-drivers\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("--user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");

        WebDriver driver = new ChromeDriver(options);

        for (Map.Entry<String, String> entry : URLS.entrySet()) {
            String url = entry.getKey();
            String showId = entry.getValue();

            driver.get(url);

            try {
                WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(60));
                wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("h2.prdTitle")));

                // 타이틀 가져오기
                WebElement titleElement = driver.findElement(By.cssSelector("h2.prdTitle"));
                String title = titleElement.getText().replaceAll("[^a-zA-Z0-9가-힣]", "").replaceAll("뮤지컬|연극", "");

                // 팝업 닫기
                try {
                    WebElement popupCloseButton = driver.findElement(By.cssSelector("div#popup-prdGuide button.btn-close"));
                    popupCloseButton.click();
                } catch (Exception e) {
                    System.out.println("No popup found or failed to close it.");
                }

                // "더보기" 버튼 클릭하기
                try {
                    JavascriptExecutor js = (JavascriptExecutor) driver;
                    WebElement moreButton = driver.findElement(By.cssSelector("a.contentToggleBtn[role='button']"));
                    js.executeScript("arguments[0].scrollIntoView(true);", moreButton); // 스크롤 다운
                    js.executeScript("arguments[0].click();", moreButton); // JavaScript로 클릭
                    // '더보기' 버튼을 클릭한 후 데이터를 로드할 시간을 충분히 줍니다.
                    Thread.sleep(2000); // 2초 정도 대기
                } catch (Exception e) {
                    System.out.println("No more button found or failed to click it.");
                }

                // 캐스팅 정보 추출
                List<WebElement> castingElements = driver.findElements(By.cssSelector("li.castingItem"));
                Set<ShowCastingDTO> showCastingSet = new HashSet<>();

                for (WebElement castingElement : castingElements) {
                    String actorName = castingElement.findElement(By.cssSelector("div.castingName")).getText().trim();
                    String role = castingElement.findElement(By.cssSelector("div.castingActor")).getText().trim();
                    String recentWork = title.replaceAll("[^a-zA-Z0-9가-힣]", ""); // 타이틀에서 특수문자 제거

                    System.out.println("actorName:" + actorName + ", recentWork: " + recentWork + ", role: " + role);

                    Integer actorId = findActorId(actorName, recentWork);
                    System.out.println("Found actorId: " + actorId + " for actorName: " + actorName + " with recentWork: " + recentWork);

                    if (actorId != null) {
                        ShowCastingDTO showCastingDTO = new ShowCastingDTO();
                        showCastingDTO.setShow_id(showId);
                        showCastingDTO.setActor_id(actorId);
                        showCastingDTO.setCasting(role);

                        int duplicateCastingCount = acschMapper.checkDuplicateCasting(showCastingDTO.getShow_id(), showCastingDTO.getActor_id(), showCastingDTO.getCasting());
                        if (duplicateCastingCount == 0) {
                            showCastingSet.add(showCastingDTO);
                        } else {
                            System.out.println("Duplicate casting found: " + showCastingDTO);
                        }
                    } else {
                        System.out.println("No actorId found for actorName: " + actorName + " with recentWork: " + recentWork);
                    }
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

                Set<TicketDTO> ticketSet = new HashSet<>();
                Set<ShowCastingDTO> showCastingSetDetail = new HashSet<>();
                Set<AcschDTO> acschSet = new HashSet<>();

                for (WebElement row : rows) {
                    List<WebElement> cells = row.findElements(By.tagName("td"));
                    if (cells.size() > 0) {
                        String date = cells.get(0).getText().split("\\(")[0].trim(); // 주중 정보를 제거하고 트림 처리
                        String time = cells.get(1).getText().trim();
                        String currentYear = String.valueOf(LocalDate.now().getYear());
                        String dateTime = currentYear + "/" + date + " " + time;

                        // 공연 회차 데이터 저장
                        TicketDTO ticketDTO = new TicketDTO();
                        ticketDTO.setShow_id(showId);

                        try {
                            // LocalDateTime 객체 생성
                            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");
                            LocalDateTime localDateTime = LocalDateTime.parse(dateTime, dateTimeFormatter);
                            Date dateTimeAsDate = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
                            ticketDTO.setTicket_Date(dateTimeAsDate);

                            // 중복 체크
                            int duplicateTicketCount = acschMapper.checkDuplicateTicket(ticketDTO.getShow_id(), ticketDTO.getTicket_date());
                            if (duplicateTicketCount == 0) {
                                ticketSet.add(ticketDTO);
                            } else {
                                System.out.println("Duplicate ticket found: " + ticketDTO);
                            }
                        } catch (DateTimeParseException e) {
                            System.out.println("Error parsing date: " + dateTime + " - " + e.getMessage());
                            continue;
                        }

                        for (int j = 2; j < cells.size(); j++) {
                            String actorName = cells.get(j).getText().trim(); // 여기서 공백 제거
                            if (!actorName.isEmpty()) {
                                String role = tableElement.findElement(By.cssSelector("th:nth-child(" + (j + 1) + ") span")).getText().trim(); // 여기서 공백 제거
                                String recentWork = title.replaceAll("[^a-zA-Z0-9가-힣]", ""); // 타이틀에서 특수문자 제거

                                System.out.println("actorName: " + actorName + ", recentWork: " + recentWork);

                                Integer actorId = findActorId(actorName, recentWork);
                                System.out.println("Found actorId: " + actorId + " for actorName: " + actorName + " with recentWork: " + recentWork);

                                if (actorId != null) {
                                    ShowCastingDTO showCastingDTO = new ShowCastingDTO();
                                    showCastingDTO.setShow_id(showId);
                                    showCastingDTO.setActor_id(actorId);
                                    showCastingDTO.setCasting(role);

                                    int duplicateCastingCount = acschMapper.checkDuplicateCasting(showCastingDTO.getShow_id(), showCastingDTO.getActor_id(), showCastingDTO.getCasting());
                                    if (duplicateCastingCount == 0) {
                                        showCastingSetDetail.add(showCastingDTO);
                                    } else {
                                        System.out.println("Duplicate casting found: " + showCastingDTO);
                                    }
                                } else {
                                    System.out.println("No actorId found for actorName: " + actorName + " with recentWork: " + recentWork);
                                }
                            }
                        }
                    }
                }

                // 티켓 정보 삽입
                for (TicketDTO ticket : ticketSet) {
                    acschMapper.insertTicket(ticket);
                    System.out.println("Inserted ticket_id: " + ticket.getTicket_id());
                }

                // 캐스팅 정보 삽입
                for (ShowCastingDTO showCasting : showCastingSet) {
                    int duplicateCount = acschMapper.checkDuplicateCasting(showCasting.getShow_id(), showCasting.getActor_id(), showCasting.getCasting());
                    if (duplicateCount == 0) {
                        acschMapper.insertShowCasting(showCasting);
                        System.out.println("Inserted casting_id: " + showCasting.getCasting_id());

                        // tb_acsch에 삽입할 DTO 생성
                        for (TicketDTO ticket : ticketSet) {
                            AcschDTO acschDTO = new AcschDTO();
                            acschDTO.setCasting_id(showCasting.getCasting_id());
                            acschDTO.setTicket_id(ticket.getTicket_id());
                            acschSet.add(acschDTO);
                        }
                    } else {
                        System.out.println("Duplicate casting found: showId=" + showCasting.getShow_id() + ", actorId=" + showCasting.getActor_id() + ", role=" + showCasting.getCasting());
                    }
                }

                // tb_acsch에 데이터 삽입
                for (AcschDTO acschDTO : acschSet) {
                    int duplicateAcschCount = acschMapper.checkDuplicateAcsch(acschDTO.getCasting_id(), acschDTO.getTicket_id());
                    if (duplicateAcschCount == 0) {
                        try {
                            acschMapper.insertAcsch(acschDTO);
                        } catch (Exception e) {
                            System.out.println("Error inserting acsch: " + e.getMessage());
                        }
                    } else {
                        System.out.println("Duplicate acsch found: " + acschDTO);
                    }
                }

            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        }

        driver.quit();
    }

    // findActorId 메서드 추가
    public Integer findActorId(String actorName, String recentWork) {
        // '뮤지컬'과 '연극'을 제거
        String cleanedRecentWork = recentWork.replaceAll("뮤지컬|연극", "");

        // 문자열을 2글자씩 나누어 keywords 리스트 생성
        List<String> keywords = Arrays.asList(cleanedRecentWork.split("(?<=\\G..)"));

        // MyBatis 매퍼에 전달할 파라미터 맵 생성
        Map<String, Object> params = new HashMap<>();
        params.put("actorName", actorName);
        params.put("keywords", keywords);

        // MyBatis 매퍼 메서드 호출
        return acschMapper.findActorIdByRecentWork(params);
    }
}

