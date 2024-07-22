<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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