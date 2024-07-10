<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Seats</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <link rel="stylesheet" href="<c:url value='/css/template.css' />">
  <style>
    .seat-container {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .stage {
      width: 100%;
      text-align: center;
      margin: 20px 0;
      font-weight: bold;
    }
    .floor {
      width: 80%;
      margin-bottom: 30px;
    }
    .section {
      display: flex;
      justify-content: center;
      flex-direction: column;
    }
    .seats-row {
      display: flex;
      justify-content: center;
      gap: 5px;
      margin-bottom: 10px;
    }
    .seat {
      width: 30px;
      height: 30px;
      display: flex;
      justify-content: center;
      align-items: center;
      border-radius: 5px;
      color: white;
      cursor: pointer;
    }
    .seat-info {
      display: none;
    }
    .seat-number {
      display: inline;
    }
    .vip {
      background-color: gold;
    }
    .s {
      background-color: silver;
    }
    .r {
      background-color: red;
    }
    .a {
      background-color: blue;
    }
    .wheelchair {
      background-color: purple;
    }
    .aisle {
      background-color: orange;
    }
    .section-label {
      text-align: center;
      font-weight: bold;
      margin: 10px 0;
    }
  </style>
  <script>
    function goToReviews(seat_id, seat_floor) {
      location.href = 'seatReview?seat_id=' + seat_id + '&seat_floor=' + seat_floor;
    }
  </script>
</head>
<body>
  <%@ include file="../header.jsp" %>
  <div class="seat-container">
    <h1>좌석 배치도</h1>
    <div class="stage">STAGE</div>

    <div class="floor">
      <div class="section-label">객석 1층</div>
      <div class="section">
        <c:set var="previousRow" value="" />
        <c:forEach var="seat" items="${seats}">
          <c:if test="${seat.s_floor == 1 && seat.s_row != previousRow}">
            <div class="seats-row">
              <c:forEach var="rowSeat" items="${seats}">
                <c:if test="${rowSeat.s_floor == 1 && rowSeat.s_row == seat.s_row}">
                  <div class="seat ${rowSeat.seat_level.toLowerCase()}" onclick="goToReviews(${rowSeat.seat_id}, ${rowSeat.s_floor})">
                    <span class="seat-info">${rowSeat.s_floor}층 ${rowSeat.s_section}구역 ${rowSeat.s_row}열 ${rowSeat.s_number}</span>
                    <span class="seat-number">${rowSeat.s_number}</span>
                  </div>
                </c:if>
              </c:forEach>
            </div>
            <c:set var="previousRow" value="${seat.s_row}" />
          </c:if>
        </c:forEach>
      </div>
    </div>

    <div class="floor">
      <div class="section-label">객석 2층</div>
      <div class="section">
        <c:set var="previousRow" value="" />
        <c:forEach var="seat" items="${seats}">
          <c:if test="${seat.s_floor == 2 && seat.s_row != previousRow}">
            <div class="seats-row">
              <c:forEach var="rowSeat" items="${seats}">
                <c:if test="${rowSeat.s_floor == 2 && rowSeat.s_row == seat.s_row}">
                  <div class="seat ${rowSeat.seat_level.toLowerCase()}" onclick="goToReviews(${rowSeat.seat_id}, ${rowSeat.s_floor})">
                    <span class="seat-info">${rowSeat.s_floor}층 ${rowSeat.s_section}구역 ${rowSeat.s_row}열 ${rowSeat.s_number}</span>
                    <span class="seat-number">${rowSeat.s_number}</span>
                  </div>
                </c:if>
              </c:forEach>
            </div>
            <c:set var="previousRow" value="${seat.s_row}" />
          </c:if>
        </c:forEach>
      </div>
    </div>
  </div>

  <%@ include file="../footer.jsp" %>
</body>
</html>
