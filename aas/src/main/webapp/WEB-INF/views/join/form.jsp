<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
   
  <title>main</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <link rel="stylesheet" href="/css/template.css">
  <style>
     header .search-bar .btn-search {
        background: url('/images/search.svg') no-repeat;
     }
  </style>

    <style>
        body {
            font-family: 'Malgun Gothic', sans-serif;
            
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 460px;
            margin: 0 auto;
            
            padding: 40px;
            
        }
        
        
        .form-group {
            margin-bottom: 20px;
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
        .submit-btn {
            width: 100%;
            padding: 15px;
            background-color: #4a90e2;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            color: white;
            cursor: pointer;
            margin-top: 30px;
        }
        .info-text {
            font-size: 12px;
            color: #888;
            margin-top: 15px;
            line-height: 1.4;
        }
        .right-align {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<header>
    <div class="logo">
      <a href="${pageContext.request.contextPath}/">
       <img src="/images/logo.png" alt="로고">
     </a>
    </div>
    <div class="search-bar">
      <input type="text" placeholder="공연을 검색 하세요">
      <button type="button" class="btn-search" title="검색"></button>
    </div>
    <div class="user-options">
      <a href="#">로그인</a> | <a href="#">회원가입</a> | <a href="#">마이페이지</a>
    </div>
  </header>
    <div class="container">
        
        <form>
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" placeholder="6-20자 영문, 숫자">
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="8-12자 영문, 숫자, 특수문자">
                <div class="right-align">보기</div>
            </div>
            <div class="form-group">
                <label for="password-confirm">비밀번호 확인</label>
                <input type="password" id="password-confirm" name="password-confirm" placeholder="8-12자 영문, 숫자, 특수문자">
                <div class="right-align">보기</div>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <select id="email" name="email">
                    <option value="">직접입력</option>
                </select>
            </div>
            <div class="form-group">
                <label for="phone">휴대폰</label>
                <div class="phone-group">
                    <input type="text" id="phone" name="phone" placeholder="010 1234 5678">
                    <button type="button">인증번호받기</button>
                </div>
            </div>
            <div class="checkbox-group">
                <label>
                    <input type="checkbox" id="sms-agree" name="sms-agree">
                    SMS, 이메일로 상품 및 이벤트 정보를 받겠습니다.(선택)
                </label>
            </div>
            <div class="checkbox-group">
                <label>
                    <input type="checkbox" id="age-confirm" name="age-confirm">
                    14세 이상입니다.
                </label>
            </div>
            <p class="info-text">만 14세 미만 회원은 법정대리인(부모님) 동의를 받은 경우에만 회원가입이 가능합니다.</p>
            <button type="submit" class="submit-btn">가입하기</button>
        </form>
    </div>
</body>
</html>