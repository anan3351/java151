<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <link rel="stylesheet" href="/css/seller.css">
    <script src="/js/seller.js"></script>
    
    <title>seller Page</title>
</head>
	<body>
	    <%@ include file="../header.jsp" %>
	    <div class="main-container">
	        <div class="sidebar">
	            <div class="profile">
	                <div class="profile-image"></div>
	                <p>${userInfo.user_id} 님</p>
	                <p>회원등급 - ${userInfo.auth}</p>
	            </div>
	            <div class="menu-section">
	                <div class="menu-title">공연</div>
	                <ul class="menu-items">
	                    <li><a href="/seller/list">공연 관리</a></li>
	                    <li><a href="/seller/create">공연 등록</a></li>
	                    <li><a href="/seller/discount">공연할인 관리</a></li>
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
	
	        <main>
	        	<br>
	            <div style="font-size: 20px; font-weight: bold; text-align: center;">
	                공연 등록
	            </div><br><br>
	            <form name="showfrm" id="showfrm" method="post" action="show_insert" enctype="multipart/form-data" onsubmit="return validateShow();">
	                <div style="text-align: left; color: red; font-size:13px">&nbsp;&nbsp;* 은 필수 입력 항목입니다</div>
	                <table class="table table-hover" style="width:100%">
	                    <tbody style="text-align: left;">
	                        <tr>
	                            <td><span class="sp">* </span>공연명</td>
	                            <td><input type="text" name="title" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>공연장</td> <!-- 검색창 만들어서 검색해서 정보 받아오는걸로 수정 -->
	                            <td><input type="text" name="hall_id" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>공연 시작일</td>
	                            <td><input type="date" name="start_day" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>공연 종료일</td>
	                            <td><input type="date" name="end_day" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>러닝타임</td>
	                            <td><input type="number" name="runningtime" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>관람가</td>
	                            <td><input type="text" name="viewing_age" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td>시놉시스</td>
	                            <td><textarea rows="5" name="synopsis" class="form-control"></textarea></td>
	                        </tr>
	                        <tr>
	                            <td>공지</td>
	                            <td><input type="file" name="notice_img" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td>할인정보</td>
	                            <td><input type="file" name="dis_img" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td>캐스팅</td>
	                            <td><input type="file" name="casting_img" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td>이벤트</td>
	                            <td><input type="file" name="event_img" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td>상세정보</td>
	                            <td><input type="file" name="detail_img" class="form-control"></td>
	                        </tr>
	                        <tr>
	                            <td>포스터</td>
	                            <td><input type="file" name="poster" class="form-control"></td>
	                        </tr>
	                    </tbody>
	                </table>
	                <hr>
	                <input type="submit" value="공연 등록" class="btn btn-warning" style="background-color: white; color: black;">
	            </form>
	            <br>
	        </main>
	    </div>
	    <%@ include file="../footer.jsp" %>
    </body>
</html>