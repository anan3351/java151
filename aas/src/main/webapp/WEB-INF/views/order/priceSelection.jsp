<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>가격/할인 선택</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/priceSelection.css">
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .container {
    max-width: 1200px;
    margin: 20px auto;
    border: 1px solid #ccc;
    padding: 20px;
  }
  .header {
    background-color: #d9534f;
    padding: 10px;
    text-align: center;
    color: white;
    font-weight: bold;
  }
  .main-content {
    display: flex;
    justify-content: space-between;
  }
  .left-panel {
    width: 75%;
  }
  .right-panel {
    width: 23%;
    border: 1px solid #ccc;
    padding: 10px;
  }
  .price-table {
    width: 100%;
    margin-bottom: 20px;
  }
  .price-table th, .price-table td {
    border: 1px solid #ddd;
    text-align: center;
    padding: 10px;
  }
  .price-info, .coupon-info {
    margin-bottom: 20px;
  }
  .price-info h4, .coupon-info h4 {
    margin-bottom: 10px;
  }
  .btn-block {
    display: block;
    width: 100%;
    margin-bottom: 10px;
  }
</style>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('prev-step-button').addEventListener('click', function() {
      if (confirm("정말로 되돌아가시겠습니까?")) {
        window.location.href = '${pageContext.request.contextPath}/seatSelection';
      }
    });
  });
</script>
</head>
<body>
  <div class="container">
    <div class="header">
      가격/할인 선택
    </div>
    <div class="main-content">
      <div class="left-panel">
        <div class="price-info">
          <h4>가격</h4>
          <p>좌석 1매를 선택하셨습니다.</p>
          <table class="price-table">
            <thead>
              <tr>
                <th>기본가</th>
                <th>금액</th>
                <th>수량</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>일반</td>
                <td>140,000원</td>
                <td>1매</td>
              </tr>
              <tr>
                <td>신한카드(1인2매)5%</td>
                <td>133,000원</td>
                <td>0매</td>
              </tr>
              <tr>
                <td>스테이지 R석 패키지7</td>
                <td>164,800원</td>
                <td>0매</td>
              </tr>
              <tr>
                <td>장애인1~3급(중증/동반1인까지)30%</td>
                <td>98,000원</td>
                <td>0매</td>
              </tr>
              <tr>
                <td>장애인4~6급(경증/본인만)30%</td>
                <td>98,000원</td>
                <td>0매</td>
              </tr>
              <tr>
                <td>국가유공자(본인만)30%</td>
                <td>98,000원</td>
                <td>0매</td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="coupon-info">
          <h4>쿠폰할인</h4>
          <p>해당 상품에 사용 가능한 쿠폰이 없습니다.</p>
        </div>
      </div>
      <div class="right-panel">
        <div class="my-reservation">
          <h4>My예매정보</h4>
          <p>일시: 2024년 8월 1일(목) 19:30</p>
          <p>R석 적석2층 6열-40</p>
          <p>티켓금액: 140,000원</p>
          <p>수수료: 2,000원</p>
          <p>배송료: 0원</p>
          <p>할인/쿠폰: 0원</p>
          <p>총 결제금액: 142,000원</p>
        </div>
        <div class="button-group">
          <button type="button" id="prev-step-button" class="btn btn-default btn-block">이전단계</button>
          <form action="${pageContext.request.contextPath}/deliveryConfirmation" method="get">
            <button type="submit" class="btn btn-danger btn-block">다음단계</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
