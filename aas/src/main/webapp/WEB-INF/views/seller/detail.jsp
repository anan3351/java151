<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Seller Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <link rel="stylesheet" href="/css/seller.css">
    <script src="/js/seller.js"></script>
    <title>Show Detail</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <%@ include file="./sidebar.jsp" %>
        <main>
            <br>
            <div style="font-size: 20px; font-weight: bold; text-align: center;">
                공연 상세정보
            </div><br><br>

            <div class="show-details">
                <div class="show-poster">
                    <c:if test="${not empty show.poster}">
                        <c:choose>
                            <c:when test="${show.show_id.startsWith('SHOW')}">
                                <img src="../../storage/${show.poster}" alt="포스터">
                            </c:when>
                            <c:otherwise>
                                <img src="${show.poster}" alt="포스터">
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
                <div class="show-info">
                    <div style="font-size: 20px; font-weight: bold;">${show.genre} <${show.title}></div><br>
                    <ul>
                        <li class="list"><strong>공연코드</strong>${show.show_id}</li>
                        <c:choose>
                            <c:when test="${not empty show.miniHall}">
                                <li class="list"><strong>공연장</strong>${show.h_name} - ${show.miniHall}</li>
                            </c:when>
                            <c:otherwise>
                                <li class="list"><strong>공연장</strong>${show.h_name}</li>
                            </c:otherwise>
                        </c:choose>
                        <li class="list"><strong>캐스팅</strong>${show.s_cast}</li>
                        <li class="list"><strong>시작일</strong><fmt:formatDate value="${show.start_day}" pattern="yyyy-MM-dd"/></li>
                        <li class="list"><strong>종료일</strong><fmt:formatDate value="${show.end_day}" pattern="yyyy-MM-dd"/></li>
                        <li class="list"><strong>러닝타임</strong>${show.runningtime}</li>
                        <li class="list"><strong>관람가</strong>${show.viewing_age}</li>
                        <li class="list"><strong>예매처</strong><a href="http://localhost:9095/seller/detail/PF239896">http://localhost:9095/seller/detail/PF239896</a></li>
                        <li class="list"><strong>가격 </strong><span class="lPointer" onclick="priceList('${show.show_id}')" style="margin-left: 0">전체가격보기▶</span></li>
                        <c:forEach items="${priceList}" var="price">
                            <li class="list"><strong></strong>${price.seat_level} <fmt:formatNumber value="${price.price}" pattern="#,###" />원</li>
                        </c:forEach>
                    </ul><br>
                    <input type="button" class="btn btn-default" value="공연정보 수정" onclick="window.location.href='./${show.show_id}/castList'">
                    <input type="button" class="btn btn-default" value="캐스트 관리" onclick="window.location.href='./${show.show_id}/castList'">
                    <input type="button" class="btn btn-default" value="좌석금액" onclick="window.location.href='./${show.show_id}/priList'">
                    <input type="button" class="btn btn-default" value="할인율" onclick="window.location.href='./${show.show_id}/disList'">
                    <input type="button" class="btn btn-default" value="목록" onclick="window.location.href='javascript:history.back()'">
                </div>
            </div>
            <br><hr><br><br>

            <div class="show-images">
                <c:forEach items="${imgMap}" var="entry">
                    <c:if test="${not empty entry.value}">
                        <c:forEach items="${entry.value}" var="imgSrc">
                            <c:if test="${not empty imgSrc}">
                            	<c:choose>
		                            <c:when test="${show.show_id.startsWith('SHOW')}">
		                                <div style="font-size: 20px; font-weight: bold; text-align: center;">${entry.key}</div><br>
                                		<img src="../../storage/${imgSrc}">
		                            </c:when>
		                            <c:otherwise>
		                                <div style="font-size: 20px; font-weight: bold; text-align: center;">${entry.key}</div><br>
                                		<img src="${imgSrc}">
		                            </c:otherwise>
		                        </c:choose>
                            </c:if>
                        </c:forEach><br><br><br>
                    </c:if>
                </c:forEach>
            </div>
        </main>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
