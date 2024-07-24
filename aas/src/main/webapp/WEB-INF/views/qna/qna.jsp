<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Q & A</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <link rel="stylesheet" href="/css/hall.css">
  
  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>

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
	
  .answer-row {
    background-color: #f9f9f9;
  }
  .answer-row td:nth-child(4) {
    padding-left: 20px;
  }

  .lock-icon {
    font-size: 14px; /* 크기 조정 */
    margin-right: 5px; /* 오른쪽 여백 추가 */
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
                    return true;  // 링크 이동 허용
                } else {
                    alert("로그인이 필요한 서비스입니다.");
                    // 현재 페이지 URL을 저장
                    sessionStorage.setItem('redirectAfterLogin', '/qna/qna');
                    window.location.href = '/user/login';  // 로그인 페이지로 리다이렉트
                    resolve(false);  // 로그인 되어 있지 않음
                    return false;  // 링크 이동 중단
                }
            },
            error: function(xhr, status, error) {
                console.error('로그인 상태 확인 중 오류 발생:', error);
                reject(error);
                return false;  // 오류 발생 시 링크 이동 중단
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
		<h1 class="list-title">Q & A</h1>
		
		<!-- 검색 영역 시작-->
		<form action="${basePath}/qna/qna" class="form-inline d-flex justify-content-end search-box" method="GET">
			<select name="field" id="field" class="sel-search">
				<option value="q_title" ${field == 'title' ? 'selected' : ''}>제목</option>
				<option value="q_text" ${field == 'n_text' ? 'selected' : ''}>제목+내용</option>
			</select>
			<input type="text" id="word" name="word" class="inp-search" value="${word}"> 
			<input type="submit" class="btn-search2" value="검색">
		</form>
		<!-- 검색 영역 끝 -->
		<div class="btn-group">
			<c:if test="${userAuth != 'M' && userAuth != 'S'}">
				<input type="submit" value="문의하기" class="btn btn-primary" onclick="location.href='../qna/qnaform'">
			</c:if>
		</div>

		<div class="table-wrap">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>유형</th>
						<th>작성자</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="qna" items="${qnaList}">
					<tr>
						<td>${qna.question_id}</td>
						<td>
							<c:choose>
								<c:when test="${qna.category == 'A'}">A</c:when>
								<c:otherwise>${qna.category}</c:otherwise>
							</c:choose>
						</td>
						<td>${qna.user_id}</td>
						<td>
							<c:choose>
								<c:when test="${qna.canAccess}">
									<a href="${basePath}/qna/qnadetail?id=${qna.question_id}">
										<c:if test="${qna.q_open == false}">
											<span class="lock-icon">🔒</span>
										</c:if>
										${qna.q_title}
									</a>
								</c:when>
								<c:otherwise>
									<a href="#" onclick="alert('비공개 게시물입니다.'); return false;">
										<span class="lock-icon">🔒</span>
										${qna.q_title}
									</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatDate value="${qna.q_date}" pattern="yyyy-MM-dd HH:mm"/></td>
					</tr>
					<c:if test="${not empty qna.answers}">
    <c:forEach var="answer" items="${qna.answers}">
        <tr class="answer-row">
            <td>${answer.question_id}</td>
            <td>A</td>
            <td>${answer.user_id}</td>  <!-- 답변 작성자 ID 표시 -->
            <td>
                <span style="padding-left: 20px;">↳ </span>
                <c:choose>
                    <c:when test="${answer.canAccess}">
                        <a href="${basePath}/qna/qnadetail?id=${answer.question_id}">
                            <c:if test="${answer.q_open == false}">
                                <span class="lock-icon">🔒</span>
                            </c:if>
                            ${answer.q_title}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="#" onclick="alert('비공개 게시물입니다.'); return false;">
                            <span class="lock-icon">🔒</span>
                            ${answer.q_title}
                        </a>
                    </c:otherwise>
                </c:choose>
            </td>
            <td><fmt:formatDate value="${answer.q_date}" pattern="yyyy-MM-dd HH:mm"/></td>
        </tr>
    </c:forEach>
</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 페이징 시작 -->
		<div class="col-md-12 text-center">
			<ul class="pagination">
				<!-- 이전 -->
				<c:if test="${currentPage > 1}">
					<li class="page-item"><a class="page-link" href="${basePath}/qna/qna?page=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="${basePath}/qna/qna?page=${currentPage - 1}">&larr;</a></li>
				</c:if>

				<!-- 페이지 그룹 -->
				<c:forEach begin="${startPage}" end="${endPage}" var="i">
					<c:choose>
						<c:when test="${currentPage == i}">
							<li class="page-item active"><a class="page-link" href="#">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${basePath}/qna/qna?page=${i}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 -->
				<c:if test="${currentPage < totalPages}">
					<li class="page-item"><a class="page-link" href="${basePath}/qna/qna?page=${currentPage + 1}">&rarr;</a></li>
					<li class="page-item"><a class="page-link" href="${basePath}/qna/qna?page=${totalPages}">마지막</a></li>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 끝 -->
	</div>
	
	<!-- 본문 끝 -->
	<%@ include file="../footer.jsp" %>
</body>
</html>