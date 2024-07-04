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
      flex-wrap: wrap;
      justify-content: center;
    }
    .seat {
      width: 30px;
      height: 30px;
      margin: 5px;
      text-align: center;
      line-height: 30px;
      border-radius: 5px;
      color: white;
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
    .stage {
      width: 100%;
      text-align: center;
      margin: 20px 0;
      font-weight: bold;
    }
    .seat-row {
      display: contents;
    }
    .seat-row-label {
      grid-column: 1 / span 20;
      text-align: left;
      padding-left: 5px;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <%@ include file="../header.jsp" %>
  <div class="main-container">
    <h1>좌석 배치도</h1>
    <div class="stage">STAGE</div>
    <div class="seat-container">
      <c:forEach var="seat" items="${seats}">
        <div class="seat ${seat.seatLevel.toLowerCase()}">
          ${seat.s_section} ${seat.s_row} ${seat.s_number}
        </div>
      </c:forEach>
    </div>
  </div>
  <%@ include file="../footer.jsp" %>
</body>
</html>
