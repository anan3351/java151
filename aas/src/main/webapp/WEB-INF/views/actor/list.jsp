<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>template</title>
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

</body>

</html>
=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<div class="container">
    <div class="left-aligned-title">
        <h3>인기배우 TOP5</h3>
    </div>
    <style>
        .left-aligned-title {
            text-align: left;
            margin-bottom: 20px;
        }

        h1, h3 {
            margin-bottom: 20px;
        }

        .top-actors {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .actor-card {
            width: 100px;
            height: 200px; /* Adjust height to accommodate both image and text */
            background: #e0e0e0;
            display: flex;
            flex-direction: column; /* Change flex direction to column */
            justify-content: center;
            align-items: center;
            border-radius: 4px;
        }

        .actor-card img {
            max-width: 100%;
            max-height: 150px; /* Limit image height */
        }

        .actor-card p {
            margin: 5px 0 0; /* Add margin to separate text from image */
        }

        .filters {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .filters-left, .filters-right {
            display: flex;
            gap: 10px;
        }

        .filter-button {
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }

        .filter-button:hover {
            background: #0056b3;
        }
        

        .actor-list table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .actor-list th, .actor-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .pagination {
            display: flex;
            justify-content: center;
        }

        .page-button {
            margin: 0 5px;
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }

        .page-button:hover {
            background: #0056b3;
        }
    </style>
    <div class="top-actors">
        <c:forEach var="actor" items="${list}" varStatus="status">
            <c:if test="${status.index < 5}">
                <div class="actor-card">
                    <img src="${actor.photo}" alt="${actor.a_name}" />
                    <p>${actor.a_name}</p>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="filters">
        <div class="filters-left">
            <button class="filter-button">주간조회수</button>
            <button class="filter-button">누적조회수</button>
        </div>
        <div class="filters-right">
            <button class="filter-button" onclick="location.href='${pageContext.request.contextPath}/actor/alllist'">전체</button>
            <button class="filter-button">국내</button>
            <button class="filter-button">해외</button>
        </div>
    </div>
    <div class="actor-list">
        <table>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>직업</th>
                    <th>최근공연</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="actor" items="${list}">
                    <tr>
                        <td><img src="${actor.photo}" alt="${actor.a_name}" style="width:50px; height:75px;"/><br>${actor.a_name}</td>
                        <td>${actor.job}</td>
                        <td><!-- 최근공연 정보를 여기에 추가 --></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <a href="${pageContext.request.contextPath}/actor/list?pageNum=${i}">
                <button class="page-button">${i}</button>
            </a>
        </c:forEach>
    </div>
</div>

>>>>>>> refs/heads/main
