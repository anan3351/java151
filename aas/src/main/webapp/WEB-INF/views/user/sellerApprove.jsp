<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

          <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/css/select2.min.css" rel="stylesheet" />
          <link rel="stylesheet" href="/css/template.css">

          <title>seller Page</title>
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
            }

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

            header .logo img {
              display: inline-block;
              background-color: #413f3f;
              width: 250px;
              max-width: 100%;
              height: auto;
              object-fit: contain;
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

            .row.content {
              height: 450px;
            }

            .sidenav {
              padding-top: 20px;
              background-color: #f1f1f1;
              height: 100%;
            }

            footer {
              background-color: #413f3f;
              color: white;
              padding: 15px;
              width: 100%;
            }

            .centerBox {
              width: 450px;
              margin-left: auto;
              margin-right: auto;
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
              text-decoration: none;
              display: block;
              padding: 5px 0;
              transition: color 0.3s ease;
            }

            .menu-title a:hover {
              color: #333;
            }

            .menu-title a::before {
              margin-right: 5px;
              color: #000;
            }

            main {
              flex-grow: 1;
              padding: 20px;
              background-color: white;
              border-radius: 10px;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

            @media (max-width: 1600px) {
              header {
                width: 100%;
              }
            }

            @media (max-width: 1200px) {
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

            @media (max-width: 768px) {
              body {
                flex-direction: column;
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

            @media (max-width: 480px) {
              header .search-bar input {
                width: 95%;
                padding: 5px 25px 5px 5px;
              }

              header .user-options {
                justify-content: center;
              }

              header .user-options a {
                margin: 5px;
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
              width: 10%;
              /* 시작 날짜 */
            }

            .info-table th:nth-child(2),
            .info-table td:nth-child(2) {
              width: 10%;
              /* 종료 날짜 */
            }

            .info-table th:nth-child(3),
            .info-table td:nth-child(3) {
              width: 10%;
              /* 총 금액 */
            }

            .info-table th:nth-child(4),
            .info-table td:nth-child(4) {
              width: 15%;
              /* 승인요청시간 */
            }

            .info-table th:nth-child(5),
            .info-table td:nth-child(5) {
              width: 15%;
              /* 공연관 */
            }

            .info-table th:nth-child(6),
            .info-table td:nth-child(6) {
              width: 15%;
              /* 승인상황 */
            }

            .info-table th:nth-child(7),
            .info-table td:nth-child(7) {
              width: 10%;
              /* 버튼 컨테이너 */
            }
          </style>

          <script>
            function confirmSeller(hallOrder_id) {
              if (confirm("승인하시겠습니까?")) {
                $.ajax({
                  url: "/hall/approveRequest",
                  type: "POST",
                  data: {
                    hallOrderId: hallOrder_id
                  },
                  success: function (response) {
                    alert("승인이 완료되었습니다.");
                    location.reload();
                  },
                  error: function (xhr, status, error) {
                    alert("승인 중 오류가 발생했습니다.");
                  }
                });
              }
            }

            function approveCancel(hallOrder_id){
              if (confirm("내역 삭제 하시겠습니까?")) {
                console.log("홀오더 " + hallOrder_id );
                $.ajax({
                  url: "/hall/deleteOrder",
                  type: "POST",
                  data: {
                    hallOrder_id: hallOrder_id
                  },
                  success: function (response) {
                    alert("내역 삭제 완료되었습니다.");
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
              <div class="sidebar">
                <div class="profile">
                  <div class="profile-image"></div>
                  <p>${userInfo.user_id} 님</p>
                  <p>회원등급 - ${userInfo.auth}</p>
                  <p>${userInfo.level_name} Level</p>
                  <p class="points">내 포인트 -
                    <fmt:formatNumber value="${userInfo.u_point}" pattern="#,###" />p
                  </p>
                </div>
                <div class="menu-section">
                  <div class="menu-title">공연</div>
                  <ul class="menu-items">
                    <li><a href="/seller/list">공연 목록</a></li>
                    <li><a href="/seller/create">공연 등록</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">공연장</div>
                  <ul class="menu-items">
                    <li><a href="/user/sellerHallInsert">공연장 등록</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">공연장대관</div>
                  <ul class="menu-items">
                    <li><a href="/user/sellerApprove">대관 관리</a></li>
                  </ul>
                </div>
              </div>

              <main>
                <div class="hall-wrap">
                  <c:forEach items="${approve}" var="approve" varStatus="status">
                  <h1>공연장 대관 승인</h1>
                  <form id="approvalForm-${status.index}" method="post">
                    <table class="info-table">
                      <tr>
                        <th>시작 날짜</th>
                        <th>총 대관일</th>
                        <th>총 금액</th>
                        <th>승인요청시간</th>
                        <th>공연관</th>
                        <th>구매자 요청 ID</th>
                        <th>승인상황</th>
                      </tr>
                      <tr>
                        <td>${approve.start_date}일</td>
                        <td>${approve.end_date}일</td>
                        <td>${approve.price}원</td>
                        <td><fmt:formatDate value="${approve.pay_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td>${approve.miniHall}</td>
                        <td>${approve.user_id}</td>
                        <td>${approve.pay_status}<div class="btn-container">
                          <button type="button" class="btn btn-back" onclick="approveCancel('${approve.hallOrder_id}')">내역삭제</button>
                          <c:choose>
                            <c:when test="${approve.pay_status eq '승인대기진행중'}">
                              <button type="button" id="approveButton" onclick="confirmSeller(${approve.hallOrder_id})"
                                class="btn btn-approve">승인하기</button>
                            </c:when>
                          </c:choose>
                        </div></td>
                        <td style="display: none;">${approve.hall_id}</td>
                        <td style="display: none;">${approve.hallOrder_id}</td>
                      </tr>
                    </table>
                  </c:forEach>
                  </form>
                </div>
              </main>
            </div>

            <%@ include file="../footer.jsp" %>
        </body>

        </html>