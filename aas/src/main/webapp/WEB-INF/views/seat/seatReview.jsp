<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.seat.SeatReviewDTO" %>
<%@ include file="../header.jsp" %>

<%
    List<SeatReviewDTO> reviews = (List<SeatReviewDTO>) request.getAttribute("reviews");
%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap');

    body {
        font-family: 'Noto Sans KR', Arial, sans-serif;
        background-color: #f9f9f9;
        color: #333;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }
    .header-info {
        margin: 20px;
        text-align: left;
    }
    .header-info h3 {
        font-size: 2.5em;
        font-weight: 700;
        margin: 0;
    }
    .content {
        flex: 1;
    }
    .review_container {
        display: flex;
        margin: 20px auto;
        max-width: 800px;
        background: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        overflow: hidden;
        padding: 20px;
    }
    .review_container .left {
        margin-right: 20px;
    }
    .review_container .left img {
        border-radius: 50%;
        width: 80px;
        height: 80px;
    }
    .review_container .right {
        flex: 1;
    }
    .right_container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .profile p {
        margin: 0;
    }
    .star, .detail {
        margin: 10px 0;
    }
    .stars {
        color: #FFD700; /* Gold color for stars */
    }
    .button-container {
        text-align: center;
        margin: 20px 0;
        font-size: 1.25em; /* 2단계 낮춘 크기 */
    }
    .button-container button {
        padding: 10px 20px;
        margin: 0 10px;
        border: none;
        background-color: #f9f9f9; /* 배경색과 동일하게 설정 */
        color: #4CAF50;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25em; /* 2단계 낮춘 크기 */
        border-radius: 4px;
        transition: background-color 0.3s;
    }
    .button-container button:hover {
        background-color: #e0e0e0; /* 약간 더 진한 색상으로 변경 */
    }
    .button-container button .icon {
        margin-right: 8px;
    }
</style>

<div class="header-info">
    <h3>공연제목(프랑켄슈타인)</h3>
    <br>
    <h3>좌석위치(1층1행1번)</h3>
</div>
<div class="content">
    <% if (reviews != null) { %>
        <% for (SeatReviewDTO review : reviews) { %>
            <div class="review_container">
                <!--왼쪽-->
                <div class="left">
                    <img src="https://via.placeholder.com/80" alt="Profile Image">
                </div>

                <!--오른쪽-->
                <div class="right">
                    <!--극 정보-->
                    <div class="right_container">
                        <div class="profile">
                            <p><%= review.getUserId() %></p>
                            <p>(<%= review.getDate() %>)</p>
                        </div>
                    </div>
                    <div class="star">
                        <!--별점-->
                        <span> 평점: </span><span class="stars"><%= "★".repeat(review.getSeatRank()) %></span>
                    </div>
                    <div class="detail">
                        <!--상세후기-->
                        <pre><%= review.getDetail() %></pre>
                    </div>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <p>후기를 불러오는 중 문제가 발생했습니다.</p>
    <% } %>
</div>
<br>
<div class="button-container">
    <button onclick="history.back()">
        <span class="icon">⬅️</span><span>뒤로가기</span>
    </button>
    <button onclick="location.href='comment.jsp'">
        <span class="icon">✏️</span><span>댓글 작성</span>
    </button>
</div>

<%@ include file="../footer.jsp" %>
