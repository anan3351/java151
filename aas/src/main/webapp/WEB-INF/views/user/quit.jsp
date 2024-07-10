<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>탈퇴</title>
    <script>
        window.onload = function() {
            var urlParams = new URLSearchParams(window.location.search);
            var success = urlParams.get('success');
            if (success === 'true') {
                alert("탈퇴가 완료되었습니다.");
                window.location.href = '/'; 
            }
        }
    </script>
    
    <style>
    body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}
.main-content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: flex-start; /* 상단 정렬 유지 */
    padding: 120px 0 80px; /* 상단 패딩을 80px로 증가 */
}
    
    .container {
    background-color: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 500px;
    box-sizing: border-box;
     margin-top: 40px; /* 상단 마진 추가 */
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
<%@ include file="../header.jsp" %>
<div class="main-content">
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
        <form id="deleteForm" action="${pageContext.request.contextPath}/user/delete" method="post">
    		<input type="hidden" name="user_id" value="${sessionScope.loggedInUser.user_id}">
		    <div class="button-group">
		        <button type="button" class="btn btn-cancel" onclick="window.history.back()">취소</button>
		        <button type="button" class="btn btn-confirm" onclick="confirmDelete()">탈퇴</button>
		    </div>
		</form>
    </div>
    </div>
    <%@ include file="../footer.jsp" %>
    
</body>
<script>
    function confirmDelete() {
        const checkbox = document.getElementById('quit-confirm');
        if (!checkbox.checked) {
            alert("반드시 탈퇴시 주의사항을 읽어주세요!");
            return;
        }
        
        if (confirm("정말로 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
            const form = document.getElementById('deleteForm');
            if (form) {
                form.submit();
            } else {
                console.error('Form not found');
                alert('오류가 발생했습니다. 관리자에게 문의해주세요.');
            }
        }
    }
</script>

</html>