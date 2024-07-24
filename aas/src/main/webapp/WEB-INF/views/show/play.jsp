<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>play</title>
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
            /* 링크 기본 스타일 제거 */
            a {
                text-decoration: none;
                color: inherit;
            }
        </style>
    </head>

    <body>
    <%@ include file="../header.jsp" %>
    <div class="main-container"><br>
        <div class="hot-section" style="font-size: 30px; font-weight: bold; text-align: center;">
            HOT&#128293;
        </div>
        <div class="container">
            <div class="swiper-container slider1">
                <div class="swiper-wrapper">
                    <c:forEach var="play" items="${plays}" varStatus="status">
                        <c:if test="${status.index < 10}">
                            <div class="swiper-slide">
                                <a href="/${play.show_id}">
                                    <c:choose>
                                        <c:when test="${play.poster != null}">
                                            <c:choose>
                                                <c:when test="${play.show_id.startsWith('SHOW')}">
                                                    <img class="show-img" src="../../storage/${play.poster}" onerror="this.src='../images/non.png';" alt="포스터">
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="show-img" src="${play.poster}" onerror="this.src='../images/non.png';" alt="포스터">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img class="show-img" src="../images/non.png" onerror="this.src='../images/non.png';" alt="포스터">
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                                <div class="text-container">
                                    <div class="item-name">${play.title}</div><div class="half-br"></div>
                                    <div class="item-hall">
                                        <c:choose>
                                            <c:when test="${play.minihall != null}">
                                                ${play.h_name} ${play.minihall}
                                            </c:when>
                                            <c:otherwise>
                                                ${play.h_name}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="item-date">
                                        ${fn:replace(play.start_day, "-", "/")}~${fn:replace(play.end_day, "-", "/")}
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="swiper-button-next swiper-button-next1"></div>
                <div class="swiper-button-prev swiper-button-prev1"></div>
            </div>

            <div class="all-shows-section">
                <div style="font-size: 27px; font-weight: bold; text-align: center;">
                    전체 공연
                </div>

                <div class="container">
                    <div class="showall">
                        <div class="show-row">
                            <c:forEach var="play" items="${plays}">
                                <div class="show-card">
                                    <a href="/${play.show_id}">
                                        <c:choose>
                                            <c:when test="${not empty play.poster}">
                                                <c:choose>
                                                    <c:when test="${play.show_id.startsWith('SHOW')}">
                                                        <img class="show-img" src="../../storage/${play.poster}" onerror="this.src='../images/non.png';" style="width: 140px; height: 193px">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="show-img" src="${play.poster}" onerror="this.src='../images/non.png';" style="width: 140px; height: 193px">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <img class="show-img" src="../images/non.png" onerror="this.src='../images/non.png';" style="width: 140px; height: 193px">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <a href="/${play.show_id}">
                                        <div class="show-title">연극 &#60;${play.title}></div>
                                    </a>
                                    <div class="half-br"></div>
                                    <div class="show-info">
                                        <c:choose>
                                            <c:when test="${play.minihall != null}">
                                                ${play.h_name} ${play.minihall}
                                            </c:when>
                                            <c:otherwise>
                                                ${play.h_name}
                                            </c:otherwise>
                                        </c:choose>
                                        <br>
                                        ${fn:replace(play.start_day, "-", "/")}~${fn:replace(play.end_day, "-", "/")}
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
