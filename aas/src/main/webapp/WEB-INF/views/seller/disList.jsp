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
    <title>Discount List</title>
</head>
	<body>
	    <%@ include file="../header.jsp" %>
		<div class="main-container">
			<%@ include file="./sidebar.jsp" %>
			<main>
				<br>
				<div style="font-size: 20px; font-weight: bold; text-align: center;">
					할인 목록<br>					
					<div style="float: right;">
	                    <input type="button" class="btn btn-default" value="종료된 할인" onclick="window.location.href='./endDisList'">
	                    <input type="button" class="btn btn-default" value="할인 등록" onclick="window.location.href='./discount'">
	                </div>
				</div><br><br>
				<div class="table-wrap">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style='text-align:left; width: 10%'>할인명</th>
                            <th style='text-align:left; width: 10%'>좌석등급</th>
                            <th style='text-align:left; width: 10%'>할인율</th>
                            <th style='text-align:left'>할인정보</th>
                            <th style='text-align:left; width: 15%'>적용기간</th>
                            <th style='text-align:left; width: 10%'>현장확인</th>
                            <th style="width: 15%"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dis" items="${ulist}">
                            <tr>
                                <td style="width: 10%">${dis.dis_name}</td>
                                <td style="width: 10%">${dis.dis_range}</td>
                                <td style="width: 10%">${dis.dis_rate}%</td>
                                <td>${dis.dis_info}</td>
                                <td style="width: 15%">${dis.start} ~ ${dis.end}</td>
                                <td style="width: 10%">${dis.dis_check}</td>
                                <td style="width: 15%">
                                	<input type="button" class="btn btn-default" value="수정" onclick="window.location.href='../${dis.dis_id}/disUpdate'">
                                	<input type="button" class="btn btn-default" value="삭제" onclick="deleteDiscount(${dis.dis_id})">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <ul class="pagination">
                <c:if test="${totalPages > 1}">
                    <c:choose>
                        <c:when test="${currentPage > 0}">
                            <li><a href="?page=0">처음</a></li>
                            <li><a href="?page=${currentPage - 1}">←</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="disabled"><span>처음</span></li>
                            <li class="disabled"><span>←</span></li>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <li class="active"><span>${i + 1}</span></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="?page=${i}">${i + 1}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPages - 1}">
                            <li><a href="?page=${currentPage + 1}">→</a></li>
                            <li><a href="?page=${totalPages - 1}">마지막</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="disabled"><span>→</span></li>
                            <li class="disabled"><span>마지막</span></li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </ul>
			</main>
		</div>
	    <%@ include file="../footer.jsp" %>
    </body>
</html>