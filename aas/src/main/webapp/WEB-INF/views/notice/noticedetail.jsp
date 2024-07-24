<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    
    <style>
body {
    background-color: #f4f4f4;
    font-family: Arial, sans-serif;
}
.post-container {
    max-width: 800px;
    margin: 150px auto; 
    padding: 30px;
    background-color: #ffffff;
    border: 1px solid #ddd;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.post-title {
    background-color: #f8f8f8;
    padding: 15px;
    margin-bottom: 20px;
    border-bottom: 2px solid #333;
    font-size: 24px;
    font-weight: bold;
}
.post-info {
    background-color: #f8f8f8;
    padding: 10px;
    margin-bottom: 20px;
    font-size: 0.9em;
    border: 1px solid #ddd;
}
.post-content {
    background-color: white;
    padding: 20px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    min-height: 200px;
    overflow: auto; /* 내용이 넘칠 경우 스크롤바 표시 */
}

.post-content img {
    max-width: 100%; /* 이미지의 최대 너비를 컨테이너의 100%로 제한 */
    height: auto; /* 높이는 자동으로 조정되어 비율 유지 */
    display: block; /* 이미지를 블록 요소로 변경 */
    margin: 0 auto; /* 이미지를 중앙 정렬 */
}
.post-content pre {
    white-space: pre-wrap;
    word-wrap: break-word;
    font-family: inherit;
    font-size: inherit;
}
.btn-container {
    text-align: right;
    margin-top: 20px;
}
.btn {
    margin-left: 10px;
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}
.btn-info {
    background-color: #5bc0de;
    color: white;
}
.btn-danger {
    background-color: #d9534f;
    color: white;
}
.btn-default {
    background-color: #f0f0f0;
    color: #333;
}

/* 반응형 디자인을 위한 미디어 쿼리 */
@media (max-width: 768px) {
    .post-container {
        margin: 20px 10px;
        padding: 15px;
    }
    
    .post-content {
        padding: 10px;
    }
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class="post-container">
    <h2 class="post-title">${notice.title}</h2>

    <div class="post-info">
        <span>작성자: ${notice.user_id}</span> |
        <span>작성일: <fmt:formatDate value="${notice.n_date}" pattern="yyyy-MM-dd HH:mm"/></span> |
        <span>조회수: ${notice.cnt}</span>
    </div>

    <div class="post-content">
    ${notice.n_text}
</div>

    <div class="btn-container">
       <c:if test="${loggedInUser.auth == 'M'}">
		    <input class="btn btn-primary" type="button" value="수정" onclick="location.href='/notice/edit/${notice.n_id}'">
		    <input class="btn btn-danger" type="button" value="삭제" onclick="deleteNotice(${notice.n_id})">
		</c:if>
            
        
        <input class="btn btn-default" type="button" value="목록으로" onclick="location.href='../notice'">
    </div>
</div>
<%@ include file="../footer.jsp" %>
</body>
<script>
function deleteNotice(n_id) {
    if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
        var form = document.createElement('form');
        form.setAttribute('method', 'post');
        form.setAttribute('action', '/notice/delete');

        var hiddenField = document.createElement('input');
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('name', 'n_id');
        hiddenField.setAttribute('value', n_id);

        form.appendChild(hiddenField);
        document.body.appendChild(form);
        form.submit();
    }
}
</script>
</html>