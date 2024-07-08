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
          <link rel="stylesheet" href="/css/hall.css">
          <style>
            body {
              font-family: 'Pretendard';
            }

            .main-container {
              display: flex;
              justify-content: center;
              margin-top: 177px;
            }

            .main-container li {
              list-style: none;
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
                          <p class="info-text">${hall.h_call}</p>
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
                            <c:forEach items="${list2}" var="mini" varStatus="status">
                              <li>
                                <c:out value="${mini.miniHall}" />
                                / 좌석수 : ${mini.seat }
                              </li>
                            </c:forEach>
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
            <div class="booking-pay">
            <table  class="table" style="white-space:nowrap">
            <tr>
              <th>하루</th>
              <th>일주일</th>
              <th>한달</th>
              <th>3개월</th>
              <th>6개월</th>
              <th>1년</th>
            </tr>
            <tr>
              <td >100,000</td>
              <td>2%</td>
              <td>3%</td>
              <td>5%</td>
              <td>7%</td>
              <td>10%</td>
            </tr>
            <tr>
              <td colspan="3">총 일수 30일</td>
              <td colspan="3">총 대관료 60만원</td>
            </tr>

            </table>
            </div>
            <script>
              document.addEventListener('DOMContentLoaded', function () {
                console.log("DOMContentLoaded event fired");

                const calendar = document.getElementById('calendar');
                const selectDateBtn = document.getElementById('select-date-btn');
                const selectedDateDisplay = document.getElementById('selected-date-display');
                const currentMonthYear = document.getElementById('current-month-year');
                const prevMonthBtn = document.getElementById('prev-month');
                const nextMonthBtn = document.getElementById('next-month');

                console.log("Calendar Elements:", calendar, selectDateBtn, selectedDateDisplay, currentMonthYear, prevMonthBtn, nextMonthBtn);

                if (!calendar || !selectDateBtn || !selectedDateDisplay || !currentMonthYear || !prevMonthBtn || !nextMonthBtn) {
                  console.error("One or more elements are missing!");
                  return;
                }

                let selectedStartDate = null;
                let selectedEndDate = null;
                let currentYear = new Date().getFullYear();
                let currentMonth = new Date().getMonth();
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                console.log("Initializing the calendar with current year and month:", currentYear, currentMonth);

                function renderCalendar(year, month) {
                  console.log("Rendering calendar for " + year + "-" + (month + 1));
                  const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
                  calendar.innerHTML = '';
                  currentMonthYear.textContent = year + "년 " + (month + 1) + "월";

                  daysOfWeek.forEach(day => {
                    const dayCell = document.createElement('div');
                    dayCell.classList.add('day-of-week');
                    dayCell.textContent = day;
                    calendar.appendChild(dayCell);
                  });

                  const monthDays = new Date(year, month + 1, 0).getDate();
                  const firstDay = new Date(year, month, 1).getDay();
                  console.log("Month days: " + monthDays + ", First day: " + firstDay);

                  for (let i = 0; i < firstDay; i++) {
                    const emptyCell = document.createElement('div');
                    emptyCell.classList.add('empty-cell');
                    calendar.appendChild(emptyCell);
                  }

                  for (let day = 1; day <= monthDays; day++) {
                    const dayCell = document.createElement('div');
                    dayCell.classList.add('day-cell');
                    dayCell.textContent = day;
                    dayCell.setAttribute('data-month', month);
                    dayCell.setAttribute('data-year', year);

                    const cellDate = new Date(year, month, day);
                    console.log("cellDate: " + cellDate + ", today: " + today);

                    if (cellDate < today) {
                      dayCell.classList.add('disabled');
                    } else {
                      if (selectedStartDate && selectedEndDate && cellDate >= selectedStartDate && cellDate <= selectedEndDate) {
                        dayCell.classList.add('selected');
                      }
                      dayCell.addEventListener('click', function () {
                        console.log("Date clicked: " + cellDate);
                        if (!selectedStartDate || (selectedStartDate && selectedEndDate)) {
                          selectedStartDate = new Date(year, month, day);
                          console.log("selectedStartDate set to: " + selectedStartDate);
                          selectedEndDate = null;
                          document.querySelectorAll('.day-cell').forEach(cell => cell.classList.remove('selected'));
                          dayCell.classList.add('selected');
                        } else {
                          selectedEndDate = new Date(year, month, day);
                          console.log("selectedEndDate set to: " + selectedEndDate);
                          if (selectedEndDate < selectedStartDate) {
                            const temp = selectedStartDate;
                            selectedStartDate = selectedEndDate;
                            selectedEndDate = temp;
                            console.log("Swapped dates: " + selectedStartDate + " - " + selectedEndDate);
                          }
                          highlightSelectedRange();
                        }
                        updateSelectedDateDisplay();
                      });
                    }

                    calendar.appendChild(dayCell);
                  }

                  highlightSelectedRange(); // Call this to ensure selected range is highlighted when switching months
                }

                function highlightSelectedRange() {
                  if (!selectedStartDate || !selectedEndDate) return;

                  const startYear = selectedStartDate.getFullYear();
                  const startMonth = selectedStartDate.getMonth();
                  const startDate = selectedStartDate.getDate();

                  const endYear = selectedEndDate.getFullYear();
                  const endMonth = selectedEndDate.getMonth();
                  const endDate = selectedEndDate.getDate();

                  document.querySelectorAll('.day-cell').forEach(cell => {
                    const cellDay = parseInt(cell.textContent);
                    const cellMonth = parseInt(cell.getAttribute('data-month'));
                    const cellYear = parseInt(cell.getAttribute('data-year'));

                    if (
                      (cellYear > startYear || (cellYear === startYear && cellMonth > startMonth) || (cellYear === startYear && cellMonth === startMonth && cellDay >= startDate)) &&
                      (cellYear < endYear || (cellYear === endYear && cellMonth < endMonth) || (cellYear === endYear && cellMonth === endMonth && cellDay <= endDate))
                    ) {
                      cell.classList.add('selected');
                    } else {
                      cell.classList.remove('selected');
                    }
                  });
                }

                function updateSelectedDateDisplay() {
                  console.log("Updating selected date display");
                  if (selectedStartDate && selectedEndDate) {
                    const daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
                    const startDayOfWeek = daysOfWeek[selectedStartDate.getDay()];
                    const endDayOfWeek = daysOfWeek[selectedEndDate.getDay()];
                    const totalDays = Math.ceil((selectedEndDate - selectedStartDate) / (1000 * 60 * 60 * 24)) + 1;
                    selectedDateDisplay.textContent = selectedStartDate.toLocaleDateString() + " (" + startDayOfWeek + ") ~ " + selectedEndDate.toLocaleDateString() + " (" + endDayOfWeek + ") 총 " + totalDays + "일";
                  } else if (selectedStartDate) {
                    selectedDateDisplay.textContent = "시작 날짜: " + selectedStartDate.toLocaleDateString();
                  } else {
                    selectedDateDisplay.textContent = '';
                  }
                }

                selectDateBtn.addEventListener('click', function () {
                  if (selectedStartDate && selectedEndDate) {
                    alert(selectedStartDate.toLocaleDateString() + " ~ " + selectedEndDate.toLocaleDateString() + " 총 " + (Math.ceil((selectedEndDate - selectedStartDate) / (1000 * 60 * 60 * 24)) + 1) + "일");
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
                  console.log("Previous month button clicked: " + currentYear + "-" + currentMonth);
                  renderCalendar(currentYear, currentMonth);
                });

                nextMonthBtn.addEventListener('click', function () {
                  if (currentMonth === 11) {
                    currentMonth = 0;
                    currentYear++;
                  } else {
                    currentMonth++;
                  }
                  console.log("Next month button clicked: " + currentYear + "-" + currentMonth);
                  renderCalendar(currentYear, currentMonth);
                });

                // Initialize the calendar
                console.log("Initializing the calendar with current year and month:", currentYear, currentMonth);
                renderCalendar(currentYear, currentMonth);
              });

            </script>




            <!-- 본문 끝 -->
            <%@ include file="../footer.jsp" %>
        </body>

        </html>