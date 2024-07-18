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
    <title>Show Update</title>
</head>
	<body>
	    <%@ include file="../header.jsp" %>
	    <div class="main-container">
		    <%@ include file="./sidebar.jsp" %>>
	
	        <main>
	        	<br>
	            <div style="font-size: 20px; font-weight: bold; text-align: center;">
	                공연 등록
	            </div><br><br>
	            <form name="showfrm" id="showfrm" method="post" action="insert" enctype="multipart/form-data" onsubmit="return validateShow();">
	                <div style="text-align: left; color: red; font-size:13px">
	                	&nbsp;&nbsp;* 은 필수 입력 항목입니다<br>
	                	&nbsp;&nbsp;&nbsp;&nbsp;공연 등록 후, 목록에서 상세정보를 추가하세요. (배역, 할인율, 좌석별 금액..)
	                </div>
	                <table class="table table-hover" style="width:100%">
	                    <tbody style="text-align: left;">
	                        <tr>
	                            <td><span class="sp">* </span>공연명</td>
	                            <td><input type="text" name="title" class="form-control"></td>
	                        </tr>
                            <tr>
	                            <td><span class="sp">* </span>장르</td>
	                            <td><input type="text" name="genre" class="form-control" placeholder="연극/뮤지컬"></td>
	                        </tr>
	                        <tr>
	                        	<td><span class="sp">* </span>공연장</td>
	                        	<td><input type="text" name="hall_id" class="form-control" readonly></td>
						    	<td><input type="button" class="btn btn-default" id="hall_search" value="검색" onclick="hallSearch()"></td>
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
	                            <td><input type="text" name="runningtime" class="form-control" placeholder="~시간 ~분"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>관람가</td>
	                            <td><input type="text" name="viewing_age" class="form-control" placeholder="만 ~세 이상"></td>
	                        </tr>
	                        <tr>
	                            <td><span class="sp">* </span>캐스팅</td>
	                            <td><input type="text" name="s_cast" class="form-control" placeholder="김배우, 이배우, 박배우, ..."></td>
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
	                <input type="submit" value="공연 등록" class="btn btn-default">
	            </form>
	            <br>
	        </main>
	    </div>
	    <%@ include file="../footer.jsp" %>
    </body>
</html>