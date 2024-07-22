<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <style>
        .main-container {
            padding: 20px;
            margin: 200px auto 230px;
        }
        .result-container {
            width: 40%;
            margin: 0 auto;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
        }
        .btn-primary {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <div class="result-container">
            <h2>아이디 찾기 결과</h2>
            <c:choose>
                <c:when test="${not empty foundUserId}">
                    <p>찾은 아이디: ${foundUserId}</p>
                </c:when>
                <c:otherwise>
                    <p>${error}</p>
                </c:otherwise>
            </c:choose>
            <a href="/user/login" class="btn btn-primary">로그인 페이지로</a>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>