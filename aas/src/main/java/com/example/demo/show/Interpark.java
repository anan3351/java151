package com.example.demo.show;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Interpark {
    public static void main(String[] args) {
        // WebDriver와 ChromDriver 설정
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        Map<String, String> contentImagesMap = new HashMap<>();
        
        try {
            String url = "https://tickets.interpark.com/goods/17018084";
            driver.get(url);
            
            // 팝업 닫기
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            try {
                List<WebElement> closeButtons = driver.findElements(By.cssSelector(".popupCloseBtn.is-bottomBtn"));
                if (!closeButtons.isEmpty()) {
                    WebElement closeButton = closeButtons.get(0);
                    closeButton.click();
                }
            } catch (Exception e) { System.out.println("error : " + e); }

            
            // 데이터 추출
            List<WebElement> contentElements = driver.findElements(By.cssSelector(".prdContents.detail .content"));
            String casting = "";

            // content별 이미지 URL 추출하여 "\n"과 함께 map에 저장
            for (WebElement contentElement : contentElements) {
                StringBuilder images = new StringBuilder();
                String title = contentElement.findElement(By.tagName("h3")).getText();
                
                // 바리케이트 없을 때 사용하는 코드
                List<WebElement> contentDetailImages = contentElement.findElements(By.cssSelector(".contentDetail img"));
                
                
                /*
                // 바리케이트 -> 속도 저하 문제 발생
                List<WebElement> contentDetailImages = null;
                
                for (int attempt = 0; attempt < 3; attempt++) {
                    contentDetailImages = contentElement.findElements(By.cssSelector(".contentDetail img"));
                    if (!contentDetailImages.isEmpty()) {
                        break;
                    } else if (attempt < 2) {
                        Thread.sleep(2000); // 2초 대기 후 다시 시도
                    }
                }
                */
                

                // img 요소가 존재할 때만 map에 저장
                if (!contentDetailImages.isEmpty()) {

                    // 캐스팅 이미지 따로 저장
                    if (title.equals("공연상세 / 캐스팅일정")) {
                        int largestHeight = Integer.MIN_VALUE;
                        int secondLargestHeight = Integer.MIN_VALUE;
                        WebElement largestImage = null;
                        WebElement secondLargestImage = null;

                        // 캐스팅 이미지 추출
                        for (WebElement imgElement : contentDetailImages) {
                            int height = Integer.parseInt(imgElement.getAttribute("height"));
                            
                            // 이미지 길이 비교 -> 두번째로 긴 이미지 추출
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

                        // 두 번째로 큰 이미지가 캐스팅 이미지로 선택됨
                        if (secondLargestImage != null) {
                            if (casting.equals("")) casting = secondLargestImage.getAttribute("src");
                            else {
                            	if (casting.equals(secondLargestImage.getAttribute("src"))) break;
                            	else casting += "\n" + secondLargestImage.getAttribute("src"); // 이전에 저장한 캐스팅 일정과 이번에 조회된 캐스팅 일정이 다르다면 값 누적
                            }
                        }
                        
                        // 모든 이미지 URL을 저장 (캐스팅 이미지는 제외)
                        for (WebElement imgElement : contentDetailImages) {
                            if (imgElement != secondLargestImage) {
                            	images.append(imgElement.getAttribute("src"));
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
                    
                    if (title.equals("공지사항")) {
                    	title = "notice_img";
                    } else if (title.equals("공연상세 / 캐스팅일정")) {
                    	title = "detail_img";
                    } else if (title.equals("할인정보")) {
                    	title = "dis_img";
                    }
                    
                    contentImagesMap.put(title, image);
                }
            }
            
            // 캐스팅 일정 이미지
            if (!casting.trim().isEmpty()) {
                contentImagesMap.put("casting_img", casting);
            }

            // 전체 캐스트 확인하기 위해 '더보기' 버튼 클릭
            try {
                List<WebElement> moreButton = driver.findElements(By.cssSelector("a.contentToggleBtn"));
                if (!moreButton.isEmpty()) {
                    WebElement more = moreButton.get(0);
                    more.click();
                }
            } catch (Exception e) { System.out.println("error : " + e); }

            // 배우 이름 추출
            List<WebElement> cast = driver.findElements(By.cssSelector(".castingItem .castingName"));
            StringBuilder actors = new StringBuilder();

            for (int i=0; i<cast.size(); i++) {
                String actorName = cast.get(i).getText().trim();
                
                if(i!=cast.size()-1) actors.append(actorName + ", ");
                else actors.append(actorName);
            }

            String act = actors.toString();
            if (!act.isEmpty()){
                contentImagesMap.put("cast", act);
            }

            // 데이터 확인
            for (Map.Entry<String, String> entry : contentImagesMap.entrySet()) {
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
