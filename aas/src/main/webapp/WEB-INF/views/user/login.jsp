<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
  <link rel="stylesheet" href="/css/template.css">
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>

<c:if test="${registrationSuccess}">
    <script>
        alert("회원가입이 완료되었습니다.\n로그인 페이지로 이동합니다.");
        window.location.href = '/user/login';
    </script>
</c:if>

<c:if test="${not empty loginError}">
    <script>
        alert("${loginError}");
    </script>
</c:if>


<div class="login-container">
  <div class="login-box">
    <div class="logo">
      <a href="${pageContext.request.contextPath}/">
       <img src="../images/xx11.png" alt="로고">
     </a>
    </div>
    <form action="/user/login" method="post">
    <div class="input-fields">
      <input type="text" placeholder="아이디" class="id-input" name="user_id">
      <input type="password" placeholder="비밀번호" class="pw-input" name="pwd">
    </div>
    <div class="remember-me">
    <input type="checkbox" id="remember-me" name="remember-me">
    <label for="remember-me">로그인 상태 유지</label> 
    </div>
      <br>
    <button type="submit" class="login-btn">로그인</button>
    </form>
    <br><br>
    <div class="findlist">
        <a href="./findid">아이디 찾기</a> | <a href="findpw">비밀번호 찾기</a> | <a href="./join">회원가입</a>
    </div>
    <br>
    <a href="" class="btn-link">
    <button class="btn btn-naver">네이버ID로 로그인</button>
    </a>
    <a href="" class="btn-link">
    <button class="btn btn-kakao">카카오ID로 로그인</button>
    </a>
    <a href="" class="btn-link">
    <button class="btn btn-apple">애플ID로 로그인</button>
    </a>
  </div>
</div>
</body>
<style>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin-top: -50px; /* 50px 위로 올립니다 */
}

.login-box {
  width: 400px;
  padding: 40px;
  
}

.logo {
  text-align: center;
  margin-bottom: 30px;
}

.logo img {
  max-width: 150px;
}

.input-fields {
  margin-bottom: 20px;
}

.input-fields input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 16px;
}

.input-fields input:not(:last-child) {
  margin-bottom: 12px;
}

.login-btn {
  width: 100%;
  padding: 12px 0;
  background-color: #0070c9;
  color: #fff;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
}



.findlist {
            text-align: center;
        }
        .findlist a {
            margin: 0 10px; /* 좌우 여백을 추가하여 링크 간격 조정 */
            text-decoration: none; /* 링크 밑줄 제거 */
            color: #000; /* 텍스트 색상 설정 */
        }
        .findlist a:hover {
            color: #007BFF; /* 마우스 오버 시 색상 변경 */
        }
        
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            margin-bottom: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-apple {
            background-color: #b7bdc4;
            color: white;
        }
        .btn-naver {
            background-color: #03c75a;
            color: white;
        }
        .btn-kakao {
            background-color: #fee500;
            color: #000;

</style>