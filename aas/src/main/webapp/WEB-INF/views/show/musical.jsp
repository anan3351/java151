<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>musical</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
        <link rel="stylesheet" href="../css/template.css">
        <script src="../js/show.js"></script>
        <link rel="stylesheet" href="../css/show.css">
        <style>
            .musical-img {
                width: 150px;
                height: 200px;
                object-fit: cover;
            }
            .musical-card {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 150px;
                margin: 10px;
            }
            .musical-title {
                font-weight: bold;
                text-align: left;
                font-size: 14px; /* 기본 글씨 크기보다 5px 줄임 */
                margin-top: 5px;
                width: 100%;
                margin-left: 0; /* 왼쪽 여백 제거 */
            }
            .musical-info {
                text-align: left;
                color: gray;
                font-size: 12px; /* 기본 글씨 크기보다 5px 줄임 */
                width: 100%;
                margin-left: 0; /* 왼쪽 여백 제거 */
            }
            .musical-row {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-around;
            }
        </style>
    </head>

    <body>
        <%@ include file="../header.jsp" %>
        <div class="main-container"><br>
            <div style="font-size: 30px; font-weight: bold; text-align: center;">
                HOT&#128293;
            </div>
            <div class="container">
                <div class="swiper-container slider1">
                    <div class="swiper-wrapper">
                        <!-- 반복문을 사용하여 상위 10개의 이미지를 슬라이드로 표시 -->
                        <c:forEach var="musical" items="${musicals}" varStatus="status">
                            <c:if test="${status.index < 10}">
                                <div class="swiper-slide">
                                    <img class="musical-img" src="${musical.poster != null ? musical.poster : '../images/non.png'}" alt="${musical.title}">
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="swiper-button-next swiper-button-next1"></div>
                    <div class="swiper-button-prev swiper-button-prev1"></div>
                </div>

                <div>
                    <div style="font-size: 27px; font-weight: bold; text-align: center;">
                        전체 공연
                    </div><br>

                    <div class="container">
                        <div class="showall">
                            <div class="musical-row">
                                <!-- 공연 정보를 카드 형식으로 표시 -->
                                <c:forEach var="musical" items="${musicals}">
                                    <div class="musical-card">
                                        <img class="musical-img" src="${musical.poster != null ? musical.poster : '../images/non.png'}" alt="${musical.title}">
                                        <div class="musical-title">뮤지컬 ${musical.title}</div>
                                        <div class="musical-info">
                                            <c:choose>
                                                <c:when test="${musical.minihall != null}">
                                                    ${musical.h_name} - ${musical.minihall}
                                                </c:when>
                                                <c:otherwise>
                                                    ${musical.h_name}
                                                </c:otherwise>
                                            </c:choose>
                                            <br>
                                            ${fn:replace(musical.start_day, "-", "/")}~${fn:replace(musical.end_day, "-", "/")}
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <br><br><br>
                </div>
            </div>
        </div>
        <%@ include file="../footer.jsp" %>
    </body>
</html>
