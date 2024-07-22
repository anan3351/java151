<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>Role Upload</title>
    <style>
        .role-choice {
            display: inline-block;
            width: 100px;
            height: 30px;
            vertical-align: middle;
        }

        .role-radio {
            width: 10px;
            height: 10px;
            margin-right: 5px;
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
                배역 등록
            </div><br>
            <form name="rolefrm" id="rolefrm" method="post" action="roleInsert" onsubmit="return roleCheck();">
                <div class="table-container">
                    <div style="text-align: left; color: red; font-size:13px">&nbsp;&nbsp;* 은 필수 입력 항목입니다</div>
                    <table class="table table-hover" style="width:100%">
                        <tbody style="text-align: left;">
                            <tr>
                                <td><span class="sp">* </span>배역</td>
                                <td>
                                    <div>
                                        <c:forEach items="${roleList}" var="role">
                                            <label class="role-choice" style="display: inline-block; width: 100px; height: 30px; vertical-align: middle;">
											    <input type="radio" name="casting" value="${role}" class="form-control role-radio" style="width: 10px; height: 10px; margin-right: 5px;">
											    ${role}
											</label>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>배우</td>
                                <td><input type="text" name="actorId" class="form-control" readonly></td>
                                <td><input type="button" class="btn btn-default" id="actor_search" value="검색" onclick="actorSearch()"></td>
                            </tr>
                        </tbody>
                    </table>
                </div><hr>
                <input type="submit" value="등록" class="btn btn-default" style="background-color: white; color: black;">
                <br><br>
            </form>
        </main>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>