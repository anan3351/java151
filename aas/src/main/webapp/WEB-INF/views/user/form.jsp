<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <title>join/form</title>
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
    window.onload = function() {
        <c:if test="${not empty focusField}">
            document.getElementById('${focusField}').focus();
        </c:if>
    }
</script>
  
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
                document.getElementById('post').value = data.zonecode;
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

    .submit-btn {
      width: 100%;
      padding: 15px;
       background-color: #0070c9;
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
    
    let isIdDuplicate = true; // 초기값을 true로 설정

    function checkUserId() {
        var userId = $("#user_id").val();
        $.ajax({
            url: "/user/checkUserId",
            type: "GET",
            data: { user_id: userId },
            success: function(response) {
                if (response === "duplicate") {
                    alert("중복된 ID입니다.");
                    isIdDuplicate = true;
                } else if (response === "available") {
                    alert("사용 가능한 ID입니다.");
                    isIdDuplicate = false;
                } else {
                    alert("ID 중복 확인 중 오류가 발생했습니다.");
                    isIdDuplicate = true;
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX Error:", textStatus, errorThrown);
                alert("ID 중복 확인 중 오류가 발생했습니다.");
                isIdDuplicate = true;
            }
        });
    }
    
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
    
    function isValidResidentNumber(snum1, snum2) {
        var rrn = snum1 + snum2;
        
        // 주민등록번호 형식 검사 (6자리 - 7자리)
        if (!/^\d{6}-?\d{7}$/.test(rrn)) {
            return false;
        }

        // 생년월일 유효성 검사
        var year = parseInt(rrn.substr(0, 2));
        var month = parseInt(rrn.substr(2, 2));
        var day = parseInt(rrn.substr(4, 2));
        
        if (month < 1 || month > 12) {
            return false;
        }
        
        var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (day < 1 || day > maxDaysInMonth[month - 1]) {
            // 윤년 체크 (2월인 경우)
            if (!(month === 2 && day === 29 && (year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0)))) {
                return false;
            }
        }

        // 뒷자리 첫 번째 숫자 검사
        var genderCode = parseInt(rrn.charAt(6));
        if (genderCode === 0 || genderCode > 4) {
            return false;
        }

        // 체크섬 검사
        var multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
        var sum = 0;
        for (var i = 0; i < 12; i++) {
            sum += parseInt(rrn.charAt(i)) * multipliers[i];
        }
        var checksum = (11 - (sum % 11)) % 10;
        if (checksum !== parseInt(rrn.charAt(12))) {
            return false;
        }

        return true;
    }
    
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
    
  </script>
  
</head>

<body>




  
  <div class="container">
    <form name="joinfrm" id="joinfrm" method="post" action="insert" enctype="multipart/form-data">
      <div class="form-group">
        <label for="id">아이디</label>
        <div class="phone-group">
        <input type="text" id="user_id" name="user_id" placeholder="6-20자 영문, 숫자">
        <button type="button" onclick="checkUserId()">ID중복확인</button>
        </div>
      </div>
      <div class="form-group">
        <label for="password">비밀번호</label>
        <input type="password" id="pwd" name="pwd" placeholder="8-12자 영문, 숫자, 특수문자" maxlength="12">
        <div class="right-align"><i class="fa fa-eye fa-lg"></i></div>
      </div>
      <div class="form-group">
        <label for="password-confirm">비밀번호 확인</label>
        <input type="password" id="pwd-confirm" name="pwd-confirm" placeholder="8-12자 영문, 숫자, 특수문자" maxlength="12">
        <div class="right-align"><i class="fa fa-eye fa-lg"></i></div>
      </div>
      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="user_name" name="user_name">
      </div>
      <div class="form-group">
        <label for="ssn">주민등록번호</label>
        <div class="ssn-group">
          <input type="text" id="snum1" name="snum1" maxlength="6" placeholder="앞자리">
          <span>-</span>
          <input type="password" id="snum2" name="snum2" maxlength="7" placeholder="뒷자리">
        </div>
         <input type="hidden" id="snum" name="snum" />
      </div>
      <div class="form-group">
        <label for="postcode">우편번호</label>
        <div class="phone-group">
	        <input type="text" id="post" name="post" readonly>
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
        <input type="text" id="tel_num" name="tel_num" maxlength="13" placeholder="휴대폰 번호" oninput="autoHyphen(this)">
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
  
  
  
  <script>
  
  document.querySelector('form').addEventListener('submit', function (event) {
	    event.preventDefault(); // 항상 기본 제출을 방지

	    if (isIdDuplicate) {
	        alert("중복된 아이디는 사용하실 수 없습니다.");
	        document.getElementById('user_id').focus();
	        return; // 폼 제출을 중단
	    }
	    
	    if (isEmailDuplicate) {
	        alert("중복된 이메일은 사용하실 수 없습니다.");
	        document.getElementById('email_id').focus();
	        return;
	    }
	    
	    var snum1 = document.getElementById('snum1').value;
	    var snum2 = document.getElementById('snum2').value;
	    if (!isValidResidentNumber(snum1, snum2)) {
	        alert("유효하지 않은 주민등록번호입니다.");
	        document.getElementById('snum1').focus();
	        return;
	    }
	    
	 // 전화번호 유효성 검사
	    var telNum = document.getElementById('tel_num').value.replace(/-/g, '');
	    if (telNum.length !== 11) {
	        alert("유효한 전화번호를 입력해주세요.");
	        document.getElementById('tel_num').focus();
	        return;
	    }

	   

	    

	    // memberCheck() 함수 호출
	    if (memberCheck()) {
	        // 이메일 주소 결합
	        var emailId = document.getElementById('email_id').value;
	        var emailDomain = document.getElementById('email_domain').value;
	        var email = emailId + '@' + emailDomain;
	        document.getElementById('email').value = email;

	        // 주민등록번호 결합
	        var snum1 = document.getElementById('snum1').value;
	        var snum2 = document.getElementById('snum2').value;
	        var snum = snum1 + snum2;
	        document.getElementById('snum').value = snum;

	        // 폼 제출
	        this.submit();
	    }
	});
  
//ID 입력 필드의 값이 변경될 때마다 isIdDuplicate를 true로 설정
  document.getElementById('user_id').addEventListener('input', function() {
      isIdDuplicate = true;
  });
  
//이메일 입력 필드의 값이 변경될 때마다 isEmailDuplicate를 true로 설정
  $("#email_id, #email_domain").on('input', function() {
      isEmailDuplicate = true;
  });
  

  function memberCheck() {
      // 아이디 유효성 검사
      let id = $("#user_id").val().trim();
      if (id.length < 6 || id.length > 20) {
          alert("아이디는 6~20글자로 작성해주세요!");
          $("#user_id").focus();
          return false;
      }

      // 비밀번호 유효성 검사
      let passwd = $("#pwd").val().trim();
      if (passwd.length < 8 || passwd.length > 12) {
          alert("비밀번호는 8~12글자로 작성해주세요!");
          $("#pwd").focus();
          return false;
      }

      // 비밀번호 확인
      let repasswd = $("#pwd-confirm").val().trim();
      if (passwd != repasswd) {
          alert("비밀번호와 비밀번호 확인이 일치하지 않습니다!");
          $("#pwd-confirm").focus();
          return false;
      }

      // 이름 유효성 검사
      let mname = $("#user_name").val().trim();
      if (mname.length < 2) {
          alert("이름은 두 글자 이상 입력해주세요!");
          $("#user_name").focus();
          return false;
      }
      
      //우편번호 유효성 검사
      let post = $("#post").val().trim();
      if (post.length < 1) {
          alert("우편번호를 입력해주세요!");
          $("#post").focus();
          return false;
      }
      
   
      
    //상세주소 유효성 검사
      let addr2 = $("#addr2").val().trim();
      if (addr2.length < 1) {
          alert("상세주소를 입력해주세요!");
          $("#addr2").focus();
          return false;
      }
      
   // 14세 이상 확인 체크박스 검사
      let ageConfirm = $("#age-confirm").prop("checked");
      if (!ageConfirm) {
          alert("14세 이상임을 확인해주세요.");
          $("#age-confirm").focus();
          return false;
      }
      

      // 모든 유효성 검사 통과시 true 반환
      return true;
  }
  
 
  </script>

</body>

</html>