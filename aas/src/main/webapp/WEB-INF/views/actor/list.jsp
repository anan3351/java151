<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="/css/template.css">
<div class="container">
    <div class="left-aligned-title">
        <h3>인기배우 TOP5</h3>
    </div>
    <style>
        .header {
            margin-bottom: 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: #333;
            color: #fff;
            padding: 10px 0;
        }

        body {
            padding-top: 150px;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }

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
            height: 150px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 8px;
            padding: 10px;
            position: relative;
        }

        .actor-card img {
            max-width: 80px;
            max-height: 80px;
            border-radius: 50%;
        }

        .actor-card p {
            margin: 10px 0 0;
            font-weight: bold;
            text-align: center;
        }

        .rank-number {
            position: absolute;
            top: -10px;
            left: -10px;
            background-color: gold;
            color: #fff;
            width: 24px;
            height: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
            font-size: 14px;
            font-weight: bold;
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
            transition: background 0.3s;
        }

        .filter-button:hover {
            background: #0056b3;
        }

        .filter-button1 {
            padding: 10px 20px;
            border: none;
            background: #ff6666;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }

        .filter-button1:hover {
            background: #ff4d4d;
        }

        .search-form {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-form input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            width: 200px;
        }

        .search-form button {
            padding: 10px 20px;
            border: none;
            background: #28a745;
            color: #fff;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            transition: background 0.3s;
        }

        .search-form button:hover {
            background: #218838;
        }

        .actor-list table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .actor-list th, .actor-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .actor-list th {
            background: #f4f4f4;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        .page-button, .nav-button {
            margin: 0 5px;
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .page-button:hover, .nav-button:hover {
            background: #0056b3;
        }

        .disabled {
            background: #ddd;
            cursor: not-allowed;
        }

        .page-button.active {
            background-color: red;
            color: white;
        }
    </style>
    <div class="top-actors">
        <c:forEach var="actor" items="${topFavoriteActors}" varStatus="status">
            <div class="actor-card">
                <div class="rank-number">${status.index + 1}</div>
                <img src="${actor.photo}" alt="${actor.a_name}" />
                <p>${actor.a_name}</p>
            </div>
        </c:forEach>
    </div>
</div>
    <div class="filters">

        <div class="filters-right">
            <button class="filter-button" onclick="location.href='${pageContext.request.contextPath}/actor/list'">전체</button>
        </div>
    </div>
    <!-- 검색 폼 -->
    <div class="search-form">
        <form action="${pageContext.request.contextPath}/actor/search" method="get">
            <input type="text" name="search" placeholder="배우 이름 검색">
            <button type="submit">검색</button>
        </form>
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
                        <td><img src="${actor.photo}" alt="${actor.a_name}" style="width:50px; height:75px; border-radius: 4px;"/><br><span style="cursor:pointer; color:blue;" onclick="location.href='${pageContext.request.contextPath}/actordetail?id=${actor.actor_id}'">${actor.a_name}</span></td>
                        <td>${actor.job}</td>
                        <td>${actor.recent_work}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/actor?pageNum=${currentPage - 1}">
                <button class="nav-button">&lt;</button>
            </a>
        </c:if>
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <a href="${pageContext.request.contextPath}/actor?pageNum=${i}">
                <button class="page-button ${currentPage == i ? 'active' : ''}">${i}</button>
            </a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/actor?pageNum=${currentPage + 1}">
                <button class="nav-button">&gt;</button>
            </a>
        </c:if>
    </div>
</div>
<%@ include file="../footer.jsp" %>
</body>
</html>
