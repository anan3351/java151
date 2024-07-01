<%@page import="java.util.List"%>
<%@page import="com.example.demo.seat.SeatReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<link rel="stylesheet" href="/css/template.css"> 
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div class="main-container">
		<!-- 본문시작 -->
		<%
            List<SeatReviewDTO> reviews = (List<SeatReviewDTO>) request.getAttribute("reviews");
        %>
        
        <link rel="stylesheet" type="text/css" href="css/seatReview.css">
        
        <div class="header-info">
            <h3 class="title">공연제목(프랑켄슈타인)</h3>
            <hr>
        </div>
        
        <div class="seat-review-container centered">
            <div class="seat-review-location">
                <h3>좌석위치(1층1행1번)</h3>
            </div>
            <div class="seat-review-button-container">
                <button class="seat-review-transparent-button" onclick="history.back()">
                    <span class="icon">⬅️</span><span>뒤로가기</span>
                </button>
                <button class="seat-review-transparent-button" onclick="location.href='comment'">
                    <span class="icon">✏️</span><span>댓글 작성</span>
                </button>
            </div>
        </div>
        
        <div class="seat-review-content">
            <% if (reviews != null) { %>
                <% for (SeatReviewDTO review : reviews) { %>
                    <div class="seat-review-review-container">
                        <div class="seat-review-review-header">
                            <div class="seat-review-left">
                                <img src="https://via.placeholder.com/80" alt="Profile Image">
                            </div>
                            <div class="seat-review-right">
                                <div class="seat-review-profile">
                                    <p><%= review.getUserId() %></p>
                                    <p>(<%= review.getDate() %>)</p>
                                </div>
                                <div class="seat-review-star">
                                    <span>평점: </span><span class="seat-review-stars"><%= "★".repeat(review.getSeatRank()) %></span>
                                </div>
                            </div>
                        </div>
                        <div class="seat-review-review-body">
                            <pre><%= review.getDetail() %></pre>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <p>후기를 불러오는 중 문제가 발생했습니다.</p>
            <% } %>
        </div>
		<br>
		<!-- 본문 끝 -->
	</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>
