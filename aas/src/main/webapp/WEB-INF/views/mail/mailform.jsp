<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메일 전송 폼</title>
</head>
<body>
    <h1>메일 전송</h1>
    
    <% if(request.getAttribute("message") != null) { %>
        <p><%= request.getAttribute("message") %></p>
    <% } %>
    
    <form action="sendMail" method="post">
        <div>
            <label for="to">받는 사람:</label>
            <input type="email" id="to" name="to" required>
        </div>
        <div>
            <label for="subject">제목:</label>
            <input type="text" id="subject" name="subject" required>
        </div>
        <div>
            <label for="body">내용:</label>
            <textarea id="body" name="body" required></textarea>
        </div>
        <button type="submit">메일 보내기</button>
    </form>
</body>
</html>