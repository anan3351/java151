package com.example.demo.show;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.*;

public class Ticketlink {
    public static void main(String[] args) {
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20)); // 대기 시간을 20초로 늘림
        Map<String, String> contentImagesMap = new HashMap<>();

        try {
            driver.get("https://www.ticketlink.co.kr/product/14015");
            String casting = "";

            // 팝업창 닫기
            try {
                WebElement popupCloseButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@class='common_modal']//button[@class='common_modal_close']")));
                if (popupCloseButton != null) {
                    popupCloseButton.click();
                }
            } catch (Exception e) {}

            // 공지사항, 할인 정보 추출
            try {
                List<WebElement> noticeElements = wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath("//h3[text()='공지사항']/following-sibling::div[@class='product_editor']//img")));
                List<WebElement> discountElements = wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath("//h3[text()='할인 정보']/following-sibling::div[@class='product_editor']//img")));

                // 공지사항 이미지 추출
                if (!noticeElements.isEmpty()) {
                    Set<String> discountImageUrls = new HashSet<>();
                    StringBuilder noticeImages = new StringBuilder();

                    // 할인 정보 이미지 URL 모으기
                    for (WebElement imgElement : discountElements) {
                        discountImageUrls.add(imgElement.getAttribute("src"));
                    }

                    for (WebElement imgElement : noticeElements) {
                        String imgUrl = imgElement.getAttribute("src");

                        // 할인 정보 이미지와 중복되는 경우 제외
                        if (!discountImageUrls.contains(imgUrl)) {
                            noticeImages.append(imgUrl).append("\n");
                        }
                    }
                    contentImagesMap.put("notice_img", noticeImages.toString().trim());
                }

                // 할인 정보 이미지 추출
                if (!discountElements.isEmpty()) {
                    StringBuilder discountImages = new StringBuilder();
                    for (WebElement imgElement : discountElements) {
                        discountImages.append(imgElement.getAttribute("src")).append("\n");
                    }
                    contentImagesMap.put("dis_img", discountImages.toString().trim());
                }
            } catch (Exception e) {}

            // 작품상세정보 추출
            try {
                WebElement detailSection = wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".product_templete")));
                List<WebElement> detailImages = detailSection.findElements(By.tagName("img"));
                StringBuilder detailImageUrls = new StringBuilder();

                if (!detailImages.isEmpty()) {
                    WebElement largestImage = null;
                    WebElement secondLargestImage = null;
                    int largestHeight = Integer.MIN_VALUE;
                    int secondLargestHeight = Integer.MIN_VALUE;

                    for (WebElement imgElement : detailImages) {
                        int height = Integer.parseInt(imgElement.getAttribute("height"));

                        if (height > largestHeight) {
                            secondLargestHeight = largestHeight;
                            largestHeight = height;
                            secondLargestImage = largestImage;
                            largestImage = imgElement;
                        } else if (height > secondLargestHeight) {
                            secondLargestHeight = height;
                            secondLargestImage = imgElement;
                        }
                    }

                    if (secondLargestImage != null) {
                        casting = secondLargestImage.getAttribute("src");
                    }

                    for (WebElement imgElement : detailImages) {
                        if (!imgElement.equals(secondLargestImage)) {
                            detailImageUrls.append(imgElement.getAttribute("src")).append("\n");
                        }
                    }

                    contentImagesMap.put("detail_img", detailImageUrls.toString().trim());
                    contentImagesMap.put("casting_img", casting);
                }
            } catch (Exception e) {}

            // 배우 정보 저장
            try {
                Set<String> cast = new LinkedHashSet<>();

                while (true) {
                    List<WebElement> castList = driver.findElements(By.cssSelector(".product_casting_name"));
                    if (castList.isEmpty()) break; // 출연진 정보가 없으면 종료

                    for (WebElement castElement : castList) {
                        String actorName = castElement.getText().trim();
                        if (!actorName.isEmpty()) {
                            cast.add(actorName);
                        }
                    }

                    // 다음 버튼 클릭 여부 확인
                    List<WebElement> nextButtons = driver.findElements(By.cssSelector(".casting-list-swiper-next"));
                    if (!nextButtons.isEmpty()) {
                        WebElement nextButton = nextButtons.get(0);
                        if (nextButton.isEnabled()) {
                            nextButton.click();
                            Thread.sleep(1000); // 클릭 후 잠시 대기
                        } else {
                            break; // 다음 버튼이 비활성화되면 반복 종료
                        }
                    } else {
                        break; // 다음 버튼이 없으면 반복 종료
                    }
                }

                // 출연진 정보 문자열로 변환하여 저장
                StringBuilder actors = new StringBuilder();
                for (String actor : cast) {
                    if (actors.length() > 0) {
                        actors.append(", ");
                    }
                    actors.append(actor);
                }
                if (!actors.toString().isEmpty()) {
                    contentImagesMap.put("cast", actors.toString());
                }
            } catch (Exception e) {}

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }

        // 추출한 데이터를 출력하거나 다른 용도로 사용
        for (Map.Entry<String, String> entry : contentImagesMap.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
    }
}
