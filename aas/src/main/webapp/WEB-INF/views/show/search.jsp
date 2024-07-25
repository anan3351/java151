<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../css/template.css">
    <link rel="stylesheet" href="../css/show.css">
    <title>Search</title>
    <style>
        .pagination {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .pagination li {
            margin: 0 5px;
        }

        .pagination li a {
            text-decoration: none;
            color: #337ab7;
        }

        .pagination li.active span {
            background-color: #337ab7;
            color: white;
        }

        .pagination li.disabled span {
            color: #ccc;
        }
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container"><br>
        <div class="hot-section" style="font-size: 30px; font-weight: bold; text-align: center;">
            "${title}" 검색결과
        </div>
        <div class="container"><hr><br>
            <div class="table-wrap">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style='text-align:left'>공연ID</th>
                            <th style='text-align:left; width: 18%'>제목</th>
                            <th style='text-align:left'>장르</th>
                            <th style='text-align:left'>공연장</th>
                            <th style='text-align:left; width: 20%'>관</th>
                            <th style='text-align:left'>공연기간</th>
                            <th style='text-align:left'>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="show" items="${ulist.content}">
                            <tr>
                                <td style='text-align:left'><a href="detail/${show.show_id}">${show.show_id}</a></td>
                                <td style="width: 18%; text-align:left">${show.title}</td>
                                <td style='text-align:left'>${show.genre}</td>
                                <td style='text-align:left'>${show.h_name}</td>
                                <td style="width: 20%; text-align:left">${show.miniHall}</td>
                                <td style='text-align:left'>${show.start_day} ~ ${show.end_day}</td>
                                <td style='text-align:left'>${show.state}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <ul class="pagination">
                <c:if test="${totalPages > 1}">
                    <c:choose>
                        <c:when test="${currentPage > 0}">
                            <li><a href="?title=${title}&page=0">처음</a></li>
                            <li><a href="?title=${title}&page=${currentPage - 1}">←</a></li>
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
                                <li><a href="?title=${title}&page=${i}">${i + 1}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPages - 1}">
                            <li><a href="?title=${title}&page=${currentPage + 1}">→</a></li>
                            <li><a href="?title=${title}&page=${totalPages - 1}">마지막</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="disabled"><span>→</span></li>
                            <li class="disabled"><span>마지막</span></li>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </ul>
            &nbsp;&nbsp;조회 건수: ${totalElements}건
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
