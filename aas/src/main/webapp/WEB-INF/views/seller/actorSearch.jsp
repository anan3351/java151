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
	    <title>Actor Search</title>
	</head>
	<body>
		<div class="modal-header">
		    <span class="close" onclick="closeActModal()">&times;</span>
		    <h3>배우 검색</h3>
		</div>
		<div class="modal-body">
		    <form onsubmit="return actPerformSearch()">
		        <input type="text" name="a_name" id="a_name" placeholder="배우 이름을 입력하세요" autofocus>
		        <input type="submit" class="btn btn-default" value="검색">
		    </form>
		    <div id="actSearchResults"></div>
		</div>
	</body>
</html>