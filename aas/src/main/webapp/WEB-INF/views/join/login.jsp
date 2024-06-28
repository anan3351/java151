<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<div class="login-container">
  <div class="login-box">
    <div class="logo">
      <a href="${pageContext.request.contextPath}/">
       <img src="../images/xx11.png" alt="로고">
     </a>
    </div>
    <div class="input-fields">
      <input type="text" placeholder="아이디" class="id-input">
      <input type="password" placeholder="비밀번호" class="pw-input">
    </div>
    <button class="login-btn">로그인</button>
    <div class="social-login">
      <a href="#" class="social-btn kakao-btn">
        <img src="../images/s1.png" alt="Kakao Icon">
      </a>
      <a href="#" class="social-btn naver-btn">
        <img src="../images/s5.png" alt="Naver Icon">
      </a>
      <a href="#" class="social-btn apple-btn">
        <img src="../images/s6.png" alt="Apple Icon">
      </a>
    </div>
  </div>
</div>
<style>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin-top: -150px; /* 50px 위로 올립니다 */
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

.social-login {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.social-btn {
  display: inline-block;
  width: 40px;
  height: 40px;
  margin: 0 8px;
  border-radius: 50%;
  background-color: #f5f5f5;
  display: flex;
  justify-content: center;
  align-items: center;
}

.social-btn img {
  max-width: 24px;
}

</style>