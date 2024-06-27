<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
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
  	header .search-bar .btn-search {
  		background: url('/images/search.svg') no-repeat;
  	}
  </style>
</head>

<body>

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
  <br><br>

  <!-- content start -->
  <div class="container">
    <div class=" row content" style="text-align: center;">
      <div>
