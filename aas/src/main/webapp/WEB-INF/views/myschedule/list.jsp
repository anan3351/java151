<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/template.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Schedule</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="../view/template.css">
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
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <h1>My Schedule</h1>
        <a href="${pageContext.request.contextPath}/myschedule/new" class="btn btn-primary">스케줄 작성</a>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>공연 제목</th>
                    <th>공연 시간</th>
                    <th>좌석</th>
                    <th>출연 배우</th>
                    <th>포스터</th>
                    <th>할인</th>
                    <th>수정/삭제</th> <!-- Actions: 수정 및 삭제 버튼을 포함하여 사용자가 스케줄을 편집하거나 삭제할 수 있도록 함 -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="schedule" items="${schedules}">
                    <tr>
                        <td>${schedule.title}</td>
                        <td><c:out value="${schedule.showdate}" /></td>
                        <td>${schedule.seat}</td>
                        <td>${schedule.fair}</td>
                        <td><img src="${schedule.poster}" alt="Poster" style="width:100px;height:auto;"/></td>
                        <td>${schedule.sale}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/myschedule/edit?id=${schedule.mysch_id}" class="btn btn-warning">Edit</a>
                            <a href="${pageContext.request.contextPath}/myschedule/delete?id=${schedule.mysch_id}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this schedule?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
