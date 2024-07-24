<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.example.demo.seat.SeatReviewDTO"%>
<%@ page import="com.example.demo.seat.SeatDTO"%>
<%@ page import="com.example.demo.hall.HallDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seat Review</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <link rel="stylesheet" type="text/css" href="css/seatReview.css">
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <!-- 본문 시작 -->
        <div class="seat-review-container centered">
            <div class="seat-review-location">
                <h3>좌석위치: ${seat.s_floor} ${seat.s_number}</h3>
            </div>
            <div class="seat-review-button-container">
                <button class="seat-review-transparent-button" onclick="history.back()">
                    <span class="icon">⬅️</span><span>뒤로가기</span>
                </button>
                <button class="seat-review-transparent-button" onclick="location.href='comment?seat_id=${seat.seat_id}'">
                    <span class="icon">✏️</span><span>댓글 작성</span>
                </button>
            </div>
        </div>
        
        <div class="seat-review-content">
            <c:forEach items="${reviews}" var="review">
                <div class="seat-review-review-container">
                    <div class="seat-review-review-header">
                        <div class="seat-review-left">
                            <img src="https://via.placeholder.com/80" alt="Profile Image">
                        </div>
                        <div class="seat-review-right">
                            <div class="seat-review-profile">
                                <p>${review.user_id}</p>
                                <p><fmt:formatDate value="${review.date}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                            </div>
                            <div class="seat-review-star">
                                <span>평점: </span><span class="seat-review-stars">${review.seat_rank}</span>
                            </div>
                        </div>
                    </div>
                    <div class="seat-review-review-body">
                        <pre>${review.detail}</pre>
                    </div>
                </div>
            </c:forEach>
        </div>
        <br>
        <!-- 본문 끝 -->
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
