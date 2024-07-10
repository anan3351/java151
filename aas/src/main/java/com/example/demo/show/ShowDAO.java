package com.example.demo.show;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
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

            sql.append(" insert into tb_show(show_id, title, hall_id, genre, s_cast, start_day, end_day, runningtime, viewing_age, detail_img, poster) ");
            sql.append(" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, (String) map.get("show_id"));
            pstmt.setString(2, (String) map.get("title"));
            pstmt.setString(3, (String) map.get("hall_id"));
            pstmt.setString(4, (String) map.get("genre"));
            pstmt.setString(5, (String) map.get("cast"));
            pstmt.setString(6, (String) map.get("start_day"));
            pstmt.setString(7, (String) map.get("end_day"));
            pstmt.setString(8, (String) map.get("runningtime"));
            pstmt.setString(9, (String) map.get("viewing_age"));
            pstmt.setString(10, (String) map.get("detail_img"));
            pstmt.setString(11, (String) map.get("poster"));

            cnt = pstmt.executeUpdate();

        } catch (Exception e) {
            System.out.println("공연 정보 추가 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt);
        }

        return cnt;
    }



    // 캐스트 확인
    public String cast(String id) {
        String cast = "";
        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();
            sql.append("SELECT s_cast FROM tb_show WHERE show_id = ?");
            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                cast = rs.getString("s_cast");
            }
        } catch (Exception e) {
            System.out.println("목록 불러오기 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }
        return cast;
    }

    // 누락된 캐슷 복구용
    public int update2(Map<String, Object> map, String id) {
        int cnt = 0;
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dbopen.getConnection();
            String currentCast = cast(id);

            // 현재 cast가 비어 있는 경우에만 업데이트 진행
            if (currentCast == null || currentCast.trim().isEmpty()) {
                StringBuilder sql = new StringBuilder();
                sql.append("UPDATE tb_show SET s_cast = ? ");
                sql.append("WHERE show_id = ?");

                pstmt = con.prepareStatement(sql.toString());
                pstmt.setString(1, (String) map.get("cast"));
                pstmt.setString(2, (String) map.get("show_id"));

                cnt = pstmt.executeUpdate();

                if (cnt == 1) {
                    System.out.println("ID : " + id + ", 업데이트 성공");
                } else {
                    System.out.println("ID : " + id + ", 업데이트 실패");
                }
            } else {
                System.out.println("ID : " + id + ", 현재 cast가 존재하여 업데이트 불필요");
            }

        } catch (Exception e) {
            System.out.println("공연 상세정보 업데이트 실패 : " + e.getMessage());
        } finally {
            DBClose.close(con, pstmt);
        }

        return cnt;
    }


    // 공연 상세정보 update
    public int update(Map<String, String> map, String id, String store) {
        int cnt = 0;
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dbopen.getConnection();
            String currentCast = cast(id); // 기존 db의 캐스트
            String mapCast = map.get("cast"); // 스크래핑한 캐스트
            String cast = null;

            if (mapCast != null && (currentCast == null || mapCast.length() < currentCast.length())) {
                cast = currentCast;
            } else {
                cast = mapCast;
            }

            StringBuilder sql = new StringBuilder();
            sql.append("UPDATE tb_show SET notice_img = ?, casting_img = ?, s_cast = ?, detail_img = ?, dis_img = ?, store = ?");
            sql.append("WHERE show_id = ?");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, map.get("notice_img"));
            pstmt.setString(2, map.get("casting_img"));
            pstmt.setString(3, cast);
            pstmt.setString(4, map.get("detail_img"));
            pstmt.setString(5, map.get("dis_img"));
            pstmt.setString(6, store);
            pstmt.setString(7, map.get("showID"));

            cnt = pstmt.executeUpdate();

            if (cnt == 1) {
                System.out.println("ID : " + id + ", 업데이트 성공");
            } else {
                System.out.println("ID : " + id + ", 업데이트 실패");
            }

        } catch (Exception e) {
            System.out.println("공연 상세정보 업데이트 실패 : " + e.getMessage());
        } finally {
            DBClose.close(con, pstmt);
        }

        return cnt;
    }


    public int update(String id, String store) {
        int cnt = 0;
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dbopen.getConnection();

            StringBuilder sql = new StringBuilder();
            sql.append("UPDATE tb_show SET store = ?");
            sql.append("WHERE show_id = ?");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, store);
            pstmt.setString(2, id);

            cnt = pstmt.executeUpdate();

            if (cnt == 1) {
                System.out.println("ID : " + id + ", 업데이트 성공");
            } else {
                System.out.println("ID : " + id + ", 업데이트 실패");
            }

        } catch (Exception e) {
            System.out.println("공연 상세정보 업데이트 실패 : " + e.getMessage());
        } finally {
            DBClose.close(con, pstmt);
        }

        return cnt;
    }




    // 공연장 - 관 이름 찾는 필터(hall_id 이용)
    public List<String> theater_search(String theater) {
        List<String> theater_name = new ArrayList<>();

        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();

            sql.append("SELECT h_name, miniHall FROM tb_hall WHERE hall_id = ? ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, theater);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String h_name = rs.getString("h_name"); // 공연장 이름
                String miniHall = rs.getString("miniHall"); // 세부관 이름

                theater_name.add(h_name);
                theater_name.add(miniHall);
            } else {
                // 공연 상세정보에는 공연장ID가 있으나, 공연장에서 해당 아이디를 찾을 수 없는 경우
                theater_name.add("정보없음");
                theater_name.add("");
            }

        } catch (Exception e) {
            System.out.println("공연장 조회 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }

        return theater_name;
    }



    // 관 ID 조회
    public String mini_search(String mini) {
        String hall_id = null;

        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();

            sql.append("SELECT hall_id FROM tb_hall WHERE miniHall = ? ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, mini);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                hall_id = rs.getString("hall_id");
            }

        } catch (Exception e) {
            System.out.println("세부 공연장 조회 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }

        return hall_id;
    }


    // hall_id 검색 -> 값이 딱 두개 나온다면 "-"가 붙은걸로 저장
    public String mini_search2(String theater) {
        String hall_id = null;
        int cnt = 0;

        try {
            con = dbopen.getConnection();
            sql = new StringBuilder();

            sql.append("SELECT count(hall_id) as cnt FROM tb_hall WHERE hall_id LIKE ? ");

            pstmt = con.prepareStatement(sql.toString());
            pstmt.setString(1, theater + "%");

            rs = pstmt.executeQuery();

            if (rs.next()) {
                cnt = rs.getInt("cnt");
            }

            if (cnt == 2) {
                // 자원 정리
                rs.close();
                pstmt.close();

                sql = new StringBuilder();
                sql.append("SELECT hall_id FROM tb_hall WHERE hall_id LIKE ? ");

                pstmt = con.prepareStatement(sql.toString());
                pstmt.setString(1, theater + "-%");

                rs = pstmt.executeQuery();

                if (rs.next()) {
                    hall_id = rs.getString("hall_id");
                }
            } else {
                hall_id = null;
            }

        } catch (Exception e) {
            System.out.println("세부 공연장 조회 실패 : " + e);
        } finally {
            DBClose.close(con, pstmt, rs);
        }

        return hall_id;
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
    public Map<String, String> interpart_data(String link) {
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        Map<String, String> contentImagesMap = new HashMap<>();

        try {
            String url = link;
            driver.get(url);

            // 팝업 닫기
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
            contentImagesMap.put("cast", act);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }

        return contentImagesMap;
    }

    // 예스24 크롤링 메소드
    public Map<String, String> yes24_data(String link){
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // 10초간 대기
        Map<String, String> sectionImages = new HashMap<>();

        try {
            driver.get(link);

            // 팝업 닫기
            try {
                List<WebElement> closeButtons = driver.findElements(By.cssSelector(".common_modal_close"));
                if (!closeButtons.isEmpty()) {
                    WebElement closeButton = closeButtons.get(0);
                    closeButton.click();
                }
            } catch (Exception e) {
                System.out.println("팝업 닫기 오류: " + e.getMessage());
            }

            // 클래스 순회
            for (int i = 1; i <= 4; i++) {
                String sectionSelector = String.format(".rn-080%d", i);
                WebElement section = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(sectionSelector)));

                // 섹션 타이틀 추출
                String sectionTitle = section.findElement(By.cssSelector("p.rn08-tit")).getText();
                if (sectionTitle.equals("유의사항")) {
                    sectionTitle = "notice_img";
                } else if (sectionTitle.equals("할인정보")) {
                    sectionTitle = "dis_img";
                } else if (sectionTitle.equals("공연정보")) {
                    sectionTitle = "detail_img";
                } else if (sectionTitle.equals("캐스팅 일정")) {
                    sectionTitle = "casting_img";
                }


                // 값(이미지) 추출
                // 이미지 요소가 나타날 때까지 반복 시도(로딩 대기)
                for (int attempt = 0; attempt < 2; attempt++) {
                    List<WebElement> imgElements = section.findElements(By.cssSelector("img"));
                    if (!imgElements.isEmpty()) { // 이미지 요소가 비었는지 확인
                        StringBuilder imgUrlsBuilder = new StringBuilder();
                        for (WebElement imgElement : imgElements) {
                            imgUrlsBuilder.append(imgElement.getAttribute("src")).append("\n");
                        }
                        String imgUrls = imgUrlsBuilder.toString().trim();
                        sectionImages.put(sectionTitle, imgUrls);
                        break;
                    } else if (attempt < 1) { // 추가 대기시간 부여
                        Thread.sleep(2000); // 2초 대기 후 다시 시도
                    }
                }
            }


            // 배우 이름 추출
            WebElement castSection = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".rn-product-area1 dt:nth-of-type(3) + dd"))); // 세번째 요소에서 추출
            List<WebElement> cast = castSection.findElements(By.cssSelector("a"));
            StringBuilder actors = new StringBuilder();

            for (int i = 0; i < cast.size(); i++) {
                String actorName = cast.get(i).getText();

                if (i != cast.size() - 1) actors.append(actorName).append(", ");
                else actors.append(actorName);
            }

            sectionImages.put("cast", actors.toString());

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }

        return sectionImages;
    }

    // 티켓링크 크롤링 메소드
    public Map<String, String> ticketlink_data(String link) {
        System.setProperty("webdriver.chrome.driver", "src/main/resources/driver/chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20)); // 대기 시간을 20초로 늘림
        Map<String, String> contentImagesMap = new HashMap<>();

        try {
            driver.get(link);
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
                contentImagesMap.put("cast", actors.toString());
            } catch (Exception e) {}

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit(); // WebDriver 종료
        }


        return contentImagesMap;
    }





}
