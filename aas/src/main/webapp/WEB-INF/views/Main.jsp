<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <title>main</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <link rel="stylesheet" href="/css/template.css">
</head>

<body>
  <header>
    <div class="logo">
      <img src="./images/logo.png" alt="로고">
    </div>
    <div class="search-bar">
      <input type="text" placeholder="공연을 검색 하세요">
      <button type="button" class="btn-search" title="검색"></button>
    </div>
    <div class="user-options">
      <a href="#">로그인</a> | <a href="#">회원가입</a> | <a href="#">마이페이지</a>
    </div>
  </header>

  <!-- content start -->
  <nav>
    <ul>
      <li><a href="#">뮤지컬</a></li>
      <li><a href="#">연극</a></li>
      <li><a href="#">배우</a></li>
      <li><a href="#">공연장</a></li>
      <li><a href="#">공지사항</a></li>
      <li><a href="#">Q&A</a></li>
    </ul>
  </nav>
  <br><br>
  <div class="container">
    <div class=" row content" style="text-align: center;">
      <div>
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
        </div>

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
            <button>
              << /button>
                <button class="btn btn-default">1</button>
                <button class="btn btn-default">2</button>
                <button class="btn btn-default">3</button>
                <button class="btn btn-default">4</button>
                <button class="btn btn-default">5</button>
                <button>></button><br><br><br>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- content end -->

  <footer class="container-fluid bg-4 text-center"
    style="position: relative; height: 100px; padding-bottom: 60px; overflow: hidden;">
    <div style="font-size: medium; position: absolute; left: 50px; top: 10px; text-align: left; opacity: 0.7;">
      (팀) All About Show <br>
      주소 서울특별시 강남구 테헤란로 124 4층 (역삼동, 삼원타워)<br>
      사업자번호 xxxxx-xxxxx
      <br><br>
      Copyright &copy; 2024 MyWeb
    </div>
    <div
      style="display: flex; justify-content: center; align-items: center; position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%);">
      <img src="./images/s1.png" alt="k" style="height: 30px; margin: 0 5px;">
      <img src="./images/s2.png" alt="f" style="height: 43px; margin: 0 5px;">
      <img src="./images/s3.png" alt="i" style="height: 35px; margin: 0 5px;">
      <img src="./images/s4.png" alt="t" style="height: 25px; margin: 0 5px;">
    </div>
    <div
      style="font-size: medium; position: absolute; right: 50px; top: 10px; text-align: right; padding-right: 150px;">
      <div style="white-space: nowrap; text-align: right; opacity: 0.6;">
        <span style="display: inline-block; width: 150px; text-align: left;">3조</span><br>
        <span style="display: inline-block; width: 150px; text-align: left;">김정현&nbsp;박지환&nbsp;이상엽&nbsp;정동승&nbsp;조태승</span>
      </div>
    </div>
  </footer>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      //이미지 4개
      var swiper1 = new Swiper('.slider1', {
        slidesPerView: 4,
        spaceBetween: 30,
        pagination: {
          el: '.swiper-pagination1',
          clickable: true,
        },
        navigation: {
          nextEl: '.swiper-button-next1',
          prevEl: '.swiper-button-prev1',
        },
        autoplay: {
          delay: 2000,
          disableOnInteraction: false,
        },
      });

      //이미지 6개
      var swiper2 = new Swiper('.slider2', {
        slidesPerView: 6,
        spaceBetween: 30,
        pagination: {
          el: '.swiper-pagination2',
          clickable: true,
        },
        navigation: {
          nextEl: '.swiper-button-next2',
          prevEl: '.swiper-button-prev2',
        },

      });
    });
  </script>

</body>
</html>