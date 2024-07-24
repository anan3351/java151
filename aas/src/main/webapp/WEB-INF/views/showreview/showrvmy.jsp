<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../header.jsp" %>
<html>
<head>
    <title>나의 후기</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/template.css">
    <style>
            .header {
            margin-bottom: 0;
            position: fixed;
            top: -10;
            width: 100%;
            z-index: 1000;
        }
        body {
            padding-top: 200px;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        .review-list table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .review-list th, .review-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .review-list th {
            background-color: #f2f2f2; /* Add background color to headers for better visibility */
        }
                .write-button {
            text-align: right;
            margin-bottom: 20px;
        }
        .write-button button {
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }
        .write-button button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<%
    // 세션에서 로그인된 사용자 정보를 가져옵니다.
    com.example.demo.user.UserDTO loggedInUser = (com.example.demo.user.UserDTO) session.getAttribute("loggedInUser");
    String userId = loggedInUser != null ? loggedInUser.getUser_id() : "";
%>
<div class="container">
    <h2>나의 후기</h2>
    <c:if test="${empty myReviews}">
        <p>작성한 후기가 없습니다.</p>
    </c:if>
    <div class="write-button">
    	 <button type="button" onclick="location.href='${pageContext.request.contextPath}/showreview/showreviewForm?user_id=<%= userId %>'">글쓰기</button>
    	 <button type="button" onclick="location.href='${pageContext.request.contextPath}/showreview?user_id=<%= userId %>'">후기 목록</button>
    </div>
    
    <div class="review-list">
        <table>
            <thead>
                <tr>
                    <th>공연명</th>
                    <th>제목</th>
                    <th>조회</th>
                    <th>공감</th>
                    <th>글쓴이</th>
                    <th>날짜</th>
                </tr>
            </thead>
<tbody>
    <c:forEach var="review" items="${myReviews}">
        <tr>
            <td><a href="${pageContext.request.contextPath}/showreview/showreviewdetail?rev_id=${review.rev_id}">${review.show_title}</a></td>
            <td>${review.retitle}</td>
            <td>${review.viewcnt}</td>
            <td>${review.empcnt}</td>
            <td>${review.user_id}</td>
            <td><fmt:formatDate value="${review.r_date}" pattern="yyyy-MM-dd" /></td>
        </tr>
    </c:forEach>
</tbody>

        </table>
    </div>
</div>
</body>
</html>
