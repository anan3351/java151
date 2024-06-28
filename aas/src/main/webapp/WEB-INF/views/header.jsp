<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="en">

  <div class="header-wrap">
      <header>
        <div class="logo">
          <a href="${pageContext.request.contextPath}/">
            <img src="/images/logo.png" alt="로고">
          </a>
        </div>
        <div class="search-bar">
          <input type="text" placeholder="공연을 검색 하세요">
          <button type="button" class="btn-search" title="검색"></button>
        </div>
        <div class="user-options">
          <a href="#">로그인</a> | <a href="#">회원가입</a> | <a href="#">마이페이지</a>
        </div>
      </header>
      <nav>
        <ul>
          <li><a href="/musical">뮤지컬</a></li>
          <li><a href="/play">연극</a></li>
          <li><a href="/actor/list">배우</a></li>
          <li><a href="#">공연장</a></li>
          <li><a href="#">공지사항</a></li>
          <li><a href="#">Q&A</a></li>
        </ul>
      </nav>
    </div>

 
