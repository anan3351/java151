<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Favorite Shows</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #4CAF50;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #ddd;
    }

    .show-title {
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5em;
        margin-bottom: 20px;
    }

    .show-title img {
        margin-right: 10px;
        width: 20px;
        height: 20px;
    }
</style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <div class="show-title">
            <img src="/images/kheart.png" alt="Heart"> 애정 공연
        </div>
        <table>
            <thead>
                <tr>
                    <th>제목</th>
                    <th>날짜</th>
                    <th>시간</th>
                    <th>출연 배우</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="show" items="${favoriteShowList}">
                    <tr>
                        <td>${show.title}</td>
                        <td><fmt:formatDate value="${show.ticket_date}" pattern="MM/dd (E)" /></td>
                        <td><fmt:formatDate value="${show.ticket_date}" pattern="HH:mm" /></td>
                        <td>${show.casting}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
