<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>My Page</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f0f0f0;
    display: flex;
    flex-direction: row; /* 기본적으로 가로 배치 */
    padding: 20px;
}

        .sidebar {
    width: 250px;
    background-color: white;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    margin-right: 20px;
    border-radius: 10px;
    flex-shrink: 0; /* 사이드바 크기 고정 */
}

        .profile {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #ddd;
            margin: 0 auto 10px;
        }

        .points {
            font-weight: bold;
            color: #0066cc;
        }

        .menu-section {
            margin-bottom: 20px;
        }

        .menu-title {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .menu-items {
            list-style-type: none;
            padding: 0;
        }

        .menu-items li {
            margin-bottom: 5px;
        }

        .menu-items a {
            color: #666;
            text-decoration: none;
        }

        .menu-items a:hover {
            color: #0066cc;
        }
        
        .menu-title a {
    color: #000; /* 검정색으로 변경 */
    text-decoration: none;
    display: block;
    padding: 5px 0;
    transition: color 0.3s ease;
}

.menu-title a:hover {
    color: #333; /* 호버 시 약간 밝은 검정색으로 변경 */
}

.menu-title a::before {
    margin-right: 5px;
    color: #000; /* 불릿 포인트 색상도 검정색으로 변경 */
}

        main {
    flex-grow: 1;
    padding: 20px;
    max-width: 800px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: white;
        }

        .logo {
            color: #0066cc;
            font-weight: bold;
            font-size: 24px;
        }

        .login {
            color: #666;
        }

        .welcome-box {
            background-color: white;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .heart-icon {
            font-size: 24px;
            color: #ff6b6b;
        }

        .rank-btn {
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .menu-item {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            border: none;
            font-size: 16px;
        }

        .icon {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .menu-item p {
            margin: 5px 0;
            font-weight: bold;
        }

        .menu-item small {
            color: #666;
            font-size: 12px;
        }

        .btn-search {
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .user-options a {
            color: #666;
            margin-left: 10px;
        }

        .user-options a:hover {
            color: #000;
        }

        .search-bar input {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        @media (max-width: 768px) {
    body {
        flex-direction: column; /* 화면이 좁아지면 세로로 배치 */
    }

    .sidebar {
        width: auto;
        margin-right: 0;
        margin-bottom: 20px;
    }

    main {
        max-width: 100%;
    }
}
    </style>
</head>
<body>
    <div class="sidebar">
    <div class="profile">
        <div class="profile-image"></div>
        <p>${userInfo.user_id} 님</p>
        <p>회원등급 - ${userInfo.auth}</p>
        <p>${userInfo.level_name} Level</p>
        <p class="points">내 포인트 - <fmt:formatNumber value="${userInfo.u_point}" pattern="#,###"/>p</p>
    </div>
        <div class="menu-section">
            <div class="menu-title">예매 티켓</div>
            <ul class="menu-items">
                <li><a href="#">예매 티켓 조회</a></li>
                <li><a href="#">예매 취소/체매매</a></li>
                <li><a href="#">예매대기</a></li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">내 스케줄</div>
            <ul class="menu-items">
                <li><a href="#">스케줄 작성</a></li>
                <li><a href="#">스케줄 수정/삭제</a></li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">즐겨찾기</div>
            <ul class="menu-items">
                <li><a href="#">관심배우</a></li>
                <li><a href="#">관심공연</a></li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">나의 후기</div>
            <ul class="menu-items">
                <li><a href="#">좌석 후기</a></li>
                <li><a href="#">공연 후기</a></li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title"><a href="#">멤버십</a></div>
        </div>
        <div class="menu-section">
            <div class="menu-title"><a href="#">보유쿠폰</a></div>
        </div>
        <c:if test="${userInfo.auth == 'S'}">
		    <div class="menu-section">
		        <div class="menu-title"><a href="./sellerpage">* 판매자 전용 *</a></div>
		    </div>
		</c:if>
    </div>

    <main>
        <div class="welcome-box">
            <div class="heart-icon">❤</div>
            <p>${userInfo.user_name}님은 현재 ${userInfo.level_name} Level입니다.</p>
            <button class="rank-btn">등급별 혜택보기</button>
        </div>

        <div class="menu-grid">
            <button class="menu-item" onclick="window.location.href='./formmodify'">
                <div class="icon">👥</div>
                <p>회원정보수정</p>
                <small>본인인증, 휴대전화 등 내정보를 수정하세요.</small>
            </button>
            <button class="menu-item" onclick="window.location.href='./pwmodify'">
                <div class="icon">🔒</div>
                <p>비밀번호변경</p>
                <small>주기적인 변경으로 내정보를 보호하세요.</small>
            </button>
            <button class="menu-item">
                <div class="icon">🔚</div>
                <p>회원탈퇴</p>
            </button>
        </div>
    </main>
</body>
</html>