<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>main</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

  <link rel="stylesheet" href="../view/template.css"> 

  <link rel="stylesheet" href="/css/template.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <title>SNS 회원가입</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    margin: 0;
    background-color: #f5f5f5;
}
.page-content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}
        .container {
    text-align: center;
    background-color: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 400px;
}
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        p {
            font-size: 14px;
            color: #666;
            margin-bottom: 30px;
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
        .btn-primary {
            background-color: #1a73e8;
            color: white;
        }
        .btn-naver {
            background-color: #03c75a;
            color: white;
        }
        .btn-kakao {
            background-color: #fee500;
            color: #000;
        }
        .small-text {
            font-size: 12px;
            color: #999;
            margin-top: 20px;
        }
         .btn-link {
        text-decoration: none;
        display: block;  /* 블록 레벨 요소로 변경 */
        width: 100%;     /* 너비를 100%로 설정 */
    }
    
    .btn-link:hover {
        text-decoration: none;  /* 호버 시에도 밑줄 제거 */
    }
    
    .btn-link .btn {
        width: 100%;     /* 버튼의 너비를 100%로 설정 */
    }
    
    footer {
    width: 100%;
    background-color: #333;
    color: white;
    text-align: center;
    padding: 10px 0;
}
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="page-content">
        <div class="container">
            <h1>All About Show 회원가입</h1>
            <p>지금 가입 하신 후 All About Show의 다양한 서비스를 경험해보세요</p>
            <a href="agreement" class="btn-link">
                <button class="btn btn-primary">개인 회원가입</button>
            </a>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>