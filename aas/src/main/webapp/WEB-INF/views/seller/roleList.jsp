<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>Role List</title>
    <style>
        .table-hover {
            width: 60%;
            margin: 0 auto; /* 테이블을 가운데 정렬 */
        }
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <%@ include file="./sidebar.jsp" %>
        <main>
            <br>
            <div style="font-size: 20px; font-weight: bold; text-align: center;">
                배역 목록
                <br>
                <input type="button" class="btn btn-default" value="배우 등록" onclick="window.location.href='./role'" style="float: right;">
            </div><br><br>

            <div class="table-wrap">
                <table class="table table-hover">
                    <c:if test="${not empty roles}">
                        <thead>
                            <tr>
                                <th style='text-align:left'>배역</th>
                                <th style='text-align:left'>배우</th>
                                <th style='text-align:left; width: 20%'></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${roles}">
                                <c:set var="rowCount" value="${fn:length(entry.value)}"/>
                                <c:forEach var="actorInfo" items="${entry.value}" varStatus="status">
                                    <tr>
                                        <c:if test="${status.index == 0}">
                                            <td rowspan="${rowCount}">${entry.key}</td>
                                        </c:if>
                                        <td>${actorInfo.a_name}</td>
                                        <td style="width: 20%">
                                            <input type="button" class="btn btn-default" value="수정" onclick="window.location.href='../${actorInfo.casting_id}/roleUpdate'">
                                            <input type="button" class="btn btn-default" value="삭제" onclick="deleteRole(${actorInfo.actor_id}, '${show_id}')">
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </c:if>
                </table>
                
                <c:if test="${empty roles}">
                    <p style="text-align: center;">등록된 배우가 없습니다.</p>
                </c:if>
            </div>
        </main>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
