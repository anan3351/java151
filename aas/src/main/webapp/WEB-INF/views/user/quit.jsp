<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>탈퇴</title>
    <link rel="stylesheet" href="styles.css">
    
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    
    .container {
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 500px; /* 수정: 원하는 가로 최대 너비로 조정 */
        box-sizing: border-box; /* 수정: padding과 border 포함한 크기 계산 */
    }
    
    h1 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }
    
    .icon-container {
        text-align: center;
        margin-bottom: 20px;
    }
    
    .quit-icon {
        width: 60px;
        height: 60px;
    }
    
    .message {
        text-align: center;
        font-size: 16px;
        line-height: 1.5;
        margin-bottom: 20px; /* 여백 추가 */
    }
    
    .highlight {
        color: #e74c3c;
        font-weight: bold;
    }
    
    .highlight2 {
        color: #050505;
        font-weight: bold;
    }
    
    ul {
        list-style-type: lower-roman;
        padding: 0;
        margin: 0;
    }
    
    ul li {
        margin-bottom: 15px;
        line-height: 1.6;
    }
    
    label {
        font-weight: bold;
    }
    
    .button-group {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }
    
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        width: 48%;
    }
    
    .btn-cancel {
        background-color: #e0e0e0;
        color: #333;
    }
    
    .btn-confirm {
        background-color: #007bff;
        color: white;
    }
    
    .btn:hover {
        opacity: 0.9;
    }
    </style>
</head>
<body>
    <div class="container">
        <h1>회원탈퇴</h1>
        <div class="icon-container">
            <img src="../images/quit1.png" alt="탈퇴 아이콘" class="quit-icon">
        </div>
        <p class="message">
            회원탈퇴를 진행합니다.<br>
            <span class="highlight">탈퇴하게 되면 되돌릴수 없으니 신중하게 진행해주세요</span>
        </p>
        <hr>
        <p class="highlight2">탈퇴시 주의사항</p>
        	<ul>
            <li>
            	<span class="highlight">적립금/혜택 소멸 및 재가입시 복구 불가</span><br>
                회원 탈퇴 시, 회원님 아이디에 등록된 적립금과 우수고객등급에 따른 혜택은 모두 소멸되어, 재가입하더라도 복구되지 않습니다. (Point, 영화/공연/문화 예매권, 할인쿠폰 등)
            </li>
            <li>
            <span class="highlight">관계법령에 따른 주문번호는 회원 탈퇴 후 5년간 보존</span><br>
                전자상거래 등에서의 소비자 보호에 관한 법률 제6조(거래기록의 보존 등)에 의거, 주문정보는 회원 탈퇴 후 5년간 보존됩니다.
            </li>
            <li>
            	<span class="highlight">예매번호, 예매내역 열람 불가</span><br>
                티켓 예매 후 탈퇴 시에 공연 관람은 가능하나 예매번호, 예매내역을 볼 수 없으며, 예매취소 및 배송지 변경은 예매번호를 가지고 고객센터를 통해서만 진행 가능합니다.
            </li>
        </ul>
    
        <hr>
        <input type="checkbox" id="quit-confirm" name="quit-confirm"> <label for="quit-confirm">탈퇴를 진행하겠습니다.</label>
        <form>
            <div class="button-group">
                <button type="button" class="btn btn-cancel">취소</button>
                <button type="submit" class="btn btn-confirm">탈퇴</button>
            </div>
        </form>
    </div>
</body>
</html>