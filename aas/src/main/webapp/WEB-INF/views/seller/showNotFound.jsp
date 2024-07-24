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
			    <div class="container">
			    	<br><br><br><br><br><br>
			        <h1>오류</h1><br>
			        <p>요청하신 공연 정보를 찾을 수 없습니다. 다시 시도해 주세요.</p>
			        <a href="<c:url value='/' />" class="btn btn-primary">홈으로 돌아가기</a>
			    </div><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>

