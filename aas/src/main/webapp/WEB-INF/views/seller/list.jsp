<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="../css/seller.css">
    <title>seller Page</title>
</head>
    <body>
        <%@ include file="../header.jsp" %>
        <div class="main-container">
            <div class="sidebar">
                <div class="profile">
                    <div class="profile-image"></div>
                    <p>${userInfo.user_id} 님</p>
                    <p>회원등급 - ${userInfo.auth}</p>
                </div>
                <div class="menu-section">
                    <div class="menu-title">공연</div>
                    <ul class="menu-items">
                    <li><a href="/seller/list">공연 목록</a></li>
                    <li><a href="/seller/create">공연 등록</a></li>
                    </ul>
                </div>
                <div class="menu-section">
                    <div class="menu-title">공연장</div>
                    <ul class="menu-items">
                        <li><a href="#">공연장 등록</a></li>
                        <li><a href="#">공연장 수정</a></li>
                        <li><a href="#">대관비 관리</a></li>
                    </ul>
                </div>
                <div class="menu-section">
                    <div class="menu-title">공연장대관</div>
                    <ul class="menu-items">
                        <li><a href="#">대관 관리</a></li>
                    </ul>
                </div>
            </div>

            <main>
				<!-- 본문 영역 -->
                <br>
	            <div style="font-size: 20px; font-weight: bold; text-align: center;">
	                공연 목록
	            </div><br>
<div class="table-wrap">
      <table class="table table-hover">
          <thead>
          <tr>
              <th>공연ID</th>
              <th>제목</th>
              <th>장르</th>
              <th>공연장</th>
              <th>공연기간</th>
              <th>상태</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="hall" items="${ulist.content}">
              <tr>
                  <td>
                  <a href="detail/${hall.hall_id}"> ${hall.hname} </a>
                  </td>
                  <td>${hall.addr}</td>
                  <td><a href="${hall.url}" target="_blank">${hall.url}</a></td>
                  <td>${hall.seat}</td>
                  <td>${hall.h_call}</td>
                  <td>${hall.h_code}</td>
              </tr>
          </c:forEach>
          </tbody>
      </table>


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
    </div>
				
		       	<!-- 본문 끝 -->
            </main>
        </div>
        <%@ include file="../footer.jsp" %>
    </body>
</html>