<%@page import="net.utility.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
	    <link rel="stylesheet" href="/css/template.css">
	    <link rel="stylesheet" href="/css/seller.css">
	    <script src="/js/seller.js"></script>
	    <title>seller Page</title>
	</head>
	<body>
		<br>
		<table class='table'>
		    <thead>
		        <tr>
		            <th style='text-align:left'>선택</th>
		            <th style='text-align:left'>공연장ID</th>
		            <th style='text-align:left'>공연장명</th>
		            <th style='text-align:left'>세부관</th>
		            <th style='text-align:left'>주소</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach var="hall" items="${list}">
		            <tr>
		                <td><input type='radio' name='selected_hall' value='${hall.hall_id}'></td>
		                <td>${hall.hall_id}</td>
		                <td>${hall.h_name}</td>
		                <td>${hall.miniHall != null ? hall.miniHall : ''}</td>
		                <td>${hall.addr}</td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>
		
		<%
	    	// 글 개수
	        
	        // 페이지 리스트
	        out.println("<tr>");
	        out.println("<td colspan='4' style='text-align:center; height:50px'>");
	        int totalCount = (Integer) request.getAttribute("totalCount");
	        int pageSize = (Integer) request.getAttribute("pageSize");

		%>
		
		
		<!-- 페이징 시작 -->
	    <div class="text-xs-center">
	      <ul class="pagination justify-content-center">
	          <!-- 이전 -->
	          <c:choose>
	              <c:when test="${ulist.first}"></c:when>
	              <c:otherwise>
	                  <li class="page-item"><a class="page-link" href="${basePath}/hall/list?field=${field}&word=${word}&page=0">처음</a></li>
	                  <li class="page-item"><a class="page-link" href="${basePath}/hall/list?field=${field}&word=${word}&page=${ulist.number - 1}">&larr;</a></li>
	              </c:otherwise>
	          </c:choose>
	  
	          <!-- 페이지 그룹 -->
	          <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
	              <c:choose>
	                  <c:when test="${ulist.pageable.pageNumber + 1 == i}">
	                      <li class="page-item disabled"><a class="page-link" href="${basePath}/hall/list?field=${field}&word=${word}&page=${i - 1}">${i}</a></li>
	                  </c:when>
	                  <c:otherwise>
	                      <li class="page-item"><a class="page-link" href="${basePath}/hall/list?field=${field}&word=${word}&page=${i - 1}">${i}</a></li>
	                  </c:otherwise>
	              </c:choose>
	          </c:forEach>
	  
	          <!-- 다음 -->
	          <c:choose>
	              <c:when test="${ulist.last}"></c:when>
	              <c:otherwise>
	                  <li class="page-item"><a class="page-link" href="${basePath}/hall/list?field=${field}&word=${word}&page=${ulist.number + 1}">&rarr;</a></li>
	                  <li class="page-item"><a class="page-link" href="${basePath}/hall/list?field=${field}&word=${word}&page=${ulist.totalPages - 1}">마지막</a></li>
	              </c:otherwise>
	          </c:choose>
	      </ul>
	  </div>
      <!-- 페이징 끝 -->
		
		
		<button onclick='selectHall(); return false;' class='btn btn-default'>선택</button>
		
	</body>
</html>