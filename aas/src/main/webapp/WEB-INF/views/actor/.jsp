<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    <div class="filters">
        <div class="filters-left">
            <button class="filter-button">주간조회수</button>
            <button class="filter-button">누적조회수</button>
        </div>
        <div class="filters-right">
            <button class="filter-button">전체</button>
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
            <a href="/actor/list?pageNum=${i}">
                <button class="page-button">${i}</button>
            </a>
        </c:forEach>
    </div>
</div>



<%@ include file="../footer.jsp" %>