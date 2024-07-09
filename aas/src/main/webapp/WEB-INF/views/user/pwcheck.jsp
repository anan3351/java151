<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 인증</title>
    <link rel="stylesheet" href="styles.css">
    
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
	    margin-bottom: 10px;
	}
	
	.highlight {
	    color: #e74c3c;
	    font-weight: bold;
	}
	
	.sub-message {
	    text-align: center;
	    font-size: 14px;
	    color: #777;
	    margin-bottom: 20px;
	}
	
	.form-group {
	    margin-bottom: 15px;
	}
	
	label {
	    display: block;
	    margin-bottom: 5px;
	    font-weight: bold;
	}
	
	input {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	
	.button-group {
	    display: flex;
	    justify-content: space-between;
	    margin-top: 20px;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>비밀번호 인증</h1>
        <div class="icon-container">
            <img src="../images/lock2.png" alt="자물쇠 아이콘" class="lock-icon">
        </div>
        <p class="message">
            정보를 안전하게 보호하기 위해<br>
            <span class="highlight">비밀번호를 다시 한 번 확인합니다.</span>
        </p>
        <p class="sub-message">비밀번호가 타인에게 노출되지 않도록 항상 주의해주세요.</p>
        <form>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" value="seung3970" readonly>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password">
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-cancel">취소</button>
                <button type="submit" class="btn btn-confirm">확인</button>
            </div>
        </form>
    </div>
</body>
</html>