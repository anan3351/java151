<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="header-wrap">
<header>
<div class="logo">
<a href="${pageContext.request.contextPath}/">
<img src="/images/allaboutshow.png" alt="로고">
</a>
</div>
<div class="search-bar">
<input type="text" placeholder="공연을 검색 하세요">
<button type="button" class="btn-search" title="검색"></button>
</div>
<div class="user-options">
<c:choose>
    <c:when test="${not empty sessionScope.loggedInUser}">
        <a href="${pageContext.request.contextPath}/user/logout">로그아웃</a> |
        <a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/user/login">로그인</a> |
        <a href="${pageContext.request.contextPath}/user/join">회원가입</a> |
        <a href="${pageContext.request.contextPath}/user/login" onclick="alert('로그인이 필요한 서비스입니다.');">마이페이지</a>
    </c:otherwise>
</c:choose>
</div>
</header>
<nav>
<ul>
<li><a href="/musical">뮤지컬</a></li>
<li><a href="/play">연극</a></li>
<li><a href="/actor">배우</a></li>
<li><a href="/hall/list">공연장</a></li>
<li><a href="#">공지사항</a></li>
<li><a href="#">Q&A</a></li>
</ul>
</nav>

</div>

    
    
  </header>

</div>

