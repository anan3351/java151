<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>mypage</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
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

        main {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
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
    </style>
</head>
<body>

<main>
    <div class="welcome-box">
        <div class="heart-icon">❤</div>
        <p>정동숭님은 현재 WELCOME 등급입니다.</p>
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