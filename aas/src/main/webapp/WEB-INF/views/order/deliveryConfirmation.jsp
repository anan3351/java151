<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>배송선택/주문자 확인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/deliveryConfirmation.css">
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
    width: 70%;
    border-right: 1px solid #ccc;
    padding-right: 20px;
  }
  .right-panel {
    width: 28%;
    padding-left: 20px;
  }
  .section {
    margin-bottom: 20px;
  }
  .section h4 {
    margin-bottom: 10px;
  }
  .radio-group, .checkbox-group {
    margin-bottom: 10px;
  }
  .radio-group label, .checkbox-group label {
    display: block;
    margin-bottom: 5px;
  }
  .input-group {
    margin-bottom: 10px;
  }
  .input-group input {
    width: 100%;
    padding: 5px;
    border: 1px solid #ccc;
  }
  .summary {
    background-color: #f8f8f8;
    padding: 10px;
    border: 1px solid #ccc;
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
        window.location.href = '${pageContext.request.contextPath}/priceSelection';
      }
    });

    document.querySelector('form').addEventListener('submit', function(event) {
      const name = document.querySelector('input[name="name"]').value.trim();
      const dob = document.querySelector('input[name="dob"]').value.trim();
      const phone = document.querySelector('input[name="phone"]').value.trim();
      const email = document.querySelector('input[name="email"]').value.trim();

      if (!name || !dob || !phone || !email) {
        event.preventDefault();
        alert('이름, 생년월일, 연락처, 이메일을 모두 입력해 주세요.');
      }
    });
  });
</script>
</head>
<body>
  <div class="container">
    <div class="header">
      배송선택/주문자 확인
    </div>
    <div class="main-content">
      <div class="left-panel">
        <div class="section">
          <h4>티켓수령방법</h4>
          <div class="radio-group">
            <label><input type="radio" name="delivery" checked> 현장수령</label>
            <label><input type="radio" name="delivery"> 배송 (3,200원)</label>
          </div>
          <p>티켓현장수령은 예매 시 부여되는 "예약번호"로 관람 당일 티켓을 수령하여 입장합니다.</p>
        </div>
        <div class="section">
          <h4>티켓프리미엄서비스</h4>
          <div class="radio-group"> <!-- radio-group으로 변경 -->
            <label><input type="radio" name="premiumService" value="퍼플"> 스페셜 포장-퍼플 (1,000원)</label>
            <label><input type="radio" name="premiumService" value="화이트"> 스페셜 포장-화이트 (1,000원)</label>
            <label><input type="radio" name="premiumService" value="블랙"> 프리미엄 포장-블랙 (2,000원)</label>
            <label><input type="radio" name="premiumService" value="무료"> TOPING회원전용 (무료)</label>
          </div>
        </div>
        <div class="section">
          <h4>예매자 확인</h4>
          <div class="input-group">
            <label>이름</label>
            <input type="text" name="name" value="">
          </div>
          <div class="input-group">
            <label>생년월일</label>
            <input type="text" name="dob" value="">
          </div>
          <div class="input-group">
            <label>연락처</label>
            <input type="text" name="phone" value="">
          </div>
          <div class="input-group">
            <label>이메일</label>
            <input type="text" name="email" value="">
          </div>
        </div>
      </div>
      <div class="right-panel">
        <div class="summary">
          <h4>My예매정보</h4>
          <p>일시: 2024년 8월 1일(목) 19:30</p>
          <p>R석 적석2층 6열-40</p>
          <p>티켓금액: 140,000원</p>
          <p>수수료: 2,000원</p>
          <p>배송료: 0원 | 현장수령</p>
          <p>할인/쿠폰: 0원</p>
          <p>총 결제금액: 142,000원</p>
          <p>예매취소: 2024년 7월 31일(수) 17:00</p>
        </div>
        <div class="button-group">
          <button type="button" id="prev-step-button" class="btn btn-default btn-block">이전단계</button>
          <form action="${pageContext.request.contextPath}/checkout" method="get">
            <button type="submit" class="btn btn-danger btn-block">다음단계</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
