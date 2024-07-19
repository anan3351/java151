<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>공지사항</title>
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
    
    /*버튼*/
	.btn-group {
	justify-content: center;
	display: flex;
	}
	.btn {
	    padding: 10px 20px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 16px;
	    margin: 0 5px;
	}
	.btn-primary {
	    background-color: #0070c9;
	    color: white;
	}
	.btn-danger {
	    background-color: #bdb9b9;
	    color: white;
	}
	.btn-primary:hover, .btn-danger:hover {
	    opacity: 0.9;
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
		<h1 class="list-title">공지사항</h1>
		
		<!-- 검색 영역 시작-->
	<form action="${basePath}/notice/notice" class="form-inline d-flex justify-content-end search-box" method="GET">
    <select name="field" id="field" class="sel-search">
    <option value="title" ${field == 'title' ? 'selected' : ''}>제목</option>
    <option value="n_text" ${field == 'n_text' ? 'selected' : ''}>제목+내용</option>
</select>
    <input type="text" id="word" name="word" class="inp-search" value="${word}"> 
    <input type="submit" class="btn btn-search" value="검색">
</form>
	<!-- 검색 영역 끝 -->
	<c:if test="${not empty userAuth and (userAuth eq 'M' or userAuth eq 'm')}">
<c:if test="${userAuth eq 'M'}">
    <div class="btn-group">
        <input type="submit" value="글쓰기" class="btn btn-primary" onclick="location.href='../notice/noticeform'">
    </div>
</c:if>
</c:if>
		

<div class="table-wrap">
    <table class="table table-hover">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>날짜</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="notice" items="${noticeList}">
		    <tr>
		        <td>${notice.n_id}</td>
		        <td><a href="${basePath}/notice/noticedetail/${notice.n_id}">${notice.title}</a></td>
		        <td>${notice.user_id}</td>
		        <td>${notice.cnt}</td>
		        <td><fmt:formatDate value="${notice.n_date}" pattern="yyyy-MM-dd HH:mm"/></td>
		    </tr>
		</c:forEach>
        </tbody>
    </table>
</div>


    <!-- 페이징 시작 -->
<div class="col-md-12 text-center">
  <ul class="pagination">
      <c:set var="searchParams" value="&field=${field}&word=${word}" />
      <!-- 이전 -->
      <c:if test="${currentPage > 1}">
          <li class="page-item"><a class="page-link" href="${basePath}/notice/notice?page=1${searchParams}">처음</a></li>
          <li class="page-item"><a class="page-link" href="${basePath}/notice/notice?page=${currentPage - 1}${searchParams}">&larr;</a></li>
      </c:if>

      <!-- 페이지 그룹 -->
      <c:forEach begin="${startPage}" end="${endPage}" var="i">
          <c:choose>
              <c:when test="${currentPage == i}">
                  <li class="page-item active"><a class="page-link" href="#">${i}</a></li>
              </c:when>
              <c:otherwise>
                  <li class="page-item"><a class="page-link" href="${basePath}/notice/notice?page=${i}${searchParams}">${i}</a></li>
              </c:otherwise>
          </c:choose>
      </c:forEach>

      <!-- 다음 -->
      <c:if test="${currentPage < totalPages}">
          <li class="page-item"><a class="page-link" href="${basePath}/notice/notice?page=${currentPage + 1}${searchParams}">&rarr;</a></li>
          <li class="page-item"><a class="page-link" href="${basePath}/notice/notice?page=${totalPages}${searchParams}">마지막</a></li>
      </c:if>
  </ul>
</div>
<!-- 페이징 끝 -->
    </div>
    
    
    

		<!-- 본문 끝 -->
	<%@ include file="../footer.jsp" %>
</body>
</html>
