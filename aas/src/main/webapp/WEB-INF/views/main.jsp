<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="./header.jsp" %>
<script src="../js/show_style.js"></script>

  <div style="font-size: 30px; font-weight: bold; text-align: center;">
    인기 공연
  </div><br>

  <div class="swiper-container slider1">
    <div class="swiper-wrapper">
      <div class="swiper-slide"><img src="./images/p1.jpg"></div>
      <div class="swiper-slide"><img src="./images/p2.jpg"></div>
      <div class="swiper-slide"><img src="./images/p3.jpg"></div>
      <div class="swiper-slide"><img src="./images/p4.jpg"></div>
      <div class="swiper-slide"><img src="./images/p5.jpg"></div>
      <div class="swiper-slide"><img src="./images/p6.jpg"></div>
      <div class="swiper-slide"><img src="./images/p7.jpg"></div>
      <div class="swiper-slide"><img src="./images/p8.jpg"></div>
      <div class="swiper-slide"><img src="./images/p9.jpg"></div>
      <div class="swiper-slide"><img src="./images/p10.jpg"></div>
      <div class="swiper-slide"><img src="./images/p11.jpg"></div>
      <div class="swiper-slide"><img src="./images/p12.jpg"></div>
    </div>
    <div class="swiper-pagination swiper-pagination1"></div>

    <div class="swiper-button-next swiper-button-next1"></div>
    <div class="swiper-button-prev swiper-button-prev1"></div>
  </div>

  <div style="font-size: 30px; font-weight: bold; text-align: center;">
    할인 공연
  </div><br>

  <div class="swiper-container slider2">
    <div class="swiper-wrapper">
      <div class="swiper-slide"><img src="./images/p12.jpg"></div>
      <div class="swiper-slide"><img src="./images/p11.jpg"></div>
      <div class="swiper-slide"><img src="./images/p10.jpg"></div>
      <div class="swiper-slide"><img src="./images/p9.jpg"></div>
      <div class="swiper-slide"><img src="./images/p8.jpg"></div>
      <div class="swiper-slide"><img src="./images/p7.jpg"></div>
      <div class="swiper-slide"><img src="./images/p6.jpg"></div>
      <div class="swiper-slide"><img src="./images/p5.jpg"></div>
      <div class="swiper-slide"><img src="./images/p4.jpg"></div>
      <div class="swiper-slide"><img src="./images/p3.jpg"></div>
      <div class="swiper-slide"><img src="./images/p2.jpg"></div>
      <div class="swiper-slide"><img src="./images/p1.jpg"></div>
    </div>

    <div class="swiper-button-next swiper-button-next2"></div>
    <div class="swiper-button-prev swiper-button-prev2"></div>
    <div class="swiper-pagination swiper-pagination2"></div>
  </div><br><br><br><br>

  <div class="container">
    <div style="font-size: 27px; font-weight: bold; text-align: center;">
      전체 공연
    </div><br>
    <div class="row container">
      <div class="col-sm-12">
        <table class="table table-hover">
          <thead class="table-success">
            <th>No.</th>
            <th>공연명</th>
            <th>공연기간</th>
            <th>공연장</th>
            <th>예매율</th>
          </thead>
          <tbody>
            <tr>
              <td>1</td>
              <td>지킬앤하이드</td>
              <td>24.06.06 ~ 24.09.09</td>
              <td>링크아트센터드림</td>
              <td>10%</td>
            </tr>
            <tr>
              <td>2</td>
              <td>웃는남자</td>
              <td>24.06.06 ~ 24.09.09</td>
              <td>성남아트센터</td>
              <td>18%</td>
            </tr>
            <tr>
              <td>3</td>
              <td>헤드윅</td>
              <td>24.06.06 ~ 24.09.09</td>
              <td>소월아트센터</td>
              <td>22%</td>
            </tr>
            <tr>
              <td>4</td>
              <td>시카고</td>
              <td>24.06.06 ~ 24.09.09</td>
              <td>예술의 전당</td>
              <td>2%</td>
            </tr>
          </tbody>
        </table>
<<<<<<< HEAD
        <button>
            <button class="btn btn-default">1</button>
            <button class="btn btn-default">2</button>
            <button class="btn btn-default">3</button>
            <button class="btn btn-default">4</button>
            <button class="btn btn-default">5</button>
       </button><br><br><br>
=======
        <button><</button>
            <button class="btn btn-default">1</button>
            <button class="btn btn-default">2</button>
            <button class="btn btn-default">3</button>
            <button class="btn btn-default">4</button>
            <button class="btn btn-default">5</button>
       <button>></button><br><br><br>
>>>>>>> refs/heads/main
      </div>
    </div>
  </div>
<%@ include file="./footer.jsp" %>