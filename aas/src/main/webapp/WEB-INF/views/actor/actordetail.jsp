<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="/css/template.css">
<h1>배우 상세 정보</h1>
<style>
        .header {
            margin-bottom: 0;
            position: fixed;
            top: 50;
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

    .container {
        display: flex;
        padding: 20px;
        background: #fff;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        margin: 20px auto;
        max-width: 800px;
    }

    .actor_photo img {
        width: 150px;
        height: auto;
        border-radius: 8px;
        margin-right: 20px;
    }

    .actor_info {
        display: flex;
        flex-direction: column;
        width: 100%;
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
        color: #555;
    }

    .actor_detail dd {
        color: #777;
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

    .favorite-button {
        display: inline-block;
        width: 30px;
        height: 30px;
        background-size: contain;
        background-repeat: no-repeat;
        cursor: pointer;
        border: none;
        margin-top: 10px;
    }
</style>

<div class="container">
    <div class="actor_photo">
        <img src="${actor.photo}" alt="${actor.a_name}">
    </div>
    <div class="actor_info">
        <!-- 배우 이름 -->
        <div class="actor_name">
            <span class="title">${actor.a_name}</span>
        </div>
        <!-- //배우 이름 -->
        <!-- 배우 세부 정보 -->
        <div class="actor_detail">
            <dl>
                <dt>직업</dt>
                <dd>${actor.job}</dd>
                <dt>생년월일</dt>
                <dd>${actor.birth}</dd>
                <dt>신체조건</dt>
                <dd>${actor.physical}</dd>
                <dt>소속사</dt>
                <dd>${actor.agency}</dd>
                <dt>사이트</dt>
                <dd>${actor.site}</dd>
            </dl>
        </div>
        <!-- //배우 세부 정보 -->
        <!-- 즐겨찾기 추가/삭제 버튼 -->
        <button class="favorite-button" id="favorite-button" style="background-image: url('/images/bheart.png');"></button>
        <!-- //즐겨찾기 추가/삭제 버튼 -->
    </div>
</div>

<h1>공연 정보 추가 예정</h1>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    var actorId = ${actor.actor_id};
    // 페이지 로드 시 즐겨찾기 상태 확인
    $.ajax({
        url: '${pageContext.request.contextPath}/favorite/check',
        type: 'GET',
        data: {
            actor_id: actorId
        },
        success: function(response) {
            if (response === 'added') {
                $('#favorite-button').css('background-image', 'url(/images/kheart.png)');
            } else {
                $('#favorite-button').css('background-image', 'url(/images/bheart.png)');
            }
        }
    });

    $('#favorite-button').click(function(e) {
        e.preventDefault();
        $.ajax({
            url: '${pageContext.request.contextPath}/favorite/toggle',
            type: 'POST',
            data: {
                actor_id: actorId
            },
            success: function(response) {
                if (response === 'added') {
                    $('#favorite-button').css('background-image', 'url(/images/kheart.png)');
                    alert('즐겨찾기에 추가되었습니다.');
                } else if (response === 'removed') {
                    $('#favorite-button').css('background-image', 'url(/images/bheart.png)');
                    alert('즐겨찾기에서 삭제되었습니다.');
                } else if (response === 'not_logged_in') {
                    alert('로그인이 필요합니다.');
                    window.location.href = '${pageContext.request.contextPath}/user/login';
                }
            },
            error: function() {
                alert('오류가 발생했습니다.');
            }
        });
    });
});
</script>
