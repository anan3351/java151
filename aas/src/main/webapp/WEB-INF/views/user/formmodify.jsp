<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <title>회원정보수정</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <link rel="stylesheet" href="/css/template.css">
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  

  <style>
    body {
      font-family: 'Malgun Gothic', sans-serif;
      margin: 0;
      padding: 20px;
    }

    .container {
      max-width: 500px;
      margin: 0 auto;
      padding: 40px;
    }

    .form-group {
      margin-bottom: 20px;
      position: relative;
    }

    .form-group label {
      display: block;
      font-weight: bold;
      color: #000;
      margin-bottom: 5px;
    }

    input[type="text"],
    input[type="password"],
    select {
      width: 100%;
      padding: 10px 0;
      border: none;
      border-bottom: 1px solid #ddd;
      font-size: 16px;
      box-sizing: border-box;
      background-color: transparent;
    }

    input::placeholder,
    select {
      color: #999;
    }

    select {
      appearance: none;
      background: url('data:image/svg+xml;utf8,<svg fill="%23999" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 10px center;
      background-size: 12px;
    }

    .phone-group {
      display: flex;
      align-items: center;
    }

    .phone-group input {
      flex-grow: 1;
      margin-right: 10px;
    }

    .phone-group button {
      padding: 10px 15px;
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      color: #333;
      white-space: nowrap;
    }

    .checkbox-group {
      margin-top: 20px;
    }

    .checkbox-group label {
      display: flex;
      align-items: center;
      font-size: 14px;
      color: #666;
      font-weight: normal;
    }

    .checkbox-group input[type="checkbox"] {
      margin-right: 10px;
    }
    .button-group {
    display: flex;
    gap: 10px; /* 버튼 간의 간격 조정 */
  }

  .button-group button {
    flex: 1;
    padding: 15px;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    color: white;
    cursor: pointer;
    margin-top: 30px;
  }

  .cancel-btn {
    background-color: #c5c9cc;
  }

  .submit-btn {
    background-color: #0070c9;
  }

    .info-text {
      font-size: 12px;
      color: #888;
      margin-top: 15px;
      line-height: 1.4;
    }

    .right-align {
      position: absolute;
      top: 36px;
      right: 10px;
      font-size: 14px;
      color: #999;
      cursor: pointer;
    }

    .right-align i {
      cursor: pointer;
    }
    
    .ssn-group {
      display: flex;
      align-items: center;
    }

    .ssn-group input {
      width: calc(50% - 10px);
      margin-right: 10px;
    }

    .ssn-group span {
      margin: 0 5px;
      font-size: 18px;
      color: #333;
    }
    
    .email-group {
      display: flex;
      align-items: center;
    }

    .email-group input,
    .email-group select {
      margin-right: 10px;
      flex: 1;
    }

    .email-group span {
      margin: 0 5px;
      font-size: 18px;
      color: #333;
    }

    .email-group select {
      flex: 0.5;
    }
  </style>

  <script>
    

    function setEmailDomain(domain) {
      $("#email_domain").val(domain);
    }
  </script>
  
</head>

<body>
  <div class="container">
    <form action="/user/updateUser" method="post">
      <div class="form-group">
        <label for="id">아이디</label>
        <input type="text" id="id" name="user_id" value="${userInfo.user_id}" readonly>
      </div>
      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name" value="${userInfo.user_name}">
      </div>
     
     <div class="form-group">
	    <label for="email">이메일</label>
		    <div class="email-group">
		    <c:set var="emailParts" value="${userInfo.email.split('@')}" />
		        <input type="text" id="email_id" name="email_id" value="${emailParts[0]}" class="form_w200" placeholder="이메일" maxlength="18" />
		        <span>@</span>
		        <input type="text" id="email_domain" name="email_domain" value="${emailParts[1]}" class="form_w200" placeholder="이메일 도메인" maxlength="18" />
		        <select class="select" onchange="setEmailDomain(this.value);">
		            <option value="">직접입력</option>
		            <option value="naver.com">naver.com</option>
		            <option value="gmail.com">gmail.com</option>
		            <option value="hanmail.net">hanmail.net</option>
		            <option value="hotmail.com">hotmail.com</option>
		            <option value="yahoo.com">yahoo.com</option>
		        </select>
		    </div>
		     <input type="hidden" id="email" name="email" />
		    <br>
		    <div class="phone-group">
        <button type="button" onclick="checkEmail()">EMAIL중복확인</button>
        </div>
		</div>
		   
      <div class="form-group">
        <label for="phone">휴대폰</label>
        <div class="phone-group">
          <input type="text" id="tel_num" name="tel_num" value="${userInfo.tel_num}" maxlength="13" placeholder="휴대폰 번호" oninput="autoHyphen(this)">
          <button type="button">인증번호받기</button>
        </div>
      </div>
      <div class="form-group">
        <label>정보 수신 동의</label>
        <div class="checkbox-group">
          <label>
            <input type="checkbox" id="all_agree" name="all_agree">
            이벤트, 쇼핑레터 수신동의
          </label>
        </div>
        <div class="checkbox-group">
          <label>
            <input type="checkbox" id="sms_agree" name="sms_agree">
            SMS 수신 (변동일 : 2021-10-15 23:12:14)
          </label>
        </div>
        <div class="checkbox-group">
          <label>
            <input type="checkbox" id="email_agree" name="email_agree">
            이메일 수신 (변동일 : 2021-10-15 23:12:14)
          </label>
        </div>
        <p class="info-text">
          회원정보 중 필요한 정보만 공개됨을 알려드립니다. 수신동의 여부와 관계없이 발송됩니다.
        </p>
      </div>
      
      <div class="button-group">
        <button type="button" class="cancel-btn" onclick="history.back()">취소하기</button>
        <button type="submit" class="submit-btn">수정하기</button>
      </div>
    </form>
  </div>

  
</body>
<script>
let isEmailDuplicate = true;
    
    function checkEmail() {
        var emailId = $("#email_id").val();
        var emailDomain = $("#email_domain").val();
        var email = emailId + '@' + emailDomain;
        $.ajax({
            url: "/user/checkEmail",
            type: "GET",
            data: { email: email },
            success: function(response) {
                if (response === "duplicate") {
                    alert("중복된 이메일입니다.");
                    isEmailDuplicate = true;
                } else if (response === "available") {
                    alert("사용 가능한 이메일입니다.");
                    isEmailDuplicate = false;
                } else {
                    alert("이메일 중복 확인 중 오류가 발생했습니다.");
                    isEmailDuplicate = true;
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX Error:", textStatus, errorThrown);
                alert("이메일 중복 확인 중 오류가 발생했습니다.");
                isEmailDuplicate = true;
            }
        });
    }
    
  //이메일 입력 필드의 값이 변경될 때마다 isEmailDuplicate를 true로 설정
    $("#email_id, #email_domain").on('input', function() {
        isEmailDuplicate = true;
    });
  
  
  //tel_num 자동 하이픈
    function autoHyphen(target) {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3")
            .replace(/(\-{1,2})$/g, "");

        // 11자리를 초과하는 숫자 입력 방지
        if (target.value.replace(/-/g, '').length > 11) {
            target.value = target.value.slice(0, 13); // 하이픈 포함 13자
        }
    }
 

    // 이메일 도메인 선택 시 자동 입력
    function setEmailDomain(domain) {
      $("#email_domain").val(domain);
    }

    // 폼 제출 전 이메일 조합
    $('form').submit(function() {
      var emailId = $('#email_id').val();
      var emailDomain = $('#email_domain').val();
      $('#email').val(emailId + '@' + emailDomain);
    });

    // 페이지 로드 시 이메일 도메인 선택
    $(document).ready(function() {
      var emailDomain = "${emailParts[1]}";
      $("select.select option").each(function() {
        if ($(this).val() == emailDomain) {
          $(this).prop("selected", true);
        }
      });
    });
  </script>
</html>