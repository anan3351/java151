<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<div class="login-container">
  <div class="login-box">
    <div class="logo">
      <a href="${pageContext.request.contextPath}/">
       <img src="../images/xx11.png" alt="�ΰ�">
     </a>
    </div>
    <div class="input-fields">
      <input type="text" placeholder="���̵�" class="id-input">
      <input type="password" placeholder="��й�ȣ" class="pw-input">
    </div>
    <div class="remember-me">
    <input type="checkbox" id="remember-me" name="remember-me" value="true">
    <label for="remember-me">�α��� ���� ����</label> 
    </div>
      <br>
    <button class="login-btn">�α���</button>
    <br><br>
    <div class="findlist">
      <a href="#">���̵� ã��</a> | <a href="#">��й�ȣ ã��</a> | <a href="./form">ȸ������</a>
    </div>
    <br>
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
  margin-top: -150px; /* 50px ���� �ø��ϴ� */
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
  width: 435px;
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

.findlist {
            text-align: center;
        }
        .findlist a {
            margin: 0 10px; /* �¿� ������ �߰��Ͽ� ��ũ ���� ���� */
            text-decoration: none; /* ��ũ ���� ���� */
            color: #000; /* �ؽ�Ʈ ���� ���� */
        }
        .findlist a:hover {
            color: #007BFF; /* ���콺 ���� �� ���� ���� */
        }

</style>