<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>후기 결과</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <style>
    .container {
      width: 80%;
      margin: auto;
      padding-top: 20px;
    }
    .review-result {
      font-size: 18px;
      margin-bottom: 20px;
    }
    .stars {
      color: gold;
      font-size: 30px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>후기 결과</h1>
    <div class="review-result">
      <strong>공연의 이름:</strong> <%= request.getParameter("performanceName") %>
    </div>
    <div class="review-result">
      <strong>좌석 위치:</strong> <%= request.getParameter("seatLocation") %>
    </div>
    <div class="review-result">
      <strong>시야 평점:</strong> <span class="stars">
      <%
        String viewRating = request.getParameter("view");
        for (int i = 0; i < Integer.parseInt(viewRating); i++) {
          out.print("★");
        }
      %>
      </span>
    </div>
    <div class="review-result">
      <strong>좌석 평점:</strong> <span class="stars">
      <%
        String seatRating = request.getParameter("seat");
        for (int i = 0; i < Integer.parseInt(seatRating); i++) {
          out.print("★");
        }
      %>
      </span>
    </div>
    <div class="review-result">
      <strong>조명 평점:</strong> <span class="stars">
      <%
        String lightRating = request.getParameter("light");
        for (int i = 0; i < Integer.parseInt(lightRating); i++) {
          out.print("★");
        }
      %>
      </span>
    </div>
    <div class="review-result">
      <strong>음향 평점:</strong> <span class="stars">
      <%
        String soundRating = request.getParameter("sound");
        for (int i = 0; i < Integer.parseInt(soundRating); i++) {
          out.print("★");
        }
      %>
      </span>
    </div>
    <div class="review-result">
      <strong>후기 내용:</strong> <%= request.getParameter("review") %>
    </div>
  </div>
</body>
</html>
