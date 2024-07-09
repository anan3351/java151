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

          <style>
            /* 슬라이드 CSS */
            .slider {
              position: relative;
              max-width: 1400px;
              margin: 0 auto 0;
              padding: 0 15px;
              font-size: 0;
              text-align: center;
            }

            .slider .inner {
              padding-bottom: 74px;
              padding-top: 87px;
              overflow: hidden;
              height: auto;
              width: 100%;
              margin: 0 auto;
            }

            .slider-back .slide_list {
              left: -40px;
            }

            .slide_list>li {
              position: relative;
              width: 20%;
              margin: 0;
              font-size: 20px;
              line-height: 150px;
              color: #000;
              text-align: center;
              z-index: 0;
              transform: scale(1);
              transition: all 0.3s;
              padding: 0;
              background-color: transparent;
            }

            .swiper-slide {
              border: none;
            }

            .slide_list .swiper-slide img {
              max-width: 100%;
              height: auto;
              box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
              border-radius: 10px;

            }


            /* 영역별 크기 설정 */
            .slide_list>li.swiper-slide-next,
            .slide_list>li.swiper-slide-prev,
            .slide_list>li.swiper-slide-duplicate-next,
            .slide_list>li.swiper-slide-duplicate-prev {
              z-index: 50;
              transform: scale(1.2);
            }

            .slide_list>li.swiper-slide-active,
            .slide_list>li.swiper-slide-duplicate-active {
              z-index: 100;
              transform: scale(1.4);
            }

            /* 영역별 밝기 설정 */
            .slide_list>li:after {
              content: '';
              position: absolute;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background: rgba(0, 0, 0, 0.5);
              transition: all 0.3s;
              opacity: 1;
            }

            .slide_list>li.swiper-slide-next:after,
            .slide_list>li.swiper-slide-prev:after,
            .slide_list>li.swiper-slide-duplicate-next:after,
            .slide_list>li.swiper-slide-duplicate-prev:after {
              background: rgba(0, 0, 0, 0.3);
            }

            .slide_list>li.swiper-slide-active:after,
            .slide_list>li.swiper-slide-duplicate-active:after {
              opacity: 0;
            }



            /*슬라이드1*/


            .slider1 .swiper-wrapper .swiper-slide {
              display: flex;
              flex-direction: column;
            }

            .slider1 .swiper-wrapper .swiper-slide .item-list {
              padding-left: 0;
              margin-top: 10px;
            }

            .slider1 .swiper-wrapper .swiper-slide li {
              list-style: none;
              text-align: left;
            }

            .slider1 .swiper-wrapper .swiper-slide .item-date {
              font-weight: 700;
              font-size: 17px;
              color: #8e43e7;
              line-height: 150%;
            }

            .slider1 .swiper-wrapper .swiper-slide .item-name {
              white-space: normal;
              overflow: hidden;
              text-overflow: ellipsis;
              line-height: 150%;
              max-height: 300%;
              word-wrap: break-word;
              word-break: break-all;
              margin-top: 4px;
              color: #000;
              font-weight: 700;
              font-size: 19px;
            }

            .slider1 .swiper-wrapper .swiper-slide .item-hall {
              margin-top: 4px;
              font-size: 15px;
              color: #999;
              font-weight: 400;
            }

            /* 화살표 */
            .slider .btn {
              position: absolute;
              top: 40%;
              transform: translateY(-50%);
              z-index: 9999;
              display: inline-block;
              width: 35px;
              height: 35px;
              margin: 30px 15px 0;
              background: url('./image/search.svg') center no-repeat;
              background-size: cover;
              text-indent: -999em;
              cursor: pointer;
            }

            .slider .btn.btn_prev {
              transform: rotateY(180deg);
              left: 80px;
            }

            .slider .btn.btn_next {
              right: 80px;
            }

            .swiper-button-next,
            .swiper-container-rtl .swiper-button-prev {
              right: 60px;
            }

            .swiper-button-next,
            .swiper-button-prev {
              top: 40%
            }

            @media (max-width: 768px) {
              .slider .inner {
                padding: 38px 0;
              }

              .slide_list>li {
                width: 33.333%;
              }

              .slide_list>li.swiper-slide-next,
              .slide_list>li.swiper-slide-prev,
              .slide_list>li.swiper-slide-duplicate-next,
              .slide_list>li.swiper-slide-duplicate-prev {
                transform: scale(1);
              }

              .slide_list>li.swiper-slide-active,
              .slide_list>li.swiper-slide-duplicate-active {
                transform: scale(1.5);
              }
            }

            .list-wrap {
              background-color: #efefef;
              padding: 60px
            }

            .table-wrap {
              max-width: 1000px;
              margin: 0 auto;
            }

            .table {
              text-align: center;
            }

            .slider-back {
              background: rgb(92, 67, 93);
              background: linear-gradient(to right, #0f0c29, #302b63, #24243e);
              padding-block: 40px 20px;
            }

            .slider-back .slider-tit {
              margin-bottom: 25px;
              text-align: center;
            }

            .slider-back .slider-tit p {
              font-size: 52px;
              color: #fff;
              font-weight: 600;
              letter-spacing: 3.8px;
              margin-top: 12px;
              margin-bottom: 0;
            }

            .slider-back .slider-tit span {
              padding: 8px 23px;
              background-color: #0f0c29;
              font-size: 24px;
              border-radius: 40px;
              color: #fff;
              font-weight: 600px;

            }

            .slider-back .slider-tit em {
              font-style: normal;
              color: #fff;
              font-size: 26px;
              text-decoration: none;
            }

            /*pagination custom*/
            .pagination>li:first-child>a,
            .pagination>li:first-child>span {
              border-radius: 100%;
            }

            .pagination>li:nth-last-child(3)>a,
            .pagination>li:nth-child(3)>span {
              padding: 6px 8px;
            }

            .pagination>li:nth-last-child(2)>a,
            .pagination>li:nth-child(2)>span {
              border-radius: 0;
              border: none;
            }

            .pagination>li:nth-last-child(1)>a,
            .pagination>li:nth-child(1)>span {
              border-radius: 0;
              border: none
            }

            .pagination>li>a,
            .pagination>li>span {
              border-radius: 100%;
              border: none;
              color: #535353;
              margin-left: 0;
            }

            .pagination>.disabled>a,
            .pagination>.disabled>a:focus,
            .pagination>.disabled>a:hover,
            .pagination>.disabled>span,
            .pagination>.disabled>span:focus,
            .pagination>.disabled>span:hover {
              background-color: rgb(51, 230, 176);
              color: #fff;
              font-weight: 700;
            }

            .pagination>li>a:focus,
            .pagination>li>a:hover,
            .pagination>li>span:focus,
            .pagination>li>span:hover {
              background-color: transparent;
            }

            .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>a:focus,
            .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>a:hover,
            .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>span:focus,
            .pagination>li:nth-last-child(n+3):nth-last-child(-n+12)>span:hover {
              background-color: #eee;
            }
          </style>

        </head>

        <body>
          <%@ include file="./header.jsp" %>
            <div class="main-container">
              <!-- 본문시작 -->

              <script src="../js/show.js"></script>

              <script src="../js/show_swiper.js"></script>


              <div class="slider-back">
                <div class="slider-tit">
                  <span>세상의 모든 공연을 한 곳에</span>
                  <p>
                    인기있는 공연을 지금 확인해보세요
                  </p>
                </div>
                <div class="slider">
                  <div class="inner">
                    <ul class="swiper-wrapper slide_list">
                      <li class="swiper-slide"><img src="./images/p1.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p2.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p3.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p4.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p5.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p6.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p7.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p8.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p9.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p10.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p11.jpg"></li>
                      <li class="swiper-slide"><img src="./images/p12.jpg"></li>
                    </ul>
                  </div>
                  <span class="btn btn_prev swiper-button-next2"></span>
                  <span class="btn btn_next"></span>
                </div>
              </div>
              <div style="font-size: 30px; margin-top: 80px; font-weight: bold; text-align: center;">
                할인 공연
              </div><br>
              <div class="swiper-slide"></div>

              <div class="swiper-container slider1">
                <div class="swiper-wrapper">
                  <div class="swiper-slide">
                    <img src="./images/p11.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.21(월) 12:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide">
                    <img src="./images/p12.jpg">
                    <ul class="item-list">
                      <li class="item-date">8.08(월) 16:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p10.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.11(월) 20:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p9.jpg">
                    <ul class="item-list">
                      <li class="item-date">8.23(월) 21:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p8.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.08(월) 18:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p7.jpg">
                    <ul class="item-list">
                      <li class="item-date">9.08(월) 18:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p6.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.22(월) 17:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p5.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.02(월) 19:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p4.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.11(월) 19:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p3.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.23(월) 20:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                  <div class="swiper-slide"><img src="./images/p2.jpg">
                    <ul class="item-list">
                      <li class="item-date">7.11(월) 21:00</li>
                      <li class="item-name">가스파드〈선천적 얼간이들〉락 뮤지컬 ♬</li>
                      <li class="item-hall">예술의전당</li>
                    </ul>
                  </div>
                </div>

                <div class="swiper-button-next swiper-button-next2"></div>
                <div class="swiper-button-prev swiper-button-prev2"></div>
                <div class="swiper-pagination swiper-pagination2"></div>
              </div><br><br><br><br>

              <div class="list-wrap">
                <div style="font-size: 27px; font-weight: bold; text-align: center;">
                  전체 공연
                </div><br>
                <div class="table-wrap">
                  <div>
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
                  </div>
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
                </div>

              </div>

            </div>
            <!-- 본문 끝 -->

            <%@ include file="./footer.jsp" %>

              <script>
                //
                $(window).on('load', function () {
                  slider();
                })
                function slider() {
                  let swiper = undefined;
                  let slideNum = $('.slider .swiper-slide').length // 슬라이드 총 개수
                  let slideInx = 0; // 현재 슬라이드 index

                  // 디바이스 체크
                  let oldWChk = window.innerWidth > 767 ? 'pc' : 'mo';
                  sliderAct();

                  let resizeTimer;
                  $(window).on('resize', function () {
                    clearTimeout(resizeTimer);
                    resizeTimer = setTimeout(function () {
                      let newWChk = window.innerWidth > 767 ? 'pc' : 'mo';
                      if (newWChk != oldWChk) {
                        oldWChk = newWChk;
                        sliderAct();
                      }
                    }, 300);
                  })

                  // 슬라이드 실행
                  function sliderAct() {
                    // 슬라이드 초기화 
                    if (swiper != undefined) {
                      swiper.destroy();
                      swiper = undefined;
                    }

                    // slidesPerView 옵션 설정
                    let viewNum = oldWChk == 'pc' ? 4 : 2;
                    // loop 옵션 체크
                    let loopChk = slideNum > viewNum;

                    swiper = new Swiper(".slider .inner", {
                      slidesPerView: "auto",
                      initialSlide: slideInx,
                      loop: loopChk,
                      centeredSlides: true,
                      autoplay: {
                        delay: 3000,
                        disableOnInteraction: false
                      },
                      navigation: {
                        nextEl: '.slider .btn_next',
                        prevEl: '.slider .btn_prev',
                      },
                      on: {
                        activeIndexChange: function () {
                          slideInx = this.realIndex; // 현재 슬라이드 index 갱신
                        }
                      },
                    });
                  }
                }
              </script>
        </body>

        </html>