<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/template.css">
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

  <link rel="stylesheet" href="../view/template.css"> 

  <link rel="stylesheet" href="/css/template.css">

</head>
<body>
	<%@ include file="../header.jsp" %>
			<div class="main-container">
				<!-- 본문시작 -->


<style>
    .header {
        margin-bottom: 0;
        position: fixed;
        top: 50;
        width: 100%;
        z-index: 1000;
        background: #333;
        color: #fff;
        padding: 10px 0;
    }

    body {
        padding-top: 80px;
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        color: #333;
    }
    h1 {
        text-align: center;
        margin-top: 20px;
    }
    .favorite-header {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }
    .favorite-header span {
        display: inline-flex;
        align-items: center;
        margin-right: 10px;
        font-size: 1.2em;
    }
    .favorite-header img {
        width: 20px;
        height: 20px;
        margin-right: 5px;
    }
    .schedule-table {
        width: 90%;
        margin: 0 auto;
        border-collapse: collapse;
        background: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .schedule-table th, .schedule-table td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
    }
    .schedule-table th {
        background-color: #4CAF50;
        color: white;
    }
    .schedule-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .schedule-table tr:hover {
        background-color: #ddd;
    }
    .schedule-table caption {
        caption-side: top;
        margin-bottom: 10px;
        font-size: 1.5em;
        font-weight: bold;
    }
    .actor-name-header {
        background-color: #4CAF50;
        color: white;
    }
</style>
<h1>애정 배우</h1>

<div class="favorite-header">
    <c:forEach var="actor" items="${actorList}">
        <span style="cursor:pointer;" onclick="location.href='${pageContext.request.contextPath}/actordetail?id=${actor.actor_id}'">
            <img src="/images/kheart.png" alt="Heart"> ${actor.a_name}
        </span>
    </c:forEach>
</div>

<table class="schedule-table">
    <caption></caption>
    <thead>
        <tr>
            <th>날짜</th>
            <c:forEach var="actorName" items="${actorNames}">
                <th class="actor-name-header">${actorName}</th>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="entry" items="${scheduleMap}">
            <tr>
                <td>${entry.key}</td>
                <c:forEach var="actorName" items="${actorNames}">
                    <td>
                        <c:out value="${entry.value[actorName]}" default="-" />
                    </td>
                </c:forEach>
            </tr>
        </c:forEach>
    </tbody>
</table>
				<!-- 본문 끝 -->
			</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>
