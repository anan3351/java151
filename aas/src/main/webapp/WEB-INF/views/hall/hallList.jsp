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
  <link rel="stylesheet" href="/css/template.css"> 

<style>
  /* body{font-family: 'Pretendard';}
   */
  .list-title{
    font-size: 28px;
    font-weight: 600;
    text-align: center;
    padding-block: 40px;

   
    }
  .search-box{
    background-color: #EFEFEF;
    width:100%;
    padding-block: 25px;
    display: flex;
    align-items: center;
    justify-content: center;

  }

.btn-search{
  background-color: #464242;
  padding:5px 30px;
  color: #FFFFFF;
  font-weight: 500;
  font-size: 14px;
  border-radius: 0;
}
.inp-search{
  width: 700px;
  height: 34px;
  border: 1px solid #ddd;
  color: #1d1d1d;
}

.sel-search{
  height: 34px;
  border: 1px solid #ddd;
  color: #1d1d1d;
  margin-right: 6px;
  width: 150px;
}

.table-wrap{
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 30px 80px;
  max-width: 1600px;
  margin: 0 auto;
}

/*pagination custom*/
.pagination>li:first-child>a, .pagination>li:first-child>span{
  border-radius: 100%;
}
.pagination>li:nth-last-child(3)>a, .pagination>li:nth-child(3)>span{
  padding: 6px 8px;
}
.pagination>li:nth-last-child(2)>a, .pagination>li:nth-child(2)>span{
  border-radius: 0;
  border: none;
}
.pagination>li:nth-last-child(1)>a, .pagination>li:nth-child(1)>span{
  border-radius: 0;
  border:none
}
.pagination>li>a, .pagination>li>span{
  border-radius: 100%;
  border: none;
  color: #535353;
  margin-left: 0;
}

.pagination>.disabled>a, .pagination>.disabled>a:focus, .pagination>.disabled>a:hover, .pagination>.disabled>span, .pagination>.disabled>span:focus, .pagination>.disabled>span:hover{
  background-color: rgb(51, 230, 176);
  color: #fff;
  font-weight: 700;
}

.pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus, .pagination>li>span:hover{
  background-color: transparent;
}

.pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>a:focus, .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>a:hover, .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>span:focus, .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>span:hover{
  background-color: #eee;
}


/*테이블 커스텀*/
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{
  text-align: center;
}
.table>thead>tr>th{
  font-size: 16px;
}
.table>tbody>tr>td:nth-child(2){
  width: 350px;
}
.table>tbody>tr>td:nth-child(1){
  width: 200px;
}

</style>

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
                  <a href="detail/${hall.hall_id}"> ${hall.hname} </a>
                  </td>
                  <td>${hall.addr}</td>
                  <td>${hall.url}</td>
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