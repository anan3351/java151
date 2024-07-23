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

            .swiper-container {
              width: 100%;
              height: 670px;
              /* Adjust height as needed */
              padding-bottom: 35px;
              padding-block: 100px;
            }

            .swiper-slide {
              display: flex;
              flex-direction: column;
              justify-content: center;
              align-items: center;
              background: #fff;
              border-radius: 15px;
              box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
              padding: 20px;
            }

            .swiper-pagination-bullet-active {
              background: #be9ed8;
            }

            .swiper-button-next,
            .swiper-button-prev {
              color: #be9ed8;
            }

            .custom-button {
              background-color: #be9ed8;
              border: none;
              color: white;
              padding: 10px 20px;
              text-align: center;
              text-decoration: none;
              display: inline-block;
              font-size: 14px;
              margin: 4px 2px;
              cursor: pointer;
              border-radius: 5px;
              transition-duration: 0.4s;
              box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
              height: 35px;
            }

            .custom-button:hover {
              background-color: #a682c9;
              box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
            }
          </style>
          <script>
            document.addEventListener('DOMContentLoaded', function () {
              var mySwiper = new Swiper('.swiper-container', {
                slidesPerView: 1,
                spaceBetween: 30,
                loop: true,
                pagination: {
                  el: '.swiper-pagination',
                  clickable: true,
                },
                navigation: {
                  nextEl: '.swiper-button-next',
                  prevEl: '.swiper-button-prev',
                },
              });


            });

            function confirmApproval(hallOrderId, sellerId) {
              if (confirm("승인요청 하시겠습니까?")) {
                $.ajax({
                  url: "/hall/requestApproval",
                  type: "POST",
                  data: {
                    hallOrder_id: hallOrderId,
                    seller_id: sellerId
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

            function hallOrderDel(hallOrderId) {
              if (confirm("대관요청을 취소 하시겠습니까?")) {
                $.ajax({
                  url: "/hall/requestDel",
                  type: "POST",
                  data: {
                    hallOrder_id: hallOrderId,
                  },
                  success: function (response) {
                    alert("대관요청을 취소 완료하였습니다.");
                    window.location.href = "http://localhost:9095/hall/list";
                  },
                  error: function (xhr, status, error) {
                    alert("대관요청을 취소 중 오류가 발생했습니다.");
                  }
                });
              }
            }

            function deleteOrder(hallOrder_id) {
              console.log("Deleting order with hallOrder_id:", hallOrder_id); // 디버깅용 로그 추가
              if (confirm("내역을 완전히 삭제 하시겠습니까?")) {
                $.ajax({
                  url: "/hall/deleteOrder",
                  type: "POST",
                  data: {
                    hallOrder_id: hallOrder_id
                  },
                  success: function (response) {
                    alert("내역을 삭제 완료하였습니다.");
                    location.reload();
                  },
                  error: function (xhr, status, error) {
                    alert("내역 삭제 중 오류가 발생했습니다.");
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
              
              <div class="swiper-container">
                <button type="button" class="btn btn-info"
                style="background-color: #be9ed8; border-color: #be9ed8;"
                onclick="location.href='<c:url value=" /hall/list?filter=available" />'">목록으로</button>
                <div class="swiper-wrapper">
                  <c:forEach items="${orders}" var="order" varStatus="status">
                    <div class="swiper-slide">
                      <button class="custom-button"
                        style="background-color: #2ba1c5; border-color: #2ba1c5; height: 35px;"
                        onclick="deleteOrder('${order.hallOrder_id}')">요청 삭제</button>
                      <form id="approvalForm-${status.index}" method="post">
                        <table class="info-table">
                          <tr>
                            <th>시작 날짜</th>
                            <td>${order.start_date} 일</td>
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
                            <td style="display: none;">${order.user_id}</td>
                            <td style="display: none;">${hallIdOrders[status.index].user_id}</td>
                          </tr>
                          <tr>
                            <th>승인상황</th>
                            <td>${order.pay_status}</td>
                          </tr>
                        </table>
                        <div class="btn-container">
                          <button type="button"
                            onclick="confirmApproval(${order.hallOrder_id}, '${hallIdOrders[status.index].user_id}')"
                            class="btn btn-approve">승인요청</button>
                          <button type="button" onclick="hallOrderDel(${order.hallOrder_id})"
                            class="btn btn-danger">승인취소</button>
                        </div>
                        <div></div>
                      </form>
                    </div>
                  </c:forEach>
                </div>
                <div class="swiper-pagination"></div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <c:forEach items="${get}" var="get" varStatus="status">
                  <div style="display: none;"> ${get.user_id}</div>
                </c:forEach>
              </div>
            </div>
            <div class="footer">
              <%@ include file="../footer.jsp" %>
            </div>
        </body>

        </html>