<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <style>
  	
  	/*header*/
    header {
      margin: 0 auto;
      width:1600px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
      background-color: #fff;
    }

    header .logo img {
      display: inline-block;
      height: 40px;
      width: 192px;
      background-color: #413f3f;
    }

    header .search-bar{position: relative;}

    header .search-bar input {
      border-radius: 25px;
      width: 600px;
      padding: 5px 20px;
      height: 50px;
      border: 1px solid #c5c5c5;
    }

    header .search-bar .btn-search{
      position: absolute;
      width:20px;
      height:20px;
      border:none;
      right:20px;
      top: 50%;
      transform: translateY(-50%);
      background: url('./images/search.svg') no-repeat;

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
      width:100%;
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
    .slider1 {
      position: relative;
    }


    .swiper-container {
      width: 100%;
      height: 300px;
      margin-bottom: 50px;
    }

    .swiper-slide {
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      border: 1px solid #ccc;
      padding: 10px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .swiper-slide img {
      max-width: 100%;
      height: auto;
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
    footer {
      background-color: #413f3f;
      color: white;
      padding: 15px;
    }

    .centerBox {
      width: 450;
      margin-left: auto;
      margin-right: auto;
    }



    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }

      .row.content {
        height: auto;
      }
    }
  </style>
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
    <nav>
      <ul>
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
        </div>

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
        </div>

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
            <button><</button>
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
        <span
          style="display: inline-block; width: 150px; text-align: left;">김정현&nbsp;박지환&nbsp;이상엽&nbsp;정동승&nbsp;조태승</span>

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