<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  <link rel="stylesheet" href="/css/hall.css"> 

<style>

  .list-title{
    font-size: 28px;
    font-weight: 600;
    text-align: center;
    padding-block: 40px;
    }

</style>


<script>
function checkLogin() {
    return new Promise((resolve, reject) => {
        $.ajax({
            url: '/user/checkLoginStatus',
            type: 'GET',
            success: function(response) {
                if (response.isLoggedIn) {
                    resolve(true);  // 로그인 되어 있음
                } else {
                    alert("로그인이 필요한 서비스입니다.");
                    // 현재 페이지 URL을 저장
                    sessionStorage.setItem('redirectAfterLogin', '/hall/list');
                    window.location.href = '/user/login';  // 로그인 페이지로 리다이렉트
                    resolve(false);  // 로그인 되어 있지 않음
                }
            },
            error: function(xhr, status, error) {
                console.error('로그인 상태 확인 중 오류 발생:', error);
                reject(error);
            }
        });
    });
}
</script>
</head>
<body>
	<%@ include file="../header.jsp" %>
			<div class="main-container">
				<!-- 본문시작 -->
		<%-- 기본 경로 설정 --%>
<c:set var="basePath" value="${pageContext.request.contextPath}" />
		<h1 class="list-title">공연장 목록</h1>
		
		<!-- 검색 영역 시작-->
	<form action="/hall/list" class="form-inline d-flex justify-content-end search-box"
		method="GET">
		<select name="field" id="field" class="sel-search">
			<option value="hname">공연장명</option>
			<option value="addr">주소</option>
		</select> 
		<input type="text" id="word" name="word" class="inp-search"> 
		<input type="submit" class="btn btn-search" value="검색">
	</form>
	<!-- 검색 영역 끝 -->
		

<div class="table-wrap">
      <table class="table table-hover">
          <thead>
          <tr>
              <th>공연장명</th>
              <th>주소</th>
              <th>URL</th>
              <th>객석수</th>
              <th>전화번호</th>
              <th>시설분류</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="hall" items="${ulist.content}">
              <tr>
                  <td>
                  <a href="detail/${hall.hall_id}" onclick="return checkLogin()"> ${hall.hname} </a>
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
			</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>
