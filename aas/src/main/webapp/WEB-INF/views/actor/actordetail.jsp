<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="/css/template.css">
<h1>배우 상세 정보</h1>
<style>
    .header {
        margin-bottom: 0;
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
        background: #333;
        color: #fff;
        padding: 10px 0;
    }

    body {
        padding-top: 80px;
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        color: #333;
    }

    .container {
        display: flex;
        padding: 20px;
        background: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        margin: 20px auto;
        max-width: 800px;
    }

    .actor_photo img {
        width: 150px;
        height: auto;
        border-radius: 8px;
        margin-right: 20px;
    }

    .actor_info {
        display: flex;
        flex-direction: column;
    }

    .actor_info .title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .actor_detail {
        margin-bottom: 20px;
    }

    .actor_detail dl {
        display: flex;
        flex-wrap: wrap;
        width: 400px;
    }

    .actor_detail dt, .actor_detail dd {
        width: 50%;
        margin: 0;
        padding: 5px 0;
    }

    .actor_detail dt {
        font-weight: bold;
        color: #555;
    }

    .actor_detail dd {
        color: #777;
    }

    .detail_contentbox {
        margin-top: 20px;
    }

    .detail_contentbox h4 {
        margin-bottom: 10px;
    }

    .showtitle {
        font-weight: bold;
    }

    .time, .hall {
        color: #777;
    }

    .social-icons {
        display: flex;
        align-items: center;
        margin-top: 10px;
    }

    .social-icons a {
        display: inline-block;
        width: 24px;
        height: 24px;
        margin-right: 10px;
        background-size: cover;
    }

    .social-icons .star {
        background-image: url('/images/star.png');
    }

    .social-icons .facebook {
        background-image: url('/images/facebook.png');
    }

    .social-icons .twitter {
        background-image: url('/images/twitter.png');
    }

    .social-icons .follower-count {
        color: #555;
    }
</style>

<div class="container">
    <div class="actor_photo">
        <img src="${actor.photo}" alt="${actor.a_name}">
    </div>
    <div class="actor_info">
        <!-- 배우 이름 -->
        <div class="actor_name">
            <span class="title">${actor.a_name}</span>
        </div>
        <!-- //배우 이름 -->
        <!-- 배우 세부 정보 -->
        <div class="actor_detail">
            <dl>
                <dt>직업</dt>
                <dd>${actor.job}</dd>
                <dt>생년월일</dt>
                <dd>${actor.birth}</dd>
                <dt>신체조건</dt>
                <dd>${actor.physical}</dd>
                <dt>소속사</dt>
                <dd>${actor.agency}</dd>
                <dt>사이트</dt>
                <dd>${actor.site}</dd>
            </dl>
        </div>
        <!-- //배우 세부 정보 -->
        <!-- 소셜 아이콘 -->
        <div class="social-icons">
            <a href="#" class="star"></a>
            <a href="#" class="facebook"></a>
            <a href="#" class="twitter"></a>
            
        </div>
        <!-- //소셜 아이콘 -->
    </div>
</div>

<h1>공연 정보 추가 예정</h1>
