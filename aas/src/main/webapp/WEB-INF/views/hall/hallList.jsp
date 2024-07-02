<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
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
  <link rel="stylesheet" href="/css/template.css"> 
</head>
<body>
	<%@ include file="../header.jsp" %>
	
	<div class="main-container">
		<!-- 본문시작 -->
		<h4>공연장 목록</h4>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>공연장명</th>
					<th>공연관</th>
					<th>주소</th>
					<th>전화번호</th>
					<th>홈페이지</th>
					<th>좌석수</th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach items="${list}" var="hallDto" varStatus="vs">
			<tr>
				<td>${hallDto.h_name}</td>
				<td>miniHall</td>
				<td>3</td>
				<td>4</td>
				<td>5</td>
				<td>6</td>
			</tr>
			</c:forEach>
				<tr>
					<td colspan="7">1</td>
				</tr>
			</tbody>
		
		</table>




		<!-- 본문 끝 -->
	</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>