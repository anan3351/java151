<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
    
    <style>
    body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
	}
	
	.container {
	    background-color: white;
	    padding: 30px;
	    border-radius: 8px;
	    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	    width: 100%;
	    max-width: 400px;
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
	
	.lock-icon {
	    width: 60px;
	    height: 60px;
	}
	
	.message {
	    text-align: center;
	    font-size: 16px;
	    line-height: 1.5;
	    margin-bottom: 20px;
	}
	
	.highlight {
	    color: #e74c3c;
	    font-weight: bold;
	}
	
	.form-group {
	    margin-bottom: 15px;
	}
	
	input {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	
	.password-rule {
	    font-size: 12px;
	    color: #777;
	    margin-bottom: 20px;
	}
	
	.button-group {
	    display: flex;
	    justify-content: space-between;
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
	.password-input-container {
    position: relative;
}

.password-toggle {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #999;
}

.password-toggle:hover {
    color: #333;
}

input[type="password"], input[type="text"] {
    padding-right: 30px; /* 아이콘을 위한 공간 확보 */
}
    </style>
    <script>
    $(function() {
        $('.password-toggle').on('click', function() {
            var input = $(this).siblings('input');
            var icon = $(this).find('i');
            
            if (input.attr('type') === 'password') {
                input.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                input.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });
    });
    </script>
</head>
<body>
    <div class="container">
        <h1>비밀번호 변경</h1>
        <div class="icon-container">
            <img src="../images/unlock1.png" alt="자물쇠 아이콘" class="lock-icon">
        </div>
        <p class="message">
            주기적인 <span class="highlight">비밀번호 변경</span>을 통해<br>
            개인정보를 안전하게 보호하세요.
        </p>
        <form>
            <div class="form-group">
            	<div class="password-input-container">
                <input type="password" id="new-password" placeholder="새 비밀번호">
                 <span class="password-toggle"><i class="fa fa-eye"></i></span>
                </div>
            </div>
            <div class="form-group">
            	<div class="password-input-container">
                <input type="password" id="confirm-password" placeholder="새 비밀번호 확인">
                 <span class="password-toggle"><i class="fa fa-eye"></i></span>
                </div>
            </div>
            <p class="password-rule">
                ❗비밀번호는 8~12자 이내로 영문(대,소문자), 숫자, 특수문자 3가지 조합 중 2가지 이상을 조합하셔서 만드시면 됩니다.
            </p>
            <div class="button-group">
                <button type="button" class="btn btn-cancel">취소</button>
                <button type="submit" class="btn btn-confirm">변경</button>
            </div>
        </form>
    </div>
</body>
</html>