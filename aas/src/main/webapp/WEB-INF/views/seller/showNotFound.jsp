<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Show Not Found</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>오류</h1>
        <p>요청하신 공연 정보를 찾을 수 없습니다. 다시 시도해 주세요.</p>
        <a href="<c:url value='/' />" class="btn btn-primary">홈으로 돌아가기</a>
    </div>
</body>
</html>
