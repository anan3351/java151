<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="../css/seller.css">
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
			<!-- 본문 영역 -->
                <br>
	            <div style="font-size: 20px; font-weight: bold; text-align: center;">
	                공연 등록
	            </div><br>
		        
		        <div class="row">
		        	<div class="col-sm-12">
		        		<!-- 검색 -->
		        		<form method="get" action="search">
		        			상품명 : <input type="text" name="product_name" value="${product_name}"> <!-- 검색어를 value로 가져감 -->
		        				   <input type="submit" value="검색" class="btn btn-secondary" style="background-color: white; color:black;">
		        		</form>
		        	</div> <!-- col end -->
		        </div> <!-- row end -->
		        
		        <!-- c:choose : 다중조건문 -->
		        <div class="row">
		            <c:forEach items="${list}" var="row" varStatus="vs"> <!-- ProductDTO -> list() -> addObject("list", productDao.list()) 의 list를 가리킴 -->
		                <div class="col-sm-4 col-md-4">
		                    <c:choose>
		                        <c:when test="${row.FILENAME != '-'}">
		                        	<a href="detail/${row.PRODUCT_CODE}">
			                            <img src="/storage/${row.FILENAME}" class="img-responsive margin" style="width:100%">
			                        </a>
		                        </c:when>
		                        <c:otherwise>
		                            등록된 사진 없음! <br>
		                        </c:otherwise>
		                    </c:choose>
		                    <br>
		                    <%-- 상품명 : <a href="detail?product_code=${row.PRODUCT_CODE}">${row.PRODUCT_NAME}</a><br> --%>
		                    
		                    <%-- RESTful Web Service 방식 --%>
		                    상품명 : <a href="detail/${row.PRODUCT_CODE}">${row.PRODUCT_NAME}</a><br>
		                    상품가격 : <fmt:formatNumber value="${row.PRICE}" pattern="#,###"/>
		                    
		                    <!-- 한줄에 3칸씩 출력 -->        
			                <c:if test="${vs.count mod 3==0}">
			            		</div> <!-- row end -->
			            		<div style="height: 50px;"></div>
			            		<div class="row">
			            	</c:if>
			            </div>
		            </c:forEach>
		        </div>
		        <!-- 본문 끝 -->
            </main>
        </div>
        <%@ include file="../footer.jsp" %>
    </body>
</html>