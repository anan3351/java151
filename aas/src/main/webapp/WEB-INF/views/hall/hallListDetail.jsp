<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>main</title>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
          <link rel="stylesheet" href="/css/template.css">

          <style>
            body {
              font-family: 'Pretendard';
            }

            .main-container {
              display: flex;
              justify-content: center;
              margin-top : 177px;
            }

            .main-container li {
              list-style: none;
            }

            .page-tit {
              font-size: 32px;
              font-weight: 700;
            }

            .detail-wrap {
              height: calc(100vh - 406px);
              display: flex;
              width: 1600px;
              margin-top: 40px;
            }

            .left-area {
              display: flex;
              width: calc(100% / 2 - 20px);
              gap: 20px;
              margin-right: 20px;
            }

            .left-area img {
              width: 300px;
              height: 400px;
              background-color: #efefef;
            }

            .left-area .detail-info {}

            .detail-info ul {
              display: flex;
              flex-direction: column;
              gap: 10px
            }

            .detail-info .info-label {
              font-size: 18px;
            }

            .detail-info .info-text {
              font-size: 16px;
            }

            .right-area {
              width: calc(100% / 2);
              gap: 20px
            }


            .booking {
              display: flex;
              gap: 20px;
            }

            .booking .calendar {
              width: calc(100% / 2 - 20px);
              height: 320px;
              background-color: #efefef;
            }

            .booking .option-area {}

            .option-tit {
              font-size: 20px;
              font-weight: 600;
              margin-bottom: 10px;
            }

            .option-list {
              height: 290px;
              overflow-y: auto;
              padding: 5px;
            }

            .option-list ul {
              padding-left: 0;
              display: flex;
              flex-direction: column;
              gap: 10px
            }

            .option-list ul li {
              font-size: 16px;
              width: 100%;
              height: 50px;
              background-color: #efefef;
              border-radius: 10px;
              color: #1d1d1d;
              font-weight: 500;
              display: flex;
              align-items: center;
              padding: 10px;
              cursor: pointer;
            }

            .option-list ul li:hover {
              background-color: #8e43e7;
              color: #fff;
              font-weight: 700;
            }

            .option-area {
              width: calc(100% / 2);
              height: 320px;
            }

            .btn-area {
              display: flex;
              gap: 10px;
              margin-top: 40px;
              width: 100%;
              justify-content: end;
            }

            .btn-area .btn {
              height: 50px;
              font-size: 16px;
              font-weight: 600;
            }

            .btn-booking {
              width: 50%;
              background-color: #8e43e7 !important;
              color: #fff;
            }

            .btn-booking:hover {
              color: #fff !important;
            }

            .btn-bookmark {
              width: 150px;
              border: 1px solid #8e43e7 !important;
              background-color: #fff !important;
              color: #8e43e7;
            }

            .btn-bookmark:hover {
              color: #8e43e7 !important;
            }

            .calendar-container {
              background: #fff;
              border-radius: 10px;
              box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
              overflow: hidden;
              width: 300px;
              text-align: center;
            }

            .calendar-header {
              display: flex;
              justify-content: space-between;
              align-items: center;
              padding: 10px;
              background-color: #8e43e7;
              color: white;
            }

            #calendar {
              display: grid;
              grid-template-columns: repeat(7, 1fr);
              gap: 1px;
              background: #ddd;
            }

            #calendar div {
              padding: 10px;
              background: #fff;
              text-align: center;
            }

            #calendar .day-cell {
              cursor: pointer;
            }

            #calendar .day-cell:hover {
              background-color: #e0e0e0;
            }

            #calendar .selected {
              background-color: #eabff3;
              color: white;
            }

            #select-date-btn {
              width: 100%;
              padding: 15px 0;
              background-color: #8e43e7;
              color: white;
              border: none;
              cursor: pointer;
              font-size: 16px;
            }

            #select-date-btn:hover {
              background-color: #c99fec;
            }

            #selected-date-display {
              margin-top: 10px;
              font-size: 16px;
              color: #333;
            }

            #calendar .disabled {
              color: #ccc;
              cursor: not-allowed;
            }

            #prev-month {
              background-color: #fff;
              /* 원하는 배경색으로 변경 */
              color: rgb(0, 0, 0);
              /* 텍스트 색상 */
              border: none;
              /* 테두리 제거 */
              padding: 10px 20px;
              /* 여백 조정 */
              cursor: pointer;
              /* 커서 모양 변경 */
              border-radius: 5px;
              /* 모서리 둥글게 */
            }

            #prev-month:hover {
              background-color: #eed6f5;
              /* 호버 시 배경색 */
            }

            #next-month {
              background-color: #fff;
              /* 원하는 배경색으로 변경 */
              color: #333;
              /* 텍스트 색상 */
              border: 1px;
              /* 테두리 제거 */
              padding: 10px 20px;
              /* 여백 조정 */
              cursor: pointer;
              /* 커서 모양 변경 */
              border-radius: 5px;
              /* 모서리 둥글게 */
            }

            #next-month:hover {
              background-color: #eed6f5;
              /* 호버 시 배경색 */
            }
            
            
          </style>
        </head>

        <body>
          <%@ include file="../header.jsp" %>
            <div class="main-container">
              <!-- 본문시작 -->
              <div class="page-wrap">
                <button type="button" class="btn btn-outline-secondary">목록으로</button>
                <h3 class="page-tit">${hall.hname}
                </h3>

                <div class="detail-wrap">
                  <div class="left-area">
                    <div class="img">
                      <img src="<c:url value='/images/musichall.jpg' />" alt="오류">
                    </div>
                    <div class="detail-info">
                      <ul>
                        <li>
                          <strong class="info-label">주소</strong>
                          <p class="info-text">${hall.addr}</p>
                        </li>
                        <li>
                          <strong class="info-label">전화번호</strong>
                          <p class="info-text">${hall.tel}</p>
                        </li>
                        <li>
                          <strong class="info-label">URL</strong>
                          <p class="info-text">${hall.url}</p>
                        </li>
                        <li>
                          <strong class="info-label">좌석수</strong>
                          <p class="info-text">${hall.seat}</p>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div class="right-area">
                    <div class="booking">
                      <div class="calendar-container">
                        <div class="calendar-header">
                          <button id="prev-month">이전</button>
                          <div id="current-month-year"></div>
                          <button id="next-month">다음</button>
                        </div>
                        <div id="calendar"></div>
                        <button id="select-date-btn">날짜 선택</button>
                        <div id="selected-date-display"></div>
                      </div>
                      <div class="option-area">
                        <div class="option-tit">공연관 선택</div>
                        <div class="option-list">
                          <ul>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                            <li>공연관 옵션</li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <div class="btn-area">
                      <button type="button" class="btn btn-booking">예약하기</button>
                      <button type="button" class="btn btn-bookmark">찜하기</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <script>
              document.addEventListener('DOMContentLoaded', function () {
                  console.log("DOMContentLoaded event fired"); // 디버깅용 로그 메시지
          
                  const calendar = document.getElementById('calendar');
                  const selectDateBtn = document.getElementById('select-date-btn');
                  const selectedDateDisplay = document.getElementById('selected-date-display');
                  const currentMonthYear = document.getElementById('current-month-year');
                  const prevMonthBtn = document.getElementById('prev-month');
                  const nextMonthBtn = document.getElementById('next-month');
          
                  console.log("Calendar Elements:", calendar, selectDateBtn, selectedDateDisplay, currentMonthYear, prevMonthBtn, nextMonthBtn); // 디버깅용 로그 메시지
          
                  let selectedStartDate = null;
                  let selectedEndDate = null;
                  let currentYear = new Date().getFullYear();
                  let currentMonth = new Date().getMonth();
                  const today = new Date();
                  today.setHours(0, 0, 0, 0);
          
                  function renderCalendar(year, month) {
                      console.log(`Rendering calendar for ${year}-${month + 1}`); // 디버깅용 로그 메시지
                      const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
                      calendar.innerHTML = '';
                      currentMonthYear.textContent = `${year}년 ${month + 1}월`;
          
                      daysOfWeek.forEach(day => {
                          const dayCell = document.createElement('div');
                          dayCell.classList.add('day-of-week');
                          dayCell.textContent = day;
                          calendar.appendChild(dayCell);
                      });
          
                      const monthDays = new Date(year, month + 1, 0).getDate();
                      const firstDay = new Date(year, month, 1).getDay();
          
                      for (let i = 0; i < firstDay; i++) {
                          const emptyCell = document.createElement('div');
                          emptyCell.classList.add('empty-cell');
                          calendar.appendChild(emptyCell);
                      }
          
                      for (let day = 1; day <= monthDays; day++) {
                          const dayCell = document.createElement('div');
                          dayCell.classList.add('day-cell');
                          dayCell.textContent = day;
          
                          const cellDate = new Date(year, month, day);
          
                          if (cellDate < today) {
                              dayCell.classList.add('disabled');
                          } else {
                              dayCell.addEventListener('click', function () {
                                  console.log(`Date clicked: ${cellDate}`); // 디버깅용 로그 메시지
                                  if (!selectedStartDate || (selectedStartDate && selectedEndDate)) {
                                      selectedStartDate = new Date(year, month, day);
                                      selectedEndDate = null;
                                      document.querySelectorAll('.day-cell').forEach(cell => cell.classList.remove('selected'));
                                      dayCell.classList.add('selected');
                                  } else {
                                      selectedEndDate = new Date(year, month, day);
                                      if (selectedEndDate < selectedStartDate) {
                                          const temp = selectedStartDate;
                                          selectedStartDate = selectedEndDate;
                                          selectedEndDate = temp;
                                      }
                                      document.querySelectorAll('.day-cell').forEach(cell => cell.classList.remove('selected'));
                                      highlightSelectedRange();
                                  }
                                  updateSelectedDateDisplay();
                              });
                          }
          
                          calendar.appendChild(dayCell);
                      }
                  }
          
                  function highlightSelectedRange() {
                      if (!selectedStartDate || !selectedEndDate) return;
          
                      const start = selectedStartDate.getDate();
                      const end = selectedEndDate.getDate();
                      const startMonth = selectedStartDate.getMonth();
                      const endMonth = selectedEndDate.getMonth();
                      const dayCells = document.querySelectorAll('.day-cell');
          
                      if (startMonth === endMonth) {
                          for (let day = start; day <= end; day++) {
                              const dayCell = Array.from(dayCells).find(cell => parseInt(cell.textContent) === day);
                              if (dayCell) {
                                  dayCell.classList.add('selected');
                              }
                          }
                      }
                  }
          
                  function updateSelectedDateDisplay() {
                      console.log("Updating selected date display"); // 디버깅용 로그 메시지
                      if (selectedStartDate && selectedEndDate) {
                          const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
                          const startDayOfWeek = daysOfWeek[selectedStartDate.getDay()];
                          const endDayOfWeek = daysOfWeek[selectedEndDate.getDay()];
                          const totalDays = Math.ceil((selectedEndDate - selectedStartDate) / (1000 * 60 * 60 * 24)) + 1;
                          selectedDateDisplay.textContent = `${selectedStartDate.toLocaleDateString()} (${startDayOfWeek}) ~ ${selectedEndDate.toLocaleDateString()} (${endDayOfWeek}) 총 ${totalDays}일`;
                      } else if (selectedStartDate) {
                          selectedDateDisplay.textContent = `시작 날짜: ${selectedStartDate.toLocaleDateString()}`;
                      } else {
                          selectedDateDisplay.textContent = '';
                      }
                  }
          
                  selectDateBtn.addEventListener('click', function () {
                      if (selectedStartDate && selectedEndDate) {
                          alert(`${selectedStartDate.toLocaleDateString()} ~ ${selectedEndDate.toLocaleDateString()} 총 ${Math.ceil((selectedEndDate - selectedStartDate) / (1000 * 60 * 60 * 24)) + 1}일`);
                          // 여기서 선택된 기간을 서버로 전송하는 코드를 추가하면 됩니다.
                      } else {
                          alert('시작 날짜와 종료 날짜를 모두 선택해 주세요.');
                      }
                  });
          
                  prevMonthBtn.addEventListener('click', function () {
                      if (currentMonth === 0) {
                          currentMonth = 11;
                          currentYear--;
                      } else {
                          currentMonth--;
                      }
                      console.log(`Previous month button clicked: ${currentYear}-${currentMonth + 1}`); // 디버깅용 로그 메시지
                      renderCalendar(currentYear, currentMonth);
                  });
          
                  nextMonthBtn.addEventListener('click', function () {
                      if (currentMonth === 11) {
                          currentMonth = 0;
                          currentYear++;
                      } else {
                          currentMonth++;
                      }
                      console.log(`Next month button clicked: ${currentYear}-${currentMonth + 1}`); // 디버깅용 로그 메시지
                      renderCalendar(currentYear, currentMonth);
                  });
          
                  // Initialize the calendar
                  console.log("Initializing the calendar with current year and month:", currentYear, currentMonth); // 디버깅용 로그 메시지
                  renderCalendar(currentYear, currentMonth);
              });
          </script>
          
          
          

            <!-- 본문 끝 -->
            <%@ include file="../footer.jsp" %>
        </body>

        </html>