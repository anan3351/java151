<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <link rel="stylesheet" href="/css/seller.css">
    <script src="/js/seller.js"></script>
    <title>Hall List</title>
</head>
<body>
    <br>
    <table class='table'>
        <thead>
            <tr>
                <th style='text-align:left; width: 8%'>선택</th>
                <th style='text-align:left; width: 15%'>공연장ID</th>
                <th style='text-align:left'>공연장명</th>
                <th style='text-align:left'>세부관</th>
                <th style='text-align:left'>주소</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="hall" items="${ulist.content}">
                <tr>
                    <td style="width: 8%"><input type='radio' name='selected_hall' value='${hall.hall_id}'></td>
                    <td style="width: 15%">${hall.hall_id}</td>
                    <td>${hall.h_name}</td>
                    <td>${hall.miniHall != null ? hall.miniHall : '-'}</td>
                    <td>${hall.addr}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <!-- 페이징 시작 -->
    <div class="text-xs-center">
        <ul class="pagination justify-content-center">
        
            <c:url value="/seller/hallList" var="pageUrl">
                <c:param name="h_name" value="${h_name}"/>
            </c:url>

            <c:if test="${!ulist.first}">
                <li class="page-item">
                    <a class="page-link" href="#" data-page="0">처음</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#" data-page="${ulist.number - 1}">←</a>
                </li>
            </c:if>
    
            <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
                <c:choose>
                    <c:when test="${ulist.pageable.pageNumber + 1 == i}">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" data-page="${i - 1}">${i}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="#" data-page="${i - 1}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
    
            <c:if test="${!ulist.last}">
                <li class="page-item">
                    <a class="page-link" href="#" data-page="${ulist.number + 1}">→</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#" data-page="${ulist.totalPages - 1}">마지막</a>
                </li>
            </c:if>
        </ul>
    </div>
    
    <button onclick='selectHall(); return false;' class='btn btn-default'>선택</button> &nbsp;&nbsp;조회 건수: ${totalElements}건
    
</body>
</html>