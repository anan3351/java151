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
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
          <link rel="stylesheet" href="/css/template.css">
          <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
          <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
          <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
              <title>My Page</title>
              <style>
                body {

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

                @media (max-width: 768px) {
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

                .container{
                  position: relative;

                }
                .card {
                  width: 400px;
                  height: 180px;
                  border-radius: 5px;
                  box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.2);
                  background-color: #fff;
                  padding: 10px 10px;
                  position: relative;
                }

                .main,
                .copy-button {
                  display: flex;
                  justify-content: space-between;
                  padding: 0 10px;
                  align-items: center;
                }

                .card::after {
                  position: absolute;
                  content: "";
                  height: 40px;
                  right: -20px;
                  border-radius: 40px;
                  z-index: 1;
                  top: 70px;
                  background-color: #ff6b6b;
                  width: 40px;
                }

                .card::before {
                  position: absolute;
                  content: "";
                  height: 40px;
                  left: -20px;
                  border-radius: 40px;
                  z-index: 1;
                  top: 70px;
                  background-color: #ff6b6b;
                  width: 40px;
                }

                .co-img img {
                  width: 100px;
                  height: 100px;
                }

                .vertical {
                  border-left: 5px dotted black;
                  height: 100px;
                  position: absolute;
                  left: 40%;
                }

                .content h1 {
                  font-size: 35px;
                  margin-left: -20px;
                  color: #565656;
                }

                .content h1 span {
                  font-size: 18px;
                }

                .content h2 {
                  font-size: 18px;
                  margin-left: -20px;
                  color: #565656;
                  text-transform: uppercase;
                }

                .content p {
                  font-size: 16px;
                  color: #696969;
                  margin-left: -20px;
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

                .membership-table th,
                .membership-table td {
                  text-align: center;
                }

                .membership-table th {
                  background-color: #f9f9f9;
                }

                .membership-table td {
                  vertical-align: middle;
                }

                .selected-row {
                  background-color: #dcdcdc;
                }

                .button-container {
                  text-align: center;
                  margin-top: 20px;
                }

                .memberlogo {
                  text-align: center;
                  margin-bottom: 30px;
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

                .coupon table {
                  width: 100%;
                  border-collapse: separate;
                  border-spacing: 0;
                  background-color: #fff;
                  border-radius: 10px;
                  overflow: hidden;
                  box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                  margin-bottom: 20px;
                }

                .coupon th,
                .coupon td {
                  padding: 15px;
                  text-align: left;
                  border-bottom: 1px solid #e0e0e0;
                }

                .coupon th {
                  background-color: #f8f9fa;
                  font-weight: bold;
                  color: #333;
                  text-transform: uppercase;
                  font-size: 14px;
                }

                .coupon tr:last-child td {
                  border-bottom: none;
                }

                .coupon tr:nth-child(even) {
                  background-color: #f9f9f9;
                }

                .coupon tr:hover {
                  background-color: #f0f0f0;
                  transition: background-color 0.3s ease;
                }

                .coupon td:first-child {
                  font-weight: bold;
                  color: #0066cc;
                }

                @media (max-width : 768px) {
                  .coupon table {
                    font-size: 14px;
                  }

                  .coupon th,
                  .coupon td {
                    padding: 10px;
                  }
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
                  <p>${userInfo.user_id} 님</p>
                  <p>회원등급 - ${userInfo.auth}</p>
                  <p>${userInfo.level_name} Level</p>
                  <p class="points">내 포인트 -
                    <fmt:formatNumber value="${userInfo.u_point}" pattern="#,###" />p
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
                  <div class="menu-title"><a
                      href="${pageContext.request.contextPath}/user/mypage/membership?user_id=${sessionScope.loggedInUser.user_id}">멤버십</a>
                  </div>
                </div>
                <div class="menu-section">
                  <div class="menu-title">
                    <div class="menu-title"><a
                        href="${pageContext.request.contextPath}/user/mypage/coupon?user_id=${sessionScope.loggedInUser.user_id}">보유쿠폰</a>
                    </div>
                  </div>
                </div>
                <c:if test="${userInfo.auth == 'S'}">
                  <div class="menu-section">
                    <div class="menu-title"><a href="./sellerpage">* 판매자 전용 *</a></div>
                  </div>
                </c:if>
              </div>

              <main>
                <div class="welcome-box">
                  <div class="heart-icon">❤</div>
                  <p>${userInfo.user_name}님은 현재 ${userInfo.level_name} Level입니다.</p>
                  <button class="rank-btn">등급별 혜택보기</button>
                </div>
                <div class="coupon">

                  <c:forEach items="${coupons}" var="cp" varStatus="status">
                  <div class="container">
                    <div class="card">
                      <div class="main">
                        <div class="co-img">
                          <img src="../../images/xx11.png"
                            alt="" />
                        </div>
                        <div class="vertical"></div>
                        <div class="content">
                          <h2 style="font-weight: 700; color: rgb(158, 5, 163);">${cp.coupon_name }</h2>
                          <p>${cp.limit_date }</p>
                          <p>잔여개수 : ${cp.left_count }</p>
                          <p>발급날짜 : ${cp.cp_date }</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:forEach>

                </div>
                <div id="rankModal" class="modal">
                  <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>등급별 혜택</h2>
                    <table>
                      <tr>
                        <th>등급</th>
                        <th>주문 건수</th>
                        <th>주문금액</th>
                        <th>포인트 적립</th>
                      </tr>
                      <tr>
                        <td>WELCOME</td>
                        <td>0건</td>
                        <td>신규회원</td>
                        <td>-</td>
                      </tr>
                      <tr>
                        <td>FAMILY</td>
                        <td>1건 ↑</td>
                        <td>3만원 ↑</td>
                        <td>-</td>
                      </tr>
                      <tr>
                        <td>VIP</td>
                        <td>3건 ↑</td>
                        <td>30만원 ↑</td>
                        <td>1프로</td>
                      </tr>
                      <tr>
                        <td>VVIP</td>
                        <td>20건 ↑</td>
                        <td>100만원 ↑</td>
                        <td>3프로</td>
                      </tr>
                    </table>
                  </div>
                </div>
              </main>
            </div>
            <%@ include file="../footer.jsp" %>
        </body>

        </html>
