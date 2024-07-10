<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="/css/template.css">
<h1>배우 상세 정보</h1>
    <style>
    .header {
        margin-bottom: 0; /* 기존 margin-bottom 값을 0으로 설정 */
        position: fixed; /* 헤더를 고정 위치로 설정 */
        top: -10; /* 상단에 고정 */
        width: 100%; /* 전체 너비를 사용 */
        z-index: 1000; /* 다른 요소보다 위에 위치 */
    }

    body {
        padding-top: 200px; /* 헤더 높이만큼 상단 패딩을 추가 */
    }
        .container {
            display: flex;
            padding: 20px;
        }
        .actor_photo img {
            width: 150px;
            height: auto;
            margin-right: 20px;
        }
        .actor_info {
            display: flex;
            flex-direction: column;
        }
        .actor_info .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .actor_detail {
            margin-bottom: 20px;
        }
        .actor_detail dl {
            display: flex;
            flex-wrap: wrap;
            width: 400px;
        }
        .actor_detail dt, .actor_detail dd {
            width: 50%;
            margin: 0;
            padding: 5px 0;
        }
        .actor_detail dt {
            font-weight: bold;
        }
        .detail_contentbox {
            margin-top: 20px;
        }
        .detail_contentbox h4 {
            margin-bottom: 10px;
        }
        .showtitle {
            font-weight: bold;
        }
        .time, .hall {
            color: #777;
        }
        
        
    </style>

<div class="container">
    <div class="actor_photo">
        <img src="${actor.photo}" alt="${actor.a_name}">
    </div>
    <div class="actor_info">
        <!-- 배우 이름 -->
        <div class="actor_name">
            <table border="0" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td>
                        <span class="title">${actor.a_name}</span>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- //배우 이름 -->
         <!-- 배우 세부 정보 -->
        <div class="actor_detail">
            <dl>
                <dt><strong>직업</strong></dt>
                <dd>${actor.job}</dd>
                <dt><strong>생년월일</strong></dt>
                <dd>${actor.birth}</dd>
                <dt><strong>신체조건</strong></dt>
                <dd>${actor.physical}</dd>
                <dt><strong>소속사</strong></dt>
                <dd>${actor.agency}</dd>
                <dt><strong>사이트</strong></dt>
                <dd>${actor.site}</dd>
            </dl>
 		</div>
       </div>
   </div>
   
   
   <h1>공연 정보 추가 예정</h1>
   