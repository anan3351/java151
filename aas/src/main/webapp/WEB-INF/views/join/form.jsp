<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="kr">
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
  

  <!-- content start -->
  <div class="container">
    <div class=" row content" style="text-align: center;">
      <div>
      
      <body>
    <div>
        <div class="container">
            <h2>회원가입을 위해<br>정보를 입력해주세요.</h2>

            <!-- input도 inline요소중에 하나다. -->
            <!-- inline이란 하나의 태그가 레코드(가로)방향을 모두 차지하는게 아니라, 자신이 속한 영역만 가지게 되는 것이다. -->
            <label for="email">* 이메일<br>
                <input type="text" id="email"><br><br>
            </label>
            <label for="name">* 이름<br>
                <input type="text" id="name"><br><br>
            </label>
            <label for="password1">* 비밀번호<br>
                <input class="pw" id="password1" type="password"><br><br>
            </label>
            <label for="password2">* 비밀번호 확인<br>
                <input class="pw" id="password2" type="password"><br><br> </label>

            <!-- 선택 영역 두번째 -->
            <!-- name을 부여함으로 인하여 radio의 선택 가능한 것들을 하나의 그룹으로 묶어준다. -->
            <form>
                <input type="radio" class="radio" name="gender">&nbsp 여성
                <input type="radio" class="radio" name="gender">&nbsp 남성
            </form>
            <br><br>
            <form>
                <input type="checkbox" class="agree">&nbsp 이용약관 개인정보 수집 및 정보이용에 동의합니다.
            </form>
            <hr>
            <hr>
            <button>가입하기</button>
            <!-- 기능자체는 input의 타입을 button으로 하면 사용은 가능하지만, 굳이 button 태그를 사용하는 이유는 -->
            <!-- 커스터마이징이 button 태그가 더 용이하기 때문이다. -->
            <!-- <input type="button" value="가입하기"> -->
        </div>
    </div>
    </div>
    </div>
  </div>
</body>

<style>
div {

    /* 바로 상위 태그인 body를 기준으로 맞춰주게끔 */
    /* position의 absolute라는것이, 설정하게 되면
    바로 직계부모 태그의 영향아래 놓이게 된다는 말이다.
    더불어서 네모를 영역으로 봤을때 왼쪽 상단 꼭지점을
    기준으로 움직이게 된다. */
    position: absolute;

    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    width: 670px;
    height: 960px;
    background: #FFFFFF;
    border: 1px solid #AACDFF;
    box-shadow: 7px 7px 39px rgba(0, 104, 255, 0.25);
    border-radius: 20px;

    /* 이것의 의미는 타겟팅된 영역에 대해 
    지정된 만큼 움직여주는 거라고 한다. */
    /* justify-content: space-evenly;
    align-content: column; */

    margin: 0px;
    padding: 100px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    flex-wrap: nowrap;
}

h2 {
    width: 466px;
    height: 94px;
    left: 725px;
    top: 132px;

    font-family: 'Noto Sans CJK KR';
    font-style: normal;
    font-weight: 700;
    font-size: 32px;
    line-height: 47px;

    color: #0068FF;
    justify-content: space-evenly;


}

button {
    width: 400px;
    height: 50px;
    left: 725px;
    top: 875px;
    background-color: #FFFFFF;
    color: royalblue;
    border-radius: 8px;
    border: #0068FF solid 1px;
}

input {
    padding: 0px;
    border: none;
    border-bottom: 1px solid #CFCFCF;
    width: 466px;
    height: 30px;
}

label {
    color: lightgrey;
}

.radio {
    align-items: center;
    font-size: 20pt;
    width: 15px;
    height: 15px;
}

/* div.container {
    justify-content: space-between;
    flex-direction: row;
    align-items: center;
} */

input.agree {
    align-items: center;
    font-size: 20pt;
    width: 15px;
    height: 15px;
}
</style>
      