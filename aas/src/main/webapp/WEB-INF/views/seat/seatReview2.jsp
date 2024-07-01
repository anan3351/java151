<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.seat.SeatReviewDTO" %>
<%@ include file="../header.jsp" %>

<%
    List<SeatReviewDTO> reviews = (List<SeatReviewDTO>) request.getAttribute("reviews");
%>

<link rel="stylesheet" type="text/css" href="css/seatReview.css">

<div class="header-info">
    <h3 class="title">공연제목(프랑켄슈타인)</h3>
    <hr>
</div>

<div class="container centered">
    <div class="seat-location">
        <h3>좌석위치(1층1행1번)</h3>
    </div>
    <div class="button-container">
        <button class="transparent-button" onclick="history.back()">
            <span class="icon">⬅️</span><span>뒤로가기</span>
        </button>
        <button class="transparent-button" onclick="location.href='comment'">
            <span class="icon">✏️</span><span>댓글 작성</span>
        </button>
    </div>
</div>

<div class="content">
    <% if (reviews != null) { %>
        <% for (SeatReviewDTO review : reviews) { %>
            <div class="review-container">
                <div class="review-header">
                    <div class="left">
                        <img src="https://via.placeholder.com/80" alt="Profile Image">
                    </div>
                    <div class="right">
                        <div class="profile">
                            <p><%= review.getUserId() %></p>
                            <p>(<%= review.getDate() %>)</p>
                        </div>
                        <div class="star">
                            <span>평점: </span><span class="stars"><%= "★".repeat(review.getSeatRank()) %></span>
                        </div>
                    </div>
                </div>
                <div class="review-body">
                    <pre><%= review.getDetail() %></pre>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <p>후기를 불러오는 중 문제가 발생했습니다.</p>
    <% } %>
</div>
<br>
<%@ include file="../footer.jsp" %>
