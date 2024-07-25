<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<link rel="stylesheet" href="/css/template.css"> 
<link rel="stylesheet" href="/css/seller.css">
<script src="/js/seller.js"></script>
<style>
    .main-container {
        max-width: 50%;  /* 원하는 너비로 설정 */
        margin: 0 auto; /* 중앙 정렬을 위한 자동 좌우 여백 */
        display: flex;
        flex-direction: column;
        align-items: center; /* 수평 중앙 정렬 */
        padding: 20px;
        margin-top: 20px; /* 상단 여백 추가 */
        background-color: white; /* 배경색 추가 */
        border-radius: 10px; /* 모서리 둥글게 추가 */
        box-shadow: 0 0 10px rgba(0,0,0,0.1); /* 그림자 추가 */
    }

    main {
        width: 100%; /* 전체 너비 사용 */
        max-width: 1200px; /* 최대 너비 설정 */
    }
    
</style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <main>
            <br>
            <div style="font-size: 20px; font-weight: bold; text-align: center;">
                공연 상세정보
            </div><br>
            <input type="button" class="btn btn-default" value="목록" onclick="window.location.href='javascript:history.back()'" style="float: right;">

            <div class="show-details">
                <div class="show-poster">
                    <c:choose>
                        <c:when test="${empty show.poster}">
                            <img class="show-img" src="../images/non.png" alt="포스터 없음">
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${show.show_id.startsWith('SHOW')}">
                                    <img class="show-img" src="../../storage/${show.poster}" onerror="this.src='../images/non.png';" alt="포스터">
                                </c:when>
                                <c:otherwise>
                                    <img class="show-img" src="${show.poster}" onerror="this.src='../images/non.png';" alt="포스터">
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="show-info">
                    <div style="font-size: 20px; font-weight: bold;">${show.genre} <${show.title}></div><br>
                    <ul>
                        <c:choose>
                            <c:when test="${not empty show.miniHall}">
                                <li class="list"><strong>공연장</strong>${show.h_name} - ${show.miniHall}</li>
                            </c:when>
                            <c:otherwise>
                                <li class="list"><strong>공연장</strong>${show.h_name}</li>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty show.s_cast.trim()}">
                                <li class="list"><strong>캐스팅</strong>${show.s_cast}</li>
                            </c:when>
                            <c:otherwise>
                                <li class="list"><strong>캐스팅</strong>-</li>
                            </c:otherwise>
                        </c:choose>
                        <li class="list"><strong>시작일</strong><fmt:formatDate value="${show.start_day}" pattern="yyyy-MM-dd"/></li>
                        <li class="list"><strong>종료일</strong><fmt:formatDate value="${show.end_day}" pattern="yyyy-MM-dd"/></li>
                        <li class="list"><strong>러닝타임</strong>${show.runningtime}</li>
                        <li class="list"><strong>관람가</strong>${show.viewing_age}</li>
                        <c:choose>
                            <c:when test="${show.user_id != null}">
                                <li class="list"><strong>예매</strong>
                                    <input type="button" class="btn btn-default" value="예매하기" onclick="window.location.href='${show.store}'">
                                </li>
                                <li class="list"><strong>가격 </strong>
                                    <span class="lPointer" onclick="priceList2('${show.show_id}')" style="margin-left: 0">전체가격보기▶</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${not empty show.store.trim()}">
                                        <li class="list"><strong>예매처</strong>${show.store}</li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="list"><strong>예매처</strong>-</li>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach items="${priceList}" var="price">
                            <li class="list"><strong></strong>${price.seat_level} <fmt:formatNumber value="${price.price}" pattern="#,###" />원</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <hr><br>

            <div class="show-images">
                <c:forEach items="${imgMap}" var="entry">
                    <c:if test="${not empty entry.value}">
                        <c:forEach items="${entry.value}" var="imgSrc" varStatus="status">
                            <c:if test="${status.first}">
                                <div style="font-size: 20px; font-weight: bold; text-align: center;">${entry.key}</div><br>
                            </c:if>
                            <img src="${imgSrc}"><br>
                        </c:forEach><br><br><br>
                    </c:if>
                </c:forEach>
            </div>
        </main>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
