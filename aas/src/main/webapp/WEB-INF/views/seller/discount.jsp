<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Discount Upload</title>
    <style>
        .seat-label {
            display: inline-block;
            width: 100px;
            height: 30px;
            vertical-align: middle;
        }

        .seat-checkbox {
            width: 10px;
            height: 10px;
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
                할인 등록
            </div><br>
            <form name="disfrm" id="disfrm" method="post" action="disInsert" onsubmit="return discount();">
                <input type="hidden" id="dis_range" name="dis_range" class="form-control">
                <div class="table-container">
                    <div style="text-align: left; color: red; font-size:13px">&nbsp;&nbsp;* 은 필수 입력 항목입니다</div>
                    <table class="table table-hover" style="width:100%">
                        <tbody style="text-align: left;">
                            <tr>
                                <td><span class="sp">* </span>할인명</td>
                                <td><input type="text" name="dis_name" class="form-control"></td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>좌석등급</td>
                                <td>
                                    <div>
                                        <c:forEach items="${seatList}" var="seat">
                                            <label class="seat-label">
                                                <input type="checkbox" name="dis_range_checkbox" value="${seat}" class="form-control seat-checkbox">
                                                ${seat}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>할인율(%)</td>
                                <td><input type="number" name="dis_rate" class="form-control"></td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>할인정보</td> 
                                <td><textarea name="dis_info" rows="4" cols="50" class="form-control"></textarea></td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>적용 시작일시</td>
                                <td><input type="datetime-local" name="dis_start" class="form-control"></td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>적용 종료일시</td>
                                <td><input type="datetime-local" name="dis_end" class="form-control"></td>
                            </tr>
                            <tr>
                                <td><span class="sp">* </span>현장확인</td>
                                <td>
                                    <select name="dis_check" class="form-control">
                                        <option value="">선택</option>
                                        <option value="Y">Y</option>
                                        <option value="N">N</option>
                                        <option value="YN">YN</option>
                                    </select>
                                </td>
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
