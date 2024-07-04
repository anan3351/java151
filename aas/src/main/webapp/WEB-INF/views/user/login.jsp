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
        alert("ȸ�������� �Ϸ�Ǿ����ϴ�.\n�α��� �������� �̵��մϴ�.");
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
       <img src="../images/xx11.png" alt="�ΰ�">
     </a>
    </div>
    <form action="/user/login" method="post">
    <div class="input-fields">
      <input type="text" placeholder="���̵�" class="id-input" name="user_id">
      <input type="password" placeholder="��й�ȣ" class="pw-input" name="pwd">
    </div>
    <div class="remember-me">
    <input type="checkbox" id="remember-me" name="remember-me">
    <label for="remember-me">�α��� ���� ����</label> 
    </div>
      <br>
    <button type="submit" class="login-btn">�α���</button>
    </form>
    <br><br>
    <div class="findlist">
        <a href="./findid">���̵� ã��</a> | <a href="findpw">��й�ȣ ã��</a> | <a href="./join">ȸ������</a>
    </div>
    <br>
    <a href="" class="btn-link">
    <button class="btn btn-naver">���̹�ID�� �α���</button>
    </a>
    <a href="" class="btn-link">
    <button class="btn btn-kakao">īī��ID�� �α���</button>
    </a>
    <a href="" class="btn-link">
    <button class="btn btn-apple">����ID�� �α���</button>
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
  margin-top: -50px; /* 50px ���� �ø��ϴ� */
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
            margin: 0 10px; /* �¿� ������ �߰��Ͽ� ��ũ ���� ���� */
            text-decoration: none; /* ��ũ ���� ���� */
            color: #000; /* �ؽ�Ʈ ���� ���� */
        }
        .findlist a:hover {
            color: #007BFF; /* ���콺 ���� �� ���� ���� */
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