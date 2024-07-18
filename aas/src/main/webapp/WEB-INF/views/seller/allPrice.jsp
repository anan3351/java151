<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>All Price</title>
    
    <style>
        .modal-body {
            overflow-y: auto;
            max-height: 400px;
        }
    </style>
</head>
<body>
    <div class="modal-header">
        <span class="close" onclick="closePrice()">&times;</span>
        <h3>전체 가격</h3>
    </div>
    <div class="modal-body">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th style='text-align:left'>좌석등급</th>
                    <th style='text-align:left'>할인명</th>
                    <th style='text-align:left'>할인율</th>
                    <th style='text-align:left'>할인가</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${priceList}" var="price" varStatus="loop">
				    <c:if test="${loop.index == 0 || !price['seat_level'].equals(priceList[loop.index - 1]['seat_level'])}">
				        <c:set var="rowspanCount" value="0" />
				        <c:forEach items="${priceList}" var="innerPrice">
				            <c:if test="${innerPrice['seat_level'] == price['seat_level']}">
				                <c:set var="rowspanCount" value="${rowspanCount + 1}" />
				            </c:if>
				        </c:forEach>
				        <tr>
				            <td rowspan="${rowspanCount}">${price['seat_level']}</td>
				            <td>${price['dis_name']}</td>
				            <td>${price['dis_rate']}%</td>
				            <td><fmt:formatNumber value="${price['price'] * (100 - price['dis_rate']) / 100}" pattern="#,###"/>원</td>
				        </tr>
				    </c:if>
				    <c:if test="${loop.index != 0 && price['seat_level'].equals(priceList[loop.index - 1]['seat_level'])}">
				        <tr>
				            <td>${price['dis_name']}</td>
				            <td>${price['dis_rate']}%</td>
				            <td><fmt:formatNumber value="${price['price'] * (100 - price['dis_rate']) / 100}" pattern="#,###"/>원</td>
				        </tr>
				    </c:if>
				</c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
