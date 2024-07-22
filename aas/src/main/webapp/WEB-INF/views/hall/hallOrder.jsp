<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>공연장 승인 요청</title>
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
          <link rel="stylesheet" href="/css/hall.css">
          <style>
            body {
              font-family: 'Pretendard', sans-serif;
              background-color: #f9f9f9;
              color: #333;
              margin: 0;
              padding: 0;
              display: flex;
              flex-direction: column;
              justify-content: center;
              align-items: center;
              height: 100vh;
            }

            .main-container {
              background-color: #fff;
              border-radius: 15px;
              box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
              max-width: 800px;
              width: 100%;
              margin: 20px;
              padding: 20px;
              box-sizing: border-box;
            }

            h1 {
              color: #4A4A4A;
              margin-bottom: 30px;
              text-align: center;
              font-size: 24px;
              font-weight: 700;
            }

            .info-table {
              width: 100%;
              border-collapse: collapse;
              margin-bottom: 20px;
            }

            .info-table th,
            .info-table td {
              padding: 12px 15px;
              border: 1px solid #e0e0e0;
            }

            .info-table th {
              background-color: #f5f5f5;
              font-weight: bold;
              color: #555;
            }

            .info-table tr:nth-child(even) {
              background-color: #f9f9f9;
            }

            .btn-container {
              display: flex;
              justify-content: space-between;
              gap: 10px;
            }

            .btn {
              flex: 1;
              padding: 10px;
              font-size: 16px;
              border-radius: 5px;
              cursor: pointer;
              transition: background-color 0.3s ease;
              text-align: center;
              border: none;
            }

            .btn-back {
              background-color: #be9ed8;
              color: white;
            }

            .btn-back:hover {
              background-color: #a589bf;
            }

            .btn-approve {
              background-color: #4CAF50;
              color: white;
            }

            .btn-approve:hover {
              background-color: #45a049;
            }

            .btn-cancel {
              background-color: #f44336;
              color: white;
            }

            .btn-cancel:hover {
              background-color: #da190b;
            }

            .footer {
              width: 100%;
              margin-bottom: -10px;
              color: white;
              text-align: center;
              padding: 10px 0;
              position: fixed;
              bottom: 0;
            }
          </style>
          <script>
            function confirmApproval() {
              if (confirm("승인요청 하시겠습니까?")) {
                $.ajax({
                  url: "/user/requestApproval",
                  type: "POST",
                  data: {
                    hallOrder_id: "${order.hallOrder_id}",
                    seller_id: "${get.user_id}"
                  },
                  success: function (response) {
                    alert("판매자에게 승인요청을 완료하였습니다.");
                    location.reload();
                  },
                  error: function (xhr, status, error) {
                    alert("판매자 승인요청 중 오류가 발생했습니다.");
                  }
                });
              } 
            }


            function hallOrderDel() {
              if (confirm("대관요청을 취소 하시겠습니까?")) {
                $.ajax({
                  url: "/user/requestDel",
                  type: "POST",
                  data: {
                    hallOrder_id: "${order.hallOrder_id}",
                  },
                  success: function (response) {
                    alert("대관요청을 취소 완료하였습니다.");
                    window.location.href = "http://localhost:9095/hall/list"; // 페이지 이동
                  },
                  error: function (xhr, status, error) {
                    alert("대관요청을 취소 중 오류가 발생했습니다.");
                  }
                });
              } 
            }
          </script>
        </head>

        <body>
          <%@ include file="../header.jsp" %>
            <div class="main-container">
              <h1>공연장 승인 요청</h1>
              <form id="approvalForm" method="post">
                <table class="info-table">
                  <tr>
                    <th>시작 날짜</th>
                    <td>${order.start_date}</td>
                  </tr>
                  <tr>
                    <th>종료 날짜</th>
                    <td>${order.end_date} 일</td>
                  </tr>
                  <tr>
                    <th>총 금액</th>
                    <td>${order.price} 원</td>
                  </tr>
                  <tr>
                    <th>승인요청시간</th>
                    <td>${order.pay_date}</td>
                  </tr>
                  <tr>
                    <th>공연관</th>
                    <td>${order.miniHall}</td>
                    <td style="display: none;">${order.hall_id}</td>
                    <td style="display: none;">${order.hallOrder_id}</td>
                    <td style="display: none;">${order.user_id}</td> <!-- 구매자 user_id-->
                    <td style="display: none;">${get.user_id}</td> <!-- 판매자 user_id-->
                  </tr>
                  <tr>
                    <th>승인상황</th>
                    <td>${order.pay_status}</td>
                  </tr>
                </table>
                <div class="btn-container">
                  <button type="submit" onclick="confirmApproval()" class="btn btn-approve">승인요청</button>
                  <button type="submit" onclick="hallOrderDel()" class="btn btn-danger">승인취소</button>
                </div>
              </form>
            </div>
            <div class="footer">
              <%@ include file="../footer.jsp" %>
            </div>
        </body>

        </html>