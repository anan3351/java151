<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <link rel="stylesheet" href="/css/seller.css">
    <script src="/js/seller.js"></script>
    <title>Price Upload</title>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <%@ include file="./sidebar.jsp" %>
        <main>
            <br>
            <div style="font-size: 20px; font-weight: bold; text-align: center;">
                배역 등록
            </div><br>
			<form name="prifrm" id="prifrm" method="post" action="priInsert" onsubmit="return priceCheck();">
            	<div class="table-container">
            		<div style="text-align: left; color: red; font-size:13px">&nbsp;&nbsp;* 은 필수 입력 항목입니다</div>
                    <table class="table table-hover" style="width:100%">
                    	<tbody style="text-align: left;">
                        	<tr>
                            	<td><span class="sp">* </span>좌석등급</td>
                                <td><input type="text" name="seat_level" class="form-control" size=37 placeholder="ex) R석"></td>
							</tr>
                            <tr>
	                            <td><span class="sp">* </span>좌석금액</td>
	                            <td><input type="number" name="price" class="form-control"></td>
                            </tr>
                            <tr>
	                            <td>주말차등가</td>
	                            <td><input type="number" name="add_p" class="form-control" placeholder="차등가가 없다면 공란으로 제출"></td>
                            </tr>
						</tbody>
					</table>
				</div><hr>
                <input type="submit" value="등록" class="btn btn-default" style="background-color: white; color: black;">
                <br><br>
			</form>
		</main>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
