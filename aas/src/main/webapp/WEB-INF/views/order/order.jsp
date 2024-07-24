<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>예매</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<link rel="stylesheet" href="order.css">
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .container {
    max-width: 1000px;
    margin: 20px auto;
    border: 1px solid #ccc;
    padding: 20px;
  }
  .header, .footer {
    background-color: #f8f8f8;
    padding: 10px 0;
    text-align: center;
  }
  .main-content {
    display: flex;
    justify-content: space-between;
  }
  .left-panel {
    width: 70%;
  }
  .right-panel {
    width: 28%;
    border: 1px solid #ccc;
    padding: 10px;
  }
  .calendar {
    margin-bottom: 20px;
  }
  .calendar .weekdays, .calendar .days {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
  }
  .calendar .day, .calendar .weekday {
    padding: 10px; /* 박스 크기를 키움 */
    text-align: center;
    border: 1px solid #ddd;
    cursor: pointer;
    color: black; /* 날짜 숫자의 색상을 검은색으로 설정 */
    font-size: 16px; /* 날짜 숫자의 폰트 크기를 키움 */
  }
  .calendar .weekday {
    background-color: #e6e6fa;
  }
  .calendar .day.selected-date {
    background-color: #f2dede;
    color: black; /* 선택된 날짜의 색상도 검은색으로 설정 */
  }
  .calendar .day.empty {
    border: none;
    cursor: default;
  }
  .showtimes {
    margin-bottom: 20px;
  }
  .showtimes .time-slot {
    display: flex;
    flex-direction: column; /* 세로 방향으로 변경 */
  }
  .showtimes .time-slot span {
    margin-bottom: 5px; /* 각 회차 사이에 간격 추가 */
    padding: 5px;
    border: 1px solid #ddd;
    cursor: pointer;
  }
  .showtimes .time-slot span.selected {
    background-color: #f2dede;
  }
  .seat-selection, .notice, .my-reservation {
    margin-bottom: 20px;
  }
  .seat-selection .seat, .my-reservation .reservation-detail {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
  }
  .seat {
    padding: 5px;
    border: 1px solid #ddd;
    margin-right: 5px;
  }
  .seat.selected {
    background-color: #f2dede;
  }
  .notice ul {
    list-style-type: none;
    padding: 0;
  }
  .notice ul li {
    margin-bottom: 5px;
  }
</style>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const calendarBody = document.querySelector(".calendar .days");
    let selectedDate = null;
    let selectedTimeSlot = null;

    calendarBody.addEventListener("click", function(event) {
      if (event.target.classList.contains("day") && !event.target.classList.contains("empty")) {
        document.querySelectorAll(".calendar .day").forEach(function(day) {
          day.classList.remove("selected-date");
        });
        event.target.classList.add("selected-date");
        selectedDate = event.target.textContent;
      }
    });

    const timeSlots = document.querySelectorAll(".showtimes .time-slot span");
    timeSlots.forEach(function(slot) {
      slot.addEventListener("click", function() {
        timeSlots.forEach(function(s) {
          s.classList.remove("selected");
        });
        slot.classList.add("selected");
        selectedTimeSlot = slot.textContent;
      });
    });

    document.querySelector('form').addEventListener('submit', function(event) {
      if (!selectedDate || !selectedTimeSlot) {
        event.preventDefault();
        alert('관람일과 회차를 선택해 주세요.');
      }
    });
  });
</script>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>티켓예매</h1>
    </div>
    <div class="main-content">
      <div class="left-panel">
        <div class="calendar">
          <h3>관람일 선택</h3>
          <div class="weekdays">
            <div class="weekday">일</div>
            <div class="weekday">월</div>
            <div class="weekday">화</div>
            <div class="weekday">수</div>
            <div class="weekday">목</div>
            <div class="weekday">금</div>
            <div class="weekday">토</div>
          </div>
          <div class="days">
            <div class="day">1</div>
            <div class="day">2</div>
            <div class="day">3</div>
            <div class="day">4</div>
            <div class="day">5</div>
            <div class="day">6</div>
            <div class="day">7</div>
            <div class="day">8</div>
            <div class="day">9</div>
            <div class="day">10</div>
            <div class="day">11</div>
            <div class="day">12</div>
            <div class="day">13</div>
            <div class="day">14</div>
            <div class="day">15</div>
            <div class="day">16</div>
            <div class="day">17</div>
            <div class="day">18</div>
            <div class="day">19</div>
            <div class="day">20</div>
            <div class="day">21</div>
            <div class="day">22</div>
            <div class="day">23</div>
            <div class="day">24</div>
            <div class="day">25</div>
            <div class="day">26</div>
            <div class="day">27</div>
            <div class="day">28</div>
            <div class="day">29</div>
            <div class="day">30</div>
            <div class="day">31</div>
          </div>
        </div>
        <div class="showtimes">
          <h3>회차 선택</h3>
          <div class="time-slot">
            <span>14시 30분</span>
            <span>19시 30분</span>
          </div>
        </div>
        <div class="seat-selection">
          <h3>좌석등급 / 잔여석</h3>
          <div class="seat">VIP석 (0석)</div>
          <div class="seat">R석 (0석)</div>
          <div class="seat">S석 (0석)</div>
          <div class="seat">A석 (0석)</div>
        </div>
        <div class="notice">
          <h3>유의사항</h3>
          <ul>
            <li>장애인, 국가유공자 할인가격 예매 시 현장수령만 가능합니다.</li>
            <li>할인증빙서를 미지참시 차액을 지불하셔야 합니다.</li>
            <li>예매 취소시 수수료가 발생할 수 있습니다.</li>
            <li>모바일 티켓으로 입장이 가능합니다.</li>
            <li>기타 상세 유의사항은 홈페이지를 참조하세요.</li>
          </ul>
        </div>
      </div>
      <div class="right-panel">
        <div class="my-reservation">
          <h3>My예매정보</h3>
          <div class="reservation-detail">
            <span>일시</span>
            <span>2024년 7월 24일(수) 14:30</span>
          </div>
          <div class="reservation-detail">
            <span>선택좌석</span>
            <span>(0석)</span>
          </div>
          <div class="reservation-detail">
            <span>티켓금액</span>
            <span>0원</span>
          </div>
          <div class="reservation-detail">
            <span>수수료</span>
            <span>0원</span>
          </div>
          <div class="reservation-detail">
            <span>할인</span>
            <span>0원</span>
          </div>
          <div class="reservation-detail">
            <span>총 결제금액</span>
            <span>0원</span>
          </div>
           <form action="seatSelection" method="get">
            <button type="submit" class="btn btn-danger btn-block">다음단계</button>
          </form>
        </div>
      </div>
    </div>
    <div class="footer">
      <p>&copy; 2024 All About Show</p>
    </div>
  </div>
</body>
</html>
