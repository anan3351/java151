<%@page import="com.example.demo.user.UserDTO" %>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
          <% UserDTO loggedInUser=(UserDTO) session.getAttribute("loggedInUser"); String userId=loggedInUser !=null ?
            loggedInUser.getUser_id() : "" ; %>

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
                .list-title {
                  font-size: 28px;
                  font-weight: 600;
                  text-align: center;
                  padding-top: 40px;
                }

                .button-container {
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  margin: 0px auto;
                  max-width: 800px;
                  width: 100%;
                  padding: 0 15px;
                  box-sizing: border-box;
                  position: relative;
                  left: 40px;
                  /* 추가 */
                }

                .filter-buttons {
                  display: flex;
                  gap: 10px;
                  margin-right: 20px;
                  /* 장바구니 아이콘과의 간격 */
                }

                .filter-button {
                  background-color: rgb(51, 230, 176);
                  /* 녹색 배경 */
                  border: none;
                  color: black;
                  padding: 10px 10px;
                  text-align: center;
                  text-decoration: none;
                  display: flex;
                  font-size: 13px;
                  margin: 4px 2px;
                  cursor: pointer;
                  border-radius: 12px;
                  transition: background-color 0.3s ease;
                }

                .filter-button:hover {
                  background-color: #45a049;
                  /* 마우스 오버시 더 진한 녹색 */
                }

                .filter-button:focus {
                  outline: none;
                  box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.5);
                }

                #btn-cart {
                  background-color: #fff;
                  border: 2px solid #fff;
                  padding: 0;
                  position: relative;
                  margin-bottom: 33px;
                  bottom: -15px;

                }

                .cart-icon {
                  position: relative;
                  width: 50px;
                  height: 50px;
                  top: 45%;
                  left: 55%;
                  transform: translate(-48%, -15%);
                }

                #cartCount {
                  position: absolute;
                  font-size: 17px;
                  font-weight: bold;
                  color: black;
                  background-color: #03ffc0;
                  border-radius: 50%;
                  width: 24px;
                  left: 35px;
                }
              </style>

              <script type="text/javascript">
                var userId = "<%= userId %>";  // EL을 사용하여 userId 값을 가져옵니다.
                console.log('userId from JSP:', userId);

                function checkLogin() {
                  return new Promise((resolve, reject) => {
                    $.ajax({
                      url: '/user/checkLoginStatus',
                      type: 'GET',
                      success: function (response) {
                        if (response.isLoggedIn) {
                          resolve(true);  // 로그인 되어 있음
                        } else {
                          alert("로그인이 필요한 서비스입니다.");
                          // 현재 페이지 URL을 저장
                          sessionStorage.setItem('redirectAfterLogin', '/hall/list');
                          window.location.href = '/user/login';  // 로그인 페이지로 리다이렉트
                          resolve(false);  // 로그인 되어 있지 않음
                        }
                      },
                      error: function (xhr, status, error) {
                        console.error('로그인 상태 확인 중 오류 발생:', error);
                        reject(error);
                      }
                    });
                  });
                }

                // 페이지 로드 시 실행
                document.addEventListener('DOMContentLoaded', function () {
                  if (userId) {
                    updateCartCount();
                  } else {
                    checkLoginAndUpdateCart();
                  }
                });

                function checkLoginAndUpdateCart() {
                  if (userId) {
                    updateCartCount();
                  } else {
                    $.ajax({
                      url: '/user/checkLoginStatus',
                      type: 'GET',
                      success: function (response) {
                        if (response.isLoggedIn) {
                          userId = response.userId;
                          updateCartCount();
                        }
                      },
                      error: function (xhr, status, error) {
                        console.error('로그인 상태 확인 중 오류 발생:', error);
                      }
                    });
                  }
                }

                function updateCartCount() {
                  if (!userId) {
                    console.error('userId is not set.');
                    return;  // userId가 없으면 함수 실행하지 않음
                  }

                  console.log('Updating cart count for userId:', userId);
                  
                  $.ajax({
                    url: '/hall/cartCount',
                    type: 'GET',
                    data: { userId: userId },
                    success: function (response) {
                      const cartCountElement = document.getElementById('cartCount');
                      let count;

                      // 응답이 숫자인 경우
                      if (typeof response === 'number') {
                        count = response;
                      } else if (typeof response === 'string') {
                        // 응답이 문자열인 경우 숫자로 변환
                        count = parseInt(response, 10);
                      } else if (typeof response.count !== 'undefined') {
                        // 응답이 객체인 경우 count 프로퍼티 확인
                        count = response.count;
                      } else {
                        console.error('Unexpected response format:', response);
                        return;
                      }

                      if (count > 0) {
                        cartCountElement.textContent = count;
                        cartCountElement.style.display = 'inline';
                      } else {
                        cartCountElement.style.display = 'none';
                      }
                    },
                    error: function (xhr, status, error) {
                      console.error('Error:', error);
                    }
                  });
                }

                function listCartOrder() {
                  checkLogin().then(isLoggedIn => {
                    if (isLoggedIn) {
                      window.location.href = '/hall/hallOrder';
                    }
                  });
                }


              </script>
            </head>

            <body>
              <%@ include file="../header.jsp" %>
                <div class="main-container">
                  <!-- 본문시작 -->
                  <%-- 기본 경로 설정 --%>
                    <c:set var="basePath" value="${pageContext.request.contextPath}" />
                    <h1 class="list-title">공연장 목록</h1>
                    <div class="button-container">
                      <div class="filter-buttons">
                        <button class="filter-button" onclick="location.href='/hall/list?filter=all'">공연장 전체목록</button>
                        <button class="filter-button" onclick="location.href='/hall/list?filter=available'">공연장
                          대관가능목록</button>
                      </div>
                      <div class="cart-wrap">
                        <button type="button" id="btn-cart" onclick="listCartOrder()">
                          <img src="<c:url value='/images/cart.png' />" alt="장바구니" class="cart-icon">
                          <span id="cartCount"></span>
                        </button>
                      </div>
                    </div>

                    <!-- 검색 영역 시작-->
                    <form action="/hall/list" class="form-inline d-flex justify-content-end search-box" method="GET">
                      <select name="field" id="field" class="sel-search">
                        <option value="hname">공연장명</option>
                        <option value="addr">주소</option>
                      </select>
                      <input type="text" id="word" name="word" class="inp-search">
                      <input type="submit" class="btn-search2" value="검색">
                    </form>
                    <!-- 검색 영역 끝 -->


                    <div class="table-wrap">
                      <table class="table table-hover">
                        <thead>
                          <tr>
                            <th>공연장명</th>
                            <th>주소</th>
                            <th>URL</th>
                            <th>객석수</th>
                            <th>전화번호</th>
                            <th>시설분류</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="hall" items="${ulist.content}">
                            <tr>
                              <td>
                                <a href="detail/${hall.hall_id}" onclick="return checkLogin()"> ${hall.hname} </a>
                              </td>
                              <td>${hall.addr}</td>
                              <td><a href="${hall.url}" target="_blank">${hall.url}</a></td>
                              <td>${hall.seat}</td>
                              <td>${hall.h_call}</td>
                              <td>${hall.h_code}</td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>


                      <!-- 페이징 시작 -->
                      <div class="text-xs-center">
                        <ul class="pagination justify-content-center">
                          <!-- 이전 -->
                          <c:choose>
                            <c:when test="${ulist.first}"></c:when>
                            <c:otherwise>
                              <li class="page-item"><a class="page-link"
                                  href="${basePath}/hall/list?field=${field}&word=${word}&page=0">처음</a></li>
                              <li class="page-item"><a class="page-link"
                                  href="${basePath}/hall/list?field=${field}&word=${word}&page=${ulist.number - 1}">&larr;</a>
                              </li>
                            </c:otherwise>
                          </c:choose>

                          <!-- 페이지 그룹 -->
                          <c:forEach begin="${startBlockPage}" end="${endBlockPage}" var="i">
                            <c:choose>
                              <c:when test="${ulist.pageable.pageNumber + 1 == i}">
                                <li class="page-item disabled"><a class="page-link"
                                    href="${basePath}/hall/list?field=${field}&word=${word}&page=${i - 1}">${i}</a></li>
                              </c:when>
                              <c:otherwise>
                                <li class="page-item"><a class="page-link"
                                    href="${basePath}/hall/list?field=${field}&word=${word}&page=${i - 1}">${i}</a></li>
                              </c:otherwise>
                            </c:choose>
                          </c:forEach>

                          <!-- 다음 -->
                          <c:choose>
                            <c:when test="${ulist.last}"></c:when>
                            <c:otherwise>
                              <li class="page-item"><a class="page-link"
                                  href="${basePath}/hall/list?field=${field}&word=${word}&page=${ulist.number + 1}">&rarr;</a>
                              </li>
                              <li class="page-item"><a class="page-link"
                                  href="${basePath}/hall/list?field=${field}&word=${word}&page=${ulist.totalPages - 1}">마지막</a>
                              </li>
                            </c:otherwise>
                          </c:choose>
                        </ul>
                      </div>
                      <!-- 페이징 끝 -->
                    </div>
                    <!-- 본문 끝 -->

                </div>
                <%@ include file="../footer.jsp" %>

            </body>

            </html>