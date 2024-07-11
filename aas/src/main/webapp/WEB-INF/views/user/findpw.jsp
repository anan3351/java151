<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/template.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>비밀번호 찾기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

  <link rel="stylesheet" href="../view/template.css"> 

  <link rel="stylesheet" href="/css/template.css">
  
  <style>
        .main-container {
            padding: 20px;
            margin: 200px auto 180px; /* 위쪽 여백을 늘림 */
            
        }
        form {
    width: 40%;
    margin-top: 150px; /* form의 위쪽 여백 추가 */
    margin-left: auto;
    margin-right: auto;
}
        h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 15px;
            
        }
        
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        
    </style>

</head>
<body>
	<%@ include file="../header.jsp" %>
			<div class="main-container">
				<!-- 본문시작 -->
				<div class="container">
    <h2>비밀번호 찾기</h2>
    

    <div >
        <div id="idTab" >
            <form action="#" method="post">
                
                <div class="form-group">
                    <input type="text" class="form-control" id="user_id" placeholder="아이디" required>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="name" placeholder="이름" required>
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" id="email" placeholder="이메일 주소" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">이메일로 비밀번호 받기</button>
            </form>
        </div>
        <div id="pwTab" class="tab-pane fade">
            <!-- 비밀번호 찾기 폼 내용 (필요시 추가) -->
        </div>
    </div>
</div>
				
				
				
				<!-- 본문 끝 -->
			</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>
