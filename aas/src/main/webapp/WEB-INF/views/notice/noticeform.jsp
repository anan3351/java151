<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <style> 
    /* 전체 폼 스타일링 */
#bbsfrm {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

/* 테이블 스타일링 */
.table {
  width: 100%;
  border-collapse: collapse;
}

.table th,
.table td {
  padding: 10px;
}

.table th {
  background-color: #f2f2f2;
  text-align: left;
}

/* 입력 필드 스타일링 */
.form-control {
  display: block;
  width: 100%;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.form-control:focus {
  border-color: #66afe9;
  outline: 0;
}

/* 버튼 스타일링 */
.btn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  border: 1px solid transparent;
  border-radius: 4px;
}

.btn-primary {
  color: #fff;
  background-color: #007bff;
  border-color: #007bff;
}

.btn-danger {
  color: #fff;
  background-color: #dc3545;
  border-color: #dc3545;
}

h1 {
  text-align: center;
}
</style>
</head>
<body>
    <h1>공지사항 작성</h1>
														<!-- myscript.js에 함수 작성함 -->
<form name="bbsfrm" id="bbsfrm" method="post" action="bbsIns.jsp" onsubmit="return bbsCheck()">
	<table class="table">
	<tr>
		<th class="success">제목</th>
		<td><input type="text" name="subject" id="subject" maxlength="100" required class="form-control"></td>
	</tr>
	<tr>
   		
   		<td><textarea rows="5"  class="form-control" name="content" id="content"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<input type="submit" value="새글쓰기" class="btn btn-primary">
		<input type="reset" value="취소" class="btn btn-dnager">
		</td>
	</tr>
	
	</table>
</form>
</body>
</html>