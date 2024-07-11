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
    <title>show upload</title>
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
	
	        <main>
	        	<br>
                <div style="font-size: 30px; font-weight: bold; text-align: center;">
                    좌석 금액
                  </div><br><br>
                <div class="btn-container">
                  <button type="button" class="btn btn-success add-button" onclick="addSeat()">+</button>
                </div>
                <form name="showfrm" id="showfrm" method="post" action="insert" enctype="multipart/form-data" onsubmit="return validateShow();">
	                <div style="text-align: left; color: red; font-size:13px">&nbsp;&nbsp;* 은 필수 입력 항목입니다</div>
                	<div class="table-container">
                  		<table class="table table-hover">
                    		<tbody id="input-container1">
                      			<tr>
                        			<td>주말차등가</td>
                        			<td><input type="text" name="add_p" class="form-control"></td>
                      			</tr>
                      			<tr>
                        			<td><span>* </span>좌석등급</td>
                        			<td><input type="text" name="seat_level_0" class="form-control"></td>
                      			</tr>
                      			<tr>
                        			<td><span>* </span>좌석금액</td>
                        			<td><input type="number" name="seat_price_0" class="form-control"></td>
                      			</tr>
                    		</tbody>
                  		</table>
                	</div><hr><br><br>
                	<input type="submit" value="공연 등록" class="btn btn-default" style="background-color: white; color: black;">
              		<br><br><br><br><br>
            	</form>
	        </main>
	    </div>
	    <%@ include file="../footer.jsp" %>
    </body>
</html>