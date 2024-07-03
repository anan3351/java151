package com.example.demo.show;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.w3c.dom.*;

public class ShowDAO {
	
	private DBOpen dbopen = null;
    private Connection con = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private StringBuilder sql = null;

    public ShowDAO(){ // DAO 생성시에 DB도 함께 연결
        dbopen = new DBOpen();
    }
    
    
    // XML에서 태그 값을 가져오는 메소드
    public String getTagValue(String tag, Document doc) {
        NodeList nodeList = doc.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent();
            }
        }
        return "";
    }
    
    public String getTagValue2(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent();
            }
        }
        return "";
    }

    
    // 공연 정보 insert
    public int create(Map<String, Object> map) {
        int cnt = 0;
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();
            
            sql.append(" insert into tb_show(show_id, title, hall_id, genre, start_day, end_day, runningtime, viewing_age, detail_img, poster) ");
            sql.append(" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
            
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, (String) map.get("show_id"));
            pstmt.setString(2, (String) map.get("title"));
            pstmt.setString(3, (String) map.get("hall_id"));
            pstmt.setString(4, (String) map.get("genre"));
            pstmt.setString(5, (String) map.get("start_day"));
            pstmt.setString(6, (String) map.get("end_day"));
            pstmt.setString(7, (String) map.get("runningtime"));
            pstmt.setString(8, (String) map.get("viewing_age"));
            pstmt.setString(9, (String) map.get("detail_img"));
            pstmt.setString(10, (String) map.get("poster"));
            
            cnt = pstmt.executeUpdate();

        } catch (Exception e) {
            System.out.println("공연 정보 추가 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt);
        }
        
        return cnt;
    }
    
    // 중복 데이터 필터링
    public boolean showIdExists(String showId) {
        boolean exists = false;
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();

            sql.append(" SELECT COUNT(*) FROM tb_show WHERE show_id = ? ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, showId);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            System.out.println("공연 ID 확인 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }

        return exists;
    }
    
    
    
    // 인터파크 크롤링 메소드
    public Map<String, String> interpart_data(String link){
    	// WebDriver와 ChromDriver 설정
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        Map<String, String> contentImagesMap = new HashMap<>();
        
        try {
            driver.get(link);

            // 데이터 추출
            List<WebElement> contentElements = driver.findElements(By.cssSelector(".prdContents.detail .content"));
            String casting = "";

            // content별 이미지 URL 추출하여 "\n"과 함께 map에 저장
            for (WebElement contentElement : contentElements) {
                StringBuilder images = new StringBuilder();
                String title = contentElement.findElement(By.tagName("h3")).getText();
                List<WebElement> contentDetailImages = contentElement.findElements(By.cssSelector(".contentDetail img"));

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
                            int width = Integer.parseInt(imgElement.getAttribute("width"));
                            int height = Integer.parseInt(imgElement.getAttribute("height"));
                            
                            // 두번째 이미지의 가로 길이가 세로 길이보다 긴지 체크
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
                            if (casting.equals("")) {
                            	casting = secondLargestImage.getAttribute("src");
                            } else {
                            	if (casting.equals(secondLargestImage.getAttribute("src"))) {
                            		break;
                            	} else {
                            		// 이전에 저장한 캐스팅 일정과 이번에 조회된 캐스팅 일정이 다르다면 값 누적
                            		casting += "\n" + secondLargestImage.getAttribute("src");
                            	}
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
            
            contentImagesMap.put("casting_img", casting);

            // 추출한 데이터 출력
            for (Map.Entry<String, String> entry : contentImagesMap.entrySet()) {
                System.out.println("title : " + entry.getKey());
                System.out.println("url : \n" + entry.getValue());
                System.out.println();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }
        
        return contentImagesMap;
    }
    
    // 예스24 크롤링 메소드
    public List<String> yes24_data(String link){
    	return null;
    }
    
    // 티켓링크 크롤링 메소드
    public List<String> ticketlink_data(String link){
    	return null;
    }
    
    
    
    
}
