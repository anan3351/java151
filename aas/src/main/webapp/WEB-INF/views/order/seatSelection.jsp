<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>좌석 선택</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/seatSelection.css">
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
    overflow-x: auto;
  }
  .right-panel {
    width: 23%;
    border: 1px solid #ccc;
    padding: 10px;
  }
  .stage {
    grid-column: span 20;
    background-color: #333;
    color: white;
    text-align: center;
    padding: 10px 0;
    margin-bottom: 20px;
    border-radius: 5px;
  }
  .seat-map {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(40px, 1fr));
    gap: 10px;
    justify-content: center;
  }
  .seat {
    width: 40px;
    height: 40px;
    background-color: #fff;
    border: 1px solid #000;
    border-radius: 5px;
    line-height: 40px;
    text-align: center;
    cursor: pointer;
  }
  .seat.selected {
    background-color: #d9534f;
    color: white;
  }
  .seat-info {
    margin-bottom: 20px;
  }
  .seat-info ul {
    list-style-type: none;
    padding: 0;
  }
  .seat-info ul li {
    margin-bottom: 5px;
  }
  .seat-info .seat-grade {
    display: flex;
    justify-content: space-between;
  }
  .seat-selection-complete {
    text-align: center;
    margin-top: 20px;
  }
</style>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    let selectedSeatCount = 0;
    const seatCountDisplay = document.getElementById('selected-seat-count');
    const seats = document.querySelectorAll('.seat');

    seats.forEach(function(seat) {
      seat.addEventListener('click', function() {
        seat.classList.toggle('selected');
        if (seat.classList.contains('selected')) {
          selectedSeatCount++;
        } else {
          selectedSeatCount--;
        }
        seatCountDisplay.textContent = `총 ${selectedSeatCount}석 선택되었습니다.`;
      });
    });

    document.getElementById('prev-step-button').addEventListener('click', function() {
      if (confirm("정말로 되돌아가시겠습니까?")) {
        window.location.href = '${pageContext.request.contextPath}/order';
      }
    });

    document.getElementById('reset-seats-button').addEventListener('click', function() {
      seats.forEach(function(seat) {
        seat.classList.remove('selected');
      });
      selectedSeatCount = 0;
      seatCountDisplay.textContent = `총 ${selectedSeatCount}석 선택되었습니다.`;
    });

    document.querySelector('form').addEventListener('submit', function(event) {
      if (selectedSeatCount === 0) {
        event.preventDefault();
        alert('좌석을 확인해 주세요.');
      }
    });
  });
</script>
</head>
<body>
  <div class="container">
    <div class="header">
      좌석 선택
    </div>
    <div class="main-content">
      <div class="left-panel">
        <div class="stage">
          <h3>STAGE</h3>
        </div>
        <div class="seat-map">
          <% for (int i = 0; i < 20; i++) { %>
          <% for (int j = 0; j < 30; j++) { %>
          <div class="seat">
            <%= (i * 30 + j + 1) %>
          </div>
          <% } %>
          <% } %>
        </div>
      </div>
      <div class="right-panel">
        <div class="seat-info">
          <h4>좌석등급 / 잔여석</h4>
          <ul>
            <li class="seat-grade">
              <span>VIP석</span>
              <span>0석</span>
              <span>170,000원</span>
            </li>
            <li class="seat-grade">
              <span>R석</span>
              <span>0석</span>
              <span>140,000원</span>
            </li>
            <li class="seat-grade">
              <span>S석</span>
              <span>2석</span>
              <span>110,000원</span>
            </li>
            <li class="seat-grade">
              <span>A석</span>
              <span>0석</span>
              <span>80,000원</span>
            </li>
            <li class="seat-grade">
              <span>시야제한석</span>
              <span>0석</span>
              <span>100,000원</span>
            </li>
          </ul>
        </div>
        <div class="selected-seat-info">
          <h4>선택좌석</h4>
          <p id="selected-seat-count">총 0석 선택되었습니다.</p>
          <p>좌석등급: </p>
          <p>좌석번호: </p>
        </div>
        <div class="seat-selection-complete">
          <form action="${pageContext.request.contextPath}/priceSelection" method="get">
            <button type="submit" class="btn btn-danger btn-block">좌석선택완료</button>
          </form>
          <button type="button" id="prev-step-button" class="btn btn-default btn-block">이전단계</button>
          <button type="button" id="reset-seats-button" class="btn btn-default btn-block">좌석 다시 선택</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
