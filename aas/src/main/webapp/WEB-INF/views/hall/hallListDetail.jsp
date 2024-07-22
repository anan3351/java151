<%@page import="com.example.demo.user.UserDTO" %>
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
                margin-top: 150px;
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
                  <button type="button" class="btn btn-info" style="background-color: #be9ed8; border-color: #be9ed8;"
                    onclick="location.href='<c:url value=" /hall/list" />'">목록으로</button>

                  <div class="detail-wrap">
                    <div class="left-area">
                      <div class="img">
                        <img src="<c:url value='/images/musichall.jpg' />" alt="오류">
                      </div>
                      <div class="detail-info">
                        <ul>
                          <li>
                            <strong class="info-label2">${hall.h_name}</strong>
                          </li>
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
                        </div>
                        <div class="option-area">
                          <div class="option-tit">공연관 선택</div>
                          <div class="option-list">
                            <ul>
                              <c:forEach items="${list2}" var="mini" varStatus="status">
                                <li class="clickable" data-mini-hall="${mini.miniHall}" data-seat="${mini.seat}"
                                  data-h-day="${mini.h_day}" data-hall-id="${mini.hall_id}"
                                  data-hallPay-id="${mini.hallPay_id}">
                                  ${mini.miniHall} &nbsp;/ 좌석수: ${mini.seat } / 1DAY :
                                  <fmt:formatNumber value="${mini.h_day}" type="number" groupingUsed="true" />원
                                </li>
                              </c:forEach>
                            </ul>
                          </div>
                        </div>

                      </div>
                      <div class="btn-area">
                        <button type="button" class="btn btn-booking" onclick="submitOrder()">예약하기</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="booking-pay">
                <table class="table dicount-table">
                  <tr>
                    <th style="width: 12%; height: 5%;"></th>
                    <th style="width: 12%;">일주일</th>
                    <th style="width: 12%;">한달</th>
                    <th style="width: 12%;">3개월</th>
                    <th style="width: 12%;">6개월</th>
                    <th style="width: 12%;">1년</th>
                  </tr>
                  <tr>
                    <th style="width: 12%;">할인율</th>
                    <td>2%</td>
                    <td>3%</td>
                    <td>5%</td>
                    <td>7%</td>
                    <td>10%</td>
                  </tr>
                </table>
                <table class="table amount-table">
                  <tr>
                    <th>선택 날짜</th>
                    <td colspan="2" id="selected-date-display"></td>
                  </tr>
                  <tr>
                    <th>공연관</th>
                    <td id="selected-hall" colspan="2"></td>
                  </tr>
                  <tr>
                    <th>총 대관일</th>
                    <td id="selected-date-display2" style="font-size: 18px; color: #ff0000;"></td>
                    <td>일</td>
                  </tr>
                  <tr>
                    <th>결제금액</th>
                    <td id="price-per-day" style="font-size: 18px; color: #ff0000;"></td>
                    <td>원</td>
                    <td id="selected-hall-id" style="display: none;"></td>
                    <td id="selected-hallPay-id" style="display: none;"></td>
                  </tr>

                </table>

              </div>
              <% UserDTO loggedInUser=(UserDTO) session.getAttribute("loggedInUser"); String userId=loggedInUser !=null
                ? loggedInUser.getUser_id() : "" ; %>

                <script type="text/javascript">
                  var userId = "<%= userId %>";
                </script>
                <script>

                  let selectedStartDate = null;
                  let selectedEndDate = null;
                  let currentYear = new Date().getFullYear();
                  let currentMonth = new Date().getMonth();
                  let totalDays = 0;

                  document.addEventListener('DOMContentLoaded', function () {
                    const calendar = document.getElementById('calendar');
                    const selectedDateDisplay = document.getElementById('selected-date-display');
                    const selectedDateDisplay2 = document.getElementById('selected-date-display2');
                    const currentMonthYear = document.getElementById('current-month-year');
                    const prevMonthBtn = document.getElementById('prev-month');
                    const nextMonthBtn = document.getElementById('next-month');
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    function renderCalendar(year, month) {
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

                        if (cellDate < today) {
                          dayCell.classList.add('disabled');
                        } else {
                          if (selectedStartDate && selectedEndDate && cellDate >= selectedStartDate && cellDate <= selectedEndDate) {
                            dayCell.classList.add('selected');
                          }
                          dayCell.addEventListener('click', function () {
                            const clickedDate = new Date(year, month, day);
                            if (!selectedStartDate || (selectedStartDate && selectedEndDate)) {
                              selectedStartDate = clickedDate;
                              selectedEndDate = null;
                              document.querySelectorAll('.day-cell').forEach(cell => cell.classList.remove('selected'));
                              this.classList.add('selected');
                            } else {
                              selectedEndDate = clickedDate;
                              if (selectedEndDate < selectedStartDate) {
                                [selectedStartDate, selectedEndDate] = [selectedEndDate, selectedStartDate];
                              }
                              highlightSelectedRange();
                            }
                            updateSelectedDateDisplay();
                          });
                        }

                        calendar.appendChild(dayCell);
                      }

                      highlightSelectedRange();
                    }

                    function highlightSelectedRange() {
                      if (!selectedStartDate || !selectedEndDate) return;

                      document.querySelectorAll('.day-cell').forEach(cell => {
                        const cellDay = parseInt(cell.textContent);
                        const cellMonth = parseInt(cell.getAttribute('data-month'));
                        const cellYear = parseInt(cell.getAttribute('data-year'));
                        const cellDate = new Date(cellYear, cellMonth, cellDay);

                        if (cellDate >= selectedStartDate && cellDate <= selectedEndDate) {
                          cell.classList.add('selected');
                        } else {
                          cell.classList.remove('selected');
                        }
                      });
                    }

                    function updateSelectedDateDisplay() {
                      const options = { year: 'numeric', month: '2-digit', day: '2-digit' };

                      if (selectedStartDate && selectedEndDate) {
                        const startStr = selectedStartDate.toLocaleDateString('ko-KR', options);
                        const endStr = selectedEndDate.toLocaleDateString('ko-KR', options);
                        totalDays = Math.ceil((selectedEndDate - selectedStartDate) / (1000 * 60 * 60 * 24)) + 1;

                        selectedDateDisplay.textContent = startStr + '~' + endStr;
                        selectedDateDisplay2.textContent = totalDays;
                      } else if (selectedStartDate) {
                        const startStr = selectedStartDate.toLocaleDateString('ko-KR', options);
                        selectedDateDisplay.textContent = startStr;
                        selectedDateDisplay2.textContent = "1";
                      } else {
                        selectedDateDisplay.textContent = '';
                        selectedDateDisplay2.textContent = '';
                      }
                    }

                    prevMonthBtn.addEventListener('click', function () {
                      if (currentMonth === 0) {
                        currentMonth = 11;
                        currentYear--;
                      } else {
                        currentMonth--;
                      }
                      renderCalendar(currentYear, currentMonth);
                    });

                    nextMonthBtn.addEventListener('click', function () {
                      if (currentMonth === 11) {
                        currentMonth = 0;
                        currentYear++;
                      } else {
                        currentMonth++;
                      }
                      renderCalendar(currentYear, currentMonth);
                    });

                    document.querySelectorAll('.clickable').forEach(function (item) {
                      item.addEventListener('click', function () {
                        const miniHall = this.getAttribute('data-mini-hall');
                        const hDay = this.getAttribute('data-h-day');
                        const hallId = this.getAttribute('data-hall-id');
                        const hallPayId = this.getAttribute('data-hallPay-id');

                        if (document.getElementById('selected-hall').textContent === miniHall) {
                          document.getElementById('selected-hall').textContent = '';
                          document.getElementById('selected-hall-id').textContent = '';
                          document.getElementById('selected-hallPay-id').textContent = '';
                          document.getElementById('price-per-day').textContent = '';
                          return;
                        }

                        updateSelectedDateDisplay();

                        const discountedPrice = calculateDiscountedPrice(hDay, totalDays);
                        const formattedPrice = discountedPrice.toLocaleString('ko-KR');

                        document.getElementById('price-per-day').textContent = formattedPrice;
                        document.getElementById('selected-hall').textContent = miniHall;
                        document.getElementById('selected-hall-id').textContent = hallId;
                        document.getElementById('selected-hallPay-id').textContent = hallPayId;
                      });
                    });

                    function calculateDiscountedPrice(hDay, totalDays) {
                      let discountRate = 0;

                      if (totalDays >= 30 * 12) {
                        discountRate = 10;
                      } else if (totalDays >= 30 * 6) {
                        discountRate = 7;
                      } else if (totalDays >= 30 * 3) {
                        discountRate = 5;
                      } else if (totalDays >= 30) {
                        discountRate = 3;
                      } else if (totalDays >= 7) {
                        discountRate = 2;
                      }
                      return hDay * (1 - discountRate / 100) * totalDays;
                    }

                    var clickableItems = document.querySelectorAll('.clickable');
                    clickableItems.forEach(function (item) {
                      item.addEventListener('click', function () {
                        var selectedItem = document.querySelector('.clickable.selected');
                        if (selectedItem) {
                          selectedItem.classList.remove('selected');
                        }

                        if (this === selectedItem) {
                          this.classList.remove('selected');
                        } else {
                          this.classList.add('selected');
                        }
                      });
                    });

                    renderCalendar(currentYear, currentMonth);
                  });

                  function submitOrder() {
                    if (!selectedStartDate || !selectedEndDate) {
                      alert('시작날짜와 종료날짜를 모두 선택해주세요');
                      return;
                    }

                    const selectedHall = document.getElementById('selected-hall').textContent;
                    const totalPrice = document.getElementById('price-per-day').textContent;
                    const totalDate = document.getElementById('selected-date-display2').textContent;
                    const hallId = document.getElementById('selected-hall-id').textContent;
                    const hallPayId = document.getElementById('selected-hallPay-id').textContent;

                    if (!selectedHall || totalPrice === '' || !totalDate) {
                      alert('공연관을 선택해주세요');
                      return;
                    }

                    alert('승인 페이지로 넘어갑니다.');

                    var data = {
                      start_date: selectedStartDate.toISOString().split('T')[0],
                      end_date: selectedEndDate.toISOString().split('T')[0],
                      price: totalPrice.replace(/,/g, ''),
                      user_id: userId,
                      miniHall: selectedHall,
                      hall_id: hallId,
                      hallPay_id: hallPayId
                    };

                    console.log(data);

                    $.ajax({
                      url: '/hall/order',
                      type: 'POST',
                      contentType: 'application/json',
                      data: JSON.stringify(data),
                      success: function (response) {
                        console.log(response);
                        window.location.href = '/hall/hallOrder';
                      },
                      error: function (xhr, status, error) {
                        console.error('Error:', error);
                      }
                    });
                  }




                </script>





                <!-- 본문 끝 -->
                <%@ include file="../footer.jsp" %>
          </body>

          </html>