<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="/css/template.css">
<%@ include file="../header.jsp" %>
<html>
<head>
    <title>공연 관람 후기 목록</title>
    <meta charset="UTF-8">
    <style>
    .header {
        margin-bottom: 0; /* 기존 margin-bottom 값을 0으로 설정 */
        position: fixed; /* 헤더를 고정 위치로 설정 */
        top: -10; /* 상단에 고정 */
        width: 100%; /* 전체 너비를 사용 */
        z-index: 1000; /* 다른 요소보다 위에 위치 */
    }

    body {
        padding-top: 150px; /* 헤더 높이만큼 상단 패딩을 추가 */
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
        .pagination {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .page-button {
            margin: 0 5px;
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }
        .page-button:hover {
            background: #0056b3;
        }
        .search-box {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-box input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-box button {
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-box button:hover {
            background: #0056b3;
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
    <h2>공연 리뷰 목록</h2>
    <div class="search-box">
        <input type="text" placeholder="공연명 검색">
        <button type="button">검색</button>
    </div>
    <div class="write-button">
         <button type="button" onclick="location.href='${pageContext.request.contextPath}/showreview/showreviewForm?user_id=<%= userId %>'">글쓰기</button>
    	 <button type="button" onclick="location.href='${pageContext.request.contextPath}/showreview/showrvmy?user_id=<%= userId %>'">나의 후기</button>
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
                <c:forEach var="review" items="${reviewList}">
                    <tr>
                        <td><a href="${pageContext.request.contextPath}/showreview/showreviewdetail?rev_id=${review.rev_id}">${review['title']}</a></td>
                        <td>${review.retitle}</td>
                        <td>${review.viewcnt}</td>
                        <td>${review.empcnt}</td>
                        <td>${review.user_id}</td>
                        <td>${review.r_date}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <a href="${pageContext.request.contextPath}/showreviewList?pageNum=${i}">
                <button class="page-button ${currentPage == i ? 'active' : ''}">${i}</button>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>
