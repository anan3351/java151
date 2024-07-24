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
          <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

          <title>My Page</title>
          <style>
            body {
              font-family: 'Pretendard';
              margin: 0;
              padding: 0;
              background-color: #f0f0f0;
              display: flex;
              flex-direction: column;
              min-height: 100vh;
              padding-top: 130px;
              /* 헤더의 높이만큼 상단 패딩 추가 */
            }

            .sidebar {
              width: 250px;
              background-color: white;
              padding: 20px;
              box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
              margin-right: 20px;
              border-radius: 10px;
              flex-shrink: 0;
              align-self: flex-start;
              /* 사이드바를 상단에 맞춤 */
            }

            .profile {
              text-align: center;
              margin-bottom: 20px;
            }

            .profile-image {
              width: 80px;
              height: 80px;
              border-radius: 50%;
              background-color: #ddd;
              margin: 0 auto 10px;
            }

            .points {
              font-weight: bold;
              color: #0066cc;
            }

            .menu-section {
              margin-bottom: 20px;
            }

            .menu-title {
              font-weight: bold;
              margin-bottom: 10px;
            }

            .menu-items {
              list-style-type: none;
              padding: 0;
            }

            .menu-items li {
              margin-bottom: 5px;
            }

            .menu-items a {
              color: #666;
              text-decoration: none;
            }

            .menu-items a:hover {
              color: #0066cc;
            }

            .menu-title a {
              color: #000;
              /* 검정색으로 변경 */
              text-decoration: none;
              display: block;
              padding: 5px 0;
              transition: color 0.3s ease;
            }

            .menu-title a:hover {
              color: #333;
              /* 호버 시 약간 밝은 검정색으로 변경 */
            }

            .menu-title a::before {
              margin-right: 5px;
              color: #000;
              /* 불릿 포인트 색상도 검정색으로 변경 */
            }

            main {
              flex-grow: 1;
              padding: 20px;
              background-color: white;
              border-radius: 10px;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            header {
              display: flex;
              justify-content: space-between;
              align-items: center;
              padding: 10px 20px;
              background-color: white;
            }

            .logo {
              color: #0066cc;
              font-weight: bold;
              font-size: 24px;
            }

            .login {
              color: #666;
            }

            .welcome-box {
              background-color: white;
              padding: 20px;
              text-align: center;
              border-radius: 10px;
              margin-bottom: 20px;
            }

            .heart-icon {
              font-size: 24px;
              color: #ff6b6b;
            }

            .rank-btn {
              background-color: #0066cc;
              color: white;
              border: none;
              padding: 10px 20px;
              border-radius: 5px;
              cursor: pointer;
              margin-top: 10px;
            }

            .menu-grid {
              display: grid;
              grid-template-columns: repeat(3, 1fr);
              gap: 20px;
            }

            .menu-item {
              background-color: white;
              padding: 20px;
              border-radius: 10px;
              text-align: center;
              cursor: pointer;
              border: none;
              font-size: 16px;
            }

            .icon {
              font-size: 24px;
              margin-bottom: 10px;
            }

            .menu-item p {
              margin: 5px 0;
              font-weight: bold;
            }

            .menu-item small {
              color: #666;
              font-size: 12px;
            }

            .btn-search {
              background-color: #0066cc;
              color: white;
              border: none;
              padding: 10px 20px;
              border-radius: 5px;
              cursor: pointer;
            }

            .user-options a {
              color: #666;
              margin-left: 10px;
            }

            .user-options a:hover {
              color: #000;
            }

            .search-bar input {
              padding: 5px;
              border: 1px solid #ddd;
              border-radius: 5px;
            }

            @media (max-width : 768px) {
              body {
                flex-direction: column;
                /* 화면이 좁아지면 세로로 배치 */
              }

              .sidebar {
                width: auto;
                margin-right: 0;
                margin-bottom: 20px;
              }

              main {
                max-width: 100%;
              }

              .main-container {
                flex-direction: column;
              }
            }
          </style>
          <style>
            .inner-content {
              margin: 0 auto;
              width: 1170px;
              padding-block: 40px;
            }

            .header-wrap {
              width: 100%;
              position: fixed;
              z-index: 999;
              background-color: #fff;
              top: 0;
            }

            .main-container {
              display: flex;
              flex-grow: 1;
              padding: 20px;
              margin-top: 20px;
              /* 상단 여백 추가 */
            }

            header {
              margin: 0 auto;
              width: 1600px;
              display: flex;
              justify-content: space-between;
              align-items: center;
              padding: 10px 20px;
              background-color: #fff;
              transition: all 0.3s;
            }

            eader .logo img {
              display: inline-block;
              background-color: #413f3f;
              width: 250px;
              max-width: 100%;
              /* 반응형을 위해 추가 */
              height: auto;
              /* 이미지 비율 유지 */
              object-fit: contain;
              /* 이미지가 영역 내에 맞게 조정 */
            }

            header .search-bar {
              position: relative;
            }

            header .search-bar input {
              border-radius: 25px;
              width: 600px;
              padding: 5px 20px;
              height: 50px;
              border: 1px solid #c5c5c5;
            }

            header .search-bar .btn-search {
              position: absolute;
              width: 20px;
              height: 20px;
              border: none;
              right: 20px;
              top: 50%;
              transform: translateY(-50%);
              background: url(/images/search.svg);
              background-repeat: no-repeat;
            }

            header .user-options a {
              margin: 0 10px;
              text-decoration: none;
              color: #000;
            }

            header .language img {
              height: 20px;
            }

            nav {
              width: 100%;
              border-top: 1px solid #ccc;
              border-bottom: 1px solid #ccc;
              padding: 10px 20px;
              display: flex;
              justify-content: center;
            }

            nav ul {
              list-style: none;
              display: flex;
              flex-direction: row;
              align-items: center;
              height: 39px;
              padding: 0;
              gap: 40px;
              border-radius: 6px;
              white-space: nowrap;
              list-style-type: none;
              margin: 0;
            }

            nav ul li {
              display: flex;
              align-items: center;
              height: 39px;
              font-style: normal;
              font-weight: 700;
              font-size: 16px;
              line-height: 19px;
              border-bottom: 2px solid transparent;
            }

            nav ul li a {
              text-decoration: none;
              color: #111;
              display: flex;
              align-items: center;
              justify-content: center;
              font-size: 16px;
            }

            nav ul li a:hover {
              text-decoration: none;
            }

            /*content*/
            .swiper-container {
              max-width: 1600px;
              height: 300px;
              margin-bottom: 50px;
              padding-block: 300px;
            }

            .slider1 {
              position: relative;
              max-width: 1507px;
            }

            .slider2 {
              position: relative;
            }

            .swiper-slide {
              background: #fff;
              display: flex;
              align-items: center;
              justify-content: center;
              text-align: center;
              border: 1px solid #ccc;
              cursor: pointer;
            }

            .slider1 .swiper-slide {
              align-items: start;
            }

            .slider1 .swiper-slide img {
              max-width: 100%;
              height: 450px;
              box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
              border-radius: 10px;
            }

            .navbar-nav {
              display: flex;
              justify-content: center;
              width: 100%;
            }

            .navbar-nav>li {
              display: flex;
              align-items: center;
            }

            th {
              text-align: center;
            }

            /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
            .row.content {
              height: 450px
            }

            /* Set gray background color and 100% height */
            .sidenav {
              padding-top: 20px;
              background-color: #f1f1f1;
              height: 100%;
            }

            /* Set black background color, white text and some padding */
            /* 푸터 스타일 추가 */
            footer {
              background-color: #413f3f;
              color: white;
              padding: 15px;
              width: 100%;
            }

            .centerBox {
              width: 450;
              margin-left: auto;
              margin-right: auto;
            }

            /* 반응형 스타일 */
            @media (max-width : 1600px) {
              header {
                width: 100%;
              }
            }

            @media (max-width : 1200px) {
              header {
                width: 100%;
                align-items: center;
                flex-direction: column;
              }

              header .search-bar {
                max-width: none;
                margin: 10px 0;
              }

              header .user-options {
                justify-content: flex-end;
              }
            }

            @media (max-width : 768px) {
              header {
                padding: 10px;
              }

              header .search-bar input {
                width: 100%;
                padding: 5px 30px 5px 10px;
              }

              header .user-options {
                justify-content: center;
              }

              header .user-options a {
                margin: 5px 10px;
              }
            }

            @media (max-width : 480px) {
              header .search-bar input {
                width: 95%;
                padding: 5px 25px 5px 5px;
              }

              header .user-options {
                justify-content: center;
              }

              header .user-options a {
                margin: 5px;
                /* 여백 조정 */
              }
            }

            .modal {
              display: none;
              position: fixed;
              z-index: 1000;
              left: 0;
              top: 0;
              width: 100%;
              height: 100%;
              overflow: auto;
              background-color: rgba(0, 0, 0, 0.6);
            }

            .modal-content {
              background-color: #fefefe;
              margin: 5% auto;
              padding: 30px;
              border: none;
              width: 90%;
              max-width: 800px;
              border-radius: 8px;
              box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .close {
              color: #aaa;
              float: right;
              font-size: 28px;
              font-weight: bold;
              transition: color 0.3s ease;
            }

            .close:hover,
            .close:focus {
              color: #333;
              text-decoration: none;
              cursor: pointer;
            }

            .modal h2 {
              margin-top: 0;
              color: #333;
              font-size: 24px;
              margin-bottom: 20px;
            }

            .modal table {
              width: 100%;
              border-collapse: separate;
              border-spacing: 0;
              background-color: #fff;
              border-radius: 6px;
              overflow: hidden;
              box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .modal th,
            .modal td {
              padding: 15px;
              text-align: left;
              border-bottom: 1px solid #e0e0e0;
            }

            .modal th {
              background-color: #f5f5f5;
              font-weight: bold;
              color: #333;
              text-transform: uppercase;
              font-size: 14px;
            }

            .modal tr:last-child td {
              border-bottom: none;
            }

            .modal tr:nth-child(even) {
              background-color: #f9f9f9;
            }

            .modal tr:hover {
              background-color: #f0f0f0;
            }

            .modal td:first-child {
              font-weight: bold;
              color: #0066cc;
            }

            @media (max-width : 768px) {
              .modal-content {
                width: 95%;
                margin: 10% auto;
                padding: 20px;
              }

              .modal table {
                font-size: 14px;
              }

              .modal th,
              .modal td {
                padding: 10px;
              }
            }

            .hall-wrap {
              background-color: #f9f9f9;
              border-radius: 10px;
              padding: 30px;
              box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }

            .hall-wrap h1 {
              color: #333;
              font-size: 24px;
              margin-bottom: 20px;
              border-bottom: 2px solid #0066cc;
              padding-bottom: 10px;
            }

            .info-table {
              width: 100%;
              border-collapse: separate;
              border-spacing: 0;
              margin-bottom: 20px;
              background-color: #ffffff;
              box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
              border-radius: 10px;
              overflow: hidden;
              table-layout: fixed;
              /* 고정 레이아웃 사용 */
            }

            .info-table th,
            .info-table td {
              padding: 15px;
              text-align: left;
              border-bottom: 1px solid #f0f0f0;
              word-wrap: break-word;
              /* 텍스트가 길 경우 줄바꿈 처리 */
            }

            .info-table th {
              background-color: #f8f9fa;
              font-weight: 600;
              text-transform: uppercase;
              font-size: 0.85em;
              color: #495057;
              letter-spacing: 0.5px;
            }

            .info-table tr:last-child td {
              border-bottom: none;
            }

            .info-table tr:nth-child(even) {
              background-color: #f8f9fa;
            }

            .info-table tr:hover {
              background-color: #f1f3f5;
              transition: background-color 0.3s ease;
            }

            .info-table td:first-child,
            .info-table th:first-child {
              padding-left: 20px;
            }

            .info-table td:last-child,
            .info-table th:last-child {
              padding-right: 20px;
            }

            .info-table .btn-container {
              display: flex;
              justify-content: flex-end;
              gap: 10px;
            }

            .info-table .btn {
              padding: 8px 15px;
              border-radius: 5px;
              font-size: 0.9em;
              transition: all 0.3s ease;
            }

            .info-table .btn-approve {
              background-color: #007bff;
              color: white;
            }

            .info-table .btn-danger {
              background-color: #dc3545;
              color: white;
            }

            .info-table .btn:hover {
              opacity: 0.8;
              transform: translateY(-2px);
            }

            /* 각 열의 고정 너비 설정 */
            .info-table th:nth-child(1),
            .info-table td:nth-child(1) {
              width: 15%;
              /* 시작 날짜 */
            }

            .info-table th:nth-child(2),
            .info-table td:nth-child(2) {
              width: 15%;
              /* 종료 날짜 */
            }

            .info-table th:nth-child(3),
            .info-table td:nth-child(3) {
              width: 15%;
              /* 총 금액 */
            }

            .info-table th:nth-child(4),
            .info-table td:nth-child(4) {
              width: 20%;
              /* 승인요청시간 */
            }

            .info-table th:nth-child(5),
            .info-table td:nth-child(5) {
              width: 15%;
              /* 공연관 */
            }

            .info-table th:nth-child(6),
            .info-table td:nth-child(6) {
              width: 20%;
              /* 승인상황 */
            }

            .info-table th:nth-child(7),
            .info-table td:nth-child(7) {
              width: 10%;
              /* 버튼 컨테이너 */
            }
          </style>
          <script>
            var orderPrice = "<c:out value='${order.price}' />";
          </script>
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
          <script>
            function confirmApproval(hallOrderId, user_id) {
              console.log("Confirming approval for user_id:", user_id); // 디버깅용 로그 추가
              if (confirm("승인요청 하시겠습니까?")) {
                $.ajax({
                  url: "/hall/requestApproval",
                  type: "POST",
                  data: {
                    hallOrder_id: hallOrderId,
                    seller_id: user_id // user_id가 문자열로 처리되는지 확인
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

            function hallOrderDel(hallOrder_id) {
              console.log("Confirming approval for user_id:", hallOrder_id); // 디버깅용 로그 추가
              if (confirm("대관요청을 취소 하시겠습니까?")) {
                $.ajax({
                  url: "/hall/requestDel",
                  type: "POST",
                  data: {
                    hallOrder_id: hallOrder_id,
                  },
                  success: function (response) {
                    alert("대관요청을 취소 완료하였습니다.");
                    location.reload();
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

            document.addEventListener('DOMContentLoaded', function () {
              $("#check_order").click(function (event) {
                var button = event.target;
                var hallOrderId = button.getAttribute('data-hallOrder-id');
                var priceString = button.getAttribute('data-price');
                var selectedAmount = parseInt(priceString.replace(/[^0-9]/g, ""), 10);

                if (isNaN(selectedAmount)) {
                  alert("유효하지 않은 가격입니다.");
                  return;
                }

                // 결제창 호출
                IMP.init('imp81610215');
                IMP.request_pay({
                  pg: 'html5_inicis',
                  pay_method: 'card',
                  merchant_uid: hallOrderId, // 상점에서 관리하는 주문 번호를 전달
                  name: '주문명:결제테스트',
                  amount: selectedAmount, // 결제금액
                  m_redirect_url: '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile
                }, function (rsp) { // callback 로직
                  if (rsp.success) {
                    // 서버단에서 결제정보 조회를 위해 Fetch API로 imp_uid 전달하기
                    $.ajax({
                      url: "/hall/updateOrderStatus",
                      type: 'POST',
                      contentType: 'application/json',
                      data: JSON.stringify({
                        hallOrderId: hallOrderId,
                        pay_status: '결제완료',
                        imp_uid: rsp.imp_uid
                      }),
                      success: function (updateData) {
                        console.log("AJAX 요청 성공");
                        console.log("주문 상태 업데이트 응답:", updateData);
                        if (updateData.update_success) {
                          // 업데이트가 성공하면 페이지 리로드
                          alert('결제가 완료되었습니다.');
                          window.location.reload();
                        } else {
                          alert('결제는 완료되었으나 주문 상태 업데이트에 실패했습니다.');
                        }
                      },
                      error: function (xhr, status, error) {
                        console.error('AJAX 요청 실패:', status, error);
                        console.error('응답 텍스트:', xhr.responseText);
                        alert('서버와의 통신에 실패하였습니다. 다시 시도해 주세요.');
                      }
                    });
                  } else {
                    var msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                    alert(msg);
                  }
                });
              });

              function cancelPay() {
                jQuery.ajax({
                  // 예: http://www.myservice.com/payments/cancel
                  url: "{환불정보를 수신할 가맹점 서비스 URL}",
                  type: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({
                    merchant_uid: hallOrderId, // 예: ORD20180131-0000011
                    cancel_request_amount: selectedAmount, // 환불금액
                    reason: "테스트 결제 환불" // 환불사유

                  }),
                  dataType: "json"
                });
              }
            });



          </script>
        </head>

        <body>
          <%@ include file="../header.jsp" %>
            <div class="main-container">
              <div class="sidebar">
                <div class="profile">
                  <div class="profile-image"></div>
                  <p>${userInfo.user_id}님</p>
                  <p>회원등급 - ${userInfo.auth}</p>
                  <p>${userInfo.level_name}Level</p>
                  <p class="points">
                    내 포인트 -
                    <fmt:formatNumber value="${userInfo.u_point}" pattern="#,###" />
                    p
                  </p>
                </div>
                <div class="menu-section">
                  <div class="menu-title">예매 티켓</div>
                  <ul class="menu-items">
                    <li><a href="#">예매 티켓 조회</a></li>
                    <li><a href="#">예매 취소/체매매</a></li>
                    <li><a href="#">예매대기</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">내 스케줄</div>
                  <ul class="menu-items">
                    <li><a href="#">스케줄 작성</a></li>
                    <li><a href="#">스케줄 수정/삭제</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">즐겨찾기</div>
                  <ul class="menu-items">
                    <li><a href="#">관심배우</a></li>
                    <li><a href="#">관심공연</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">나의 후기</div>
                  <ul class="menu-items">
                    <li><a href="#">좌석 후기</a></li>
                    <c:choose>
                      <c:when test="${not empty sessionScope.loggedInUser}">
                        <li><a
                            href="${pageContext.request.contextPath}/showreview/showreviewForm?user_id=${sessionScope.loggedInUser.user_id}">공연
                            후기</a></li>
                      </c:when>
                    </c:choose>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">
                    <a
                      href="${pageContext.request.contextPath}/user/mypage/hallMypage?user_id=${sessionScope.loggedInUser.user_id}">공연장
                      대관</a>
                  </div>
                </div>
                <div class="menu-section">
                  <div class="menu-title">
                    <a
                      href="${pageContext.request.contextPath}/user/mypage/membership?user_id=${sessionScope.loggedInUser.user_id}">멤버십</a>
                  </div>
                </div>
                <div class="menu-section">
                  <div class="menu-title">
                    <a
                      href="${pageContext.request.contextPath}/user/mypage/coupon?user_id=${sessionScope.loggedInUser.user_id}">보유쿠폰</a>
                  </div>
                </div>
              </div>
              <main>
                <h1>공연장 승인 요청</h1>
                <div>
                  <div>
                    <c:forEach items="${orders}" var="order" varStatus="status">
                      <div>
                        <form id="approvalForm-${status.index}" method="post">
                          <table class="info-table">
                            <tr>
                              <th>시작 날짜</th>
                              <th>종료 날짜</th>
                              <th>총 금액</th>
                              <c:choose>
                                <c:when test="${order.pay_status == '결제완료'}">
                                  <th>결제완료시간</th>
                                </c:when>
                                <c:otherwise>
                                  <th>승인요청시간</th>
                                </c:otherwise>
                              </c:choose>
                              <th>공연관</th>
                              <th colspan="2">승인상황</th>
                            </tr>
                            <tr>
                              <td>${order.start_date} 일</td>
                              <td>${order.end_date} 일</td>
                              <td>${order.price} 원</td>
                              <td>${order.pay_date}</td>
                              <td>${order.miniHall}</td>
                              <td>${order.pay_status}</td>
                              <td style="display: none;">${order.hall_id}</td>
                              <td style="display: none;">${order.hallOrder_id}</td>
                              <td style="display: none;">${order.user_id}</td>
                              <td style="display: none;">${hallIdOrders[status.index].user_id}</td>
                              <td>
                                <div class="btn-container">
                                  <c:choose>
                                    <c:when test="${order.pay_status == '승인취소'}">
                                      <button type="button" onclick="deleteOrder('${order.hallOrder_id}')"
                                        class="btn btn-success">내역삭제</button>
                                    </c:when>
                                    <c:when test="${order.pay_status == '승인대기진행중'}">
                                      <button type="button" onclick="hallOrderDel('${order.hallOrder_id}')"
                                        class="btn btn-danger">승인취소</button>
                                    </c:when>
                                    <c:when test="${order.pay_status == '승인완료'}">
                                      <button type="button" class="btn btn-warning" id="check_order"
                                        data-hallOrder-id="${order.hallOrder_id}"
                                        data-price="${order.price}">결제하기</button>
                                      <button type="button" onclick="hallOrderDel('${order.hallOrder_id}')"
                                        class="btn btn-danger">승인취소</button>
                                    </c:when>
                                    <c:when test="${order.pay_status == '결제완료'}">
                                      <button class="btn btn-info" onclick="cancelPay()">환불요청</button>
                                      <button class="btn btn-success"
                                        onclick="deleteOrder('${order.hallOrder_id}')">내역삭제</button>
                                    </c:when>
                                    <c:otherwise>
                                      <button type="button"
                                        onclick="confirmApproval('${order.hallOrder_id}', '${order.user_id}')"
                                        class="btn btn-approve">승인요청</button>
                                        <button type="button" onclick="hallOrderDel('${order.hallOrder_id}')"
                                        class="btn btn-danger">승인취소</button>
                                    </c:otherwise>
                                  </c:choose>
                                </div>
                              </td>
                            </tr>
                          </table>
                        </form>
                      </div>
                    </c:forEach>
                  </div>
                  <c:forEach items="${get}" var="get" varStatus="status">
                    <div style="display: none;"> ${get.user_id}</div>
                  </c:forEach>
                </div>
              </main>
            </div>
            <%@ include file="../footer.jsp" %>
        </body>

        </html>