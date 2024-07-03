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
  
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addr2").value = extraAddr;
                
                } else {
                    document.getElementById("addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
</script>

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

    .email-group input {
      flex-basis: 40%; /* 이메일과 도메인 입력 필드의 기본 너비 */
      flex-grow: 1; /* 이메일과 도메인 입력 필드의 증가 비율 */
      margin-right: 10px;
    }

    .email-group select {
      flex-basis: 20%; /* 셀렉트 박스의 기본 너비 */
      flex-grow: 2; /* 셀렉트 박스의 증가 비율 */
      margin-right: 10px;
    }

    .email-group span {
      flex-shrink: 0; /* '@'의 너비 고정 */
    }
  </style>

  <script>
    $(document).ready(function () {
      $('.right-align i').on('click', function () {
        var input = $(this).closest('.form-group').find('input');
        if (input.attr('type') === 'password') {
          input.attr('type', 'text');
          $(this).attr('class', 'fa fa-eye-slash fa-lg');
        } else {
          input.attr('type', 'password');
          $(this).attr('class', 'fa fa-eye fa-lg');
        }
      });
    });

    function setEmailDomain(domain) {
      $("#email_domain").val(domain);
    }
  </script>
  
</head>

<body>
  
  <div class="container">
    <form>
      <div class="form-group">
        <label for="id">아이디</label>
        <input type="text" id="id" name="id" placeholder="6-20자 영문, 숫자">
      </div>
      <div class="form-group">
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" placeholder="8-12자 영문, 숫자, 특수문자">
        <div class="right-align"><i class="fa fa-eye fa-lg"></i></div>
      </div>
      <div class="form-group">
        <label for="password-confirm">비밀번호 확인</label>
        <input type="password" id="password-confirm" name="password-confirm" placeholder="8-12자 영문, 숫자, 특수문자">
        <div class="right-align"><i class="fa fa-eye fa-lg"></i></div>
      </div>
      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="name">
      </div>
      <div class="form-group">
        <label for="ssn">주민등록번호</label>
        <div class="ssn-group">
          <input type="text" id="ssn1" name="ssn1" maxlength="6" placeholder="앞자리">
          <span>-</span>
          <input type="password" id="ssn2" name="ssn2" maxlength="7" placeholder="뒷자리">
        </div>
      </div>
      <div class="form-group">
        <label for="postcode">우편번호</label>
        <div class="phone-group">
	        <input type="text" id="postcode" name="postcode" readonly>
	        <button type="button" onclick="sample6_execDaumPostcode()">우편번호찾기</button>
        </div>
      </div>
      <div class="form-group">
        <label for="addr1">주소</label>
        <input type="text" id="addr1" name="addr1" readonly>
      </div>
      <div class="form-group">
        <label for="addr2">상세주소</label>
        <input type="text" id="addr2" name="addr2">
      </div>
      <div class="form-group">
	    <label for="email">이메일</label>
		    <div class="email-group">
		        <input type="text" id="email_id" class="form_w200" placeholder="이메일" maxlength="18" />
		        <span>@</span>
		        <input type="text" id="email_domain" class="form_w200" placeholder="이메일 도메인" maxlength="18" />
		        <select class="select" onchange="setEmailDomain(this.value);">
		            <option value="">-선택-</option>
		            <option value="naver.com">naver.com</option>
		            <option value="gmail.com">gmail.com</option>
		            <option value="hanmail.net">hanmail.net</option>
		            <option value="hotmail.com">hotmail.com</option>
		            <option value="korea.com">korea.com</option>
		            <option value="nate.com">nate.com</option>
		            <option value="yahoo.com">yahoo.com</option>
		        </select>
		    </div>
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
      <div class="button-group">
		  <button type="button" class="cancel-btn">취소하기</button>
		  <button type="submit" class="submit-btn">수정하기</button>
	  </div>
    </form>
  </div>

</body>

</html>