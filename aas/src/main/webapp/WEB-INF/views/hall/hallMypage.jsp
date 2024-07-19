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

          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
              <title>My Page</title>
              <style>
                body {
                  font-family: Arial, sans-serif;
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
                body {
                  font-family: 'Pretendard';
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
                  background-color: #ffffff;
                  border-radius: 8px;
                  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                  padding: 30px;
                  width: 100%;
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
                  border-spacing: 0 10px;
                }

                .info-table th,
                .info-table td {
                  padding: 12px 15px;
                  text-align: left;
                }

                .info-table th {
                  background-color: #f5f5f5;
                  color: #333;
                  font-weight: bold;
                  border-radius: 4px 0 0 4px;
                }

                .info-table td {
                  background-color: #fafafa;
                  border-radius: 0 4px 4px 0;
                }

                .btn-container {
                  display: flex;
                  justify-content: center;
                  margin-top: 20px;
                }

                .btn {
                  padding: 10px 20px;
                  border: none;
                  border-radius: 4px;
                  cursor: pointer;
                  font-weight: bold;
                  transition: background-color 0.3s ease;
                }

                .btn-back {
                  background-color: #6c757d;
                  color: white;
                  margin-right: 10px;
                }

                .btn-approve {
                  background-color: #0066cc;
                  color: white;
                }

                .btn:hover {
                  opacity: 0.9;
                }
              </style>

              <script>
                document.addEventListener('DOMContentLoaded', function () {
                  var modal = document.getElementById("rankModal");
                  var btn = document.querySelector(".rank-btn");
                  var span = document.getElementsByClassName("close")[0];

                  btn.onclick = function () {
                    modal.style.display = "block";
                  }

                  span.onclick = function () {
                    modal.style.display = "none";
                  }

                  window.onclick = function (event) {
                    if (event.target == modal) {
                      modal.style.display = "none";
                    }
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
              <div class="hall-wrap">
                <h1>공연장 승인 요청</h1>
                <form id="approvalForm" method="post">
                  <table class="info-table">
                    <tr>
                      <th>시작 날짜</th>
                      <td>${order.start_date}</td>
                    </tr>
                    <tr>
                      <th>총 대관일</th>
                      <td>${order.end_date}일</td>
                    </tr>
                    <tr>
                      <th>총 금액</th>
                      <td>${order.price}원</td>
                    </tr>
                    <tr>
                      <th>승인요청시간</th>
                      <td>${order.pay_date}</td>
                    </tr>
                    <tr>
                      <th>공연관</th>
                      <td>${order.miniHall}</td>
                      <td style="display: none;">${order.hall_id}</td>
                      <td style="display: none;">${order.user_id}</td>
                    </tr>
                    <tr>
                      <th>승인상황</th>
                      <td>${order.pay_status}</td>
                    </tr>
                  </table>
                  <div class="btn-container">
                    <button type="button" class="btn btn-back" onclick=""/>요청삭제</button>
                    <button type="submit" onclick="confirmApproval()" class="btn btn-approve">승인요청</button>
                  </div>
                </form>
              </div>
              </div>
              <%@ include file="../footer.jsp" %>
        </body>

        </html>