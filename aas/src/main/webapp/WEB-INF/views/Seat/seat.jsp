<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/template.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="../view/template.css">
    <link rel="stylesheet" href="/css/template.css">
    <style>
        .seat-info {
            text-align: center;
            margin: 20px auto;
        }
        .seat-map {
            display: grid;
            grid-template-columns: repeat(20, 40px); /* 좌석 20칸 */
            gap: 10px; /* 여백 설정 */
            justify-content: center;
        }
        .seat {
            width: 40px;
            height: 40px;
            background-color: #D8D8D8;
            border: 1px solid #A9A9A9;
            border-radius: 5px;
            line-height: 40px;
            text-align: center;
            cursor: pointer;
        }
        .seat.vip {
            background-color: #FFD700;
        }
        .seat.standard {
            background-color: #ADD8E6;
        }
        .seat.empty {
            background-color: transparent;
            border: none;
        }
        .stage {
            grid-column: span 20;
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px 0;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .floor-links {
            text-align: left;
            margin-bottom: 20px;
        }
        .floor-links a {
            margin-right: 10px;
            text-decoration: none;
            color: black; /* 글자색을 검은색으로 변경 */
            font-size: 1.5em; /* 글자 크기를 2단계 키움 */
        }
        .floor-links a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function goToSeatReview(seatId) {
            window.location.href = '/seatReview?seat_id=' + seatId;
        }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <!-- 층 링크 -->
        <div class="floor-links">
            <c:forEach items="${floors}" var="floor">
                <a href="/seat?hall_id=${param.hall_id}&floor=${floor}">${floor}</a>
            </c:forEach>
        </div>
        <!-- 본문 시작 -->
        <div class="seat-info">
            <h2>${currentFloor} 좌석 정보</h2>
            <c:if test="${not empty seatInfo}">
                <div class="seat-map">
                    <div class="stage">Stage</div>
                    <c:forEach items="${seatInfo}" var="seat">
                        <div class="seat ${seat.seat_level.toLowerCase()}" onclick="goToSeatReview('${seat.seat_id}')">
                            ${seat.s_number}
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty seatInfo}">
                <p>좌석 정보가 없습니다.</p>
            </c:if>
        </div>
        <!-- 본문 끝 -->
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
