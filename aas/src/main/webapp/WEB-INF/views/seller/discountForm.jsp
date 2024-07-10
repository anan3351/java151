<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>discount</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
        <link rel="stylesheet" href="../view/template.css">
        <link rel="stylesheet" href="/css/template.css">
        <link rel="stylesheet" href="/css/seller.css">
        <script src="../js/show.js"></script>
    </head>
    <body>
        <%@ include file="../header.jsp" %>
        <div class="main-container">
            <div style="font-size: 30px; font-weight: bold; text-align: center;"><br>
                할인 등록
            </div><br>

            <form name="disfrm" id="disfrm" method="post" action="dis_insert" enctype="multipart/form-data" onsubmit="return discount();">
              <div class="container" style="text-align: left; color: red; font-size:13px">* 은 필수 입력 항목입니다</div><br>
              <div class="container">
                <div class="btn-container">
                  <button type="button" class="btn btn-success add-button" onclick="addPrice()">+</button>
                </div>

                <div class="table-container">
                  <table class="table table-hover">
                    <tbody id="input-container2">
                      <tr>
                        <td><span>* </span>할인명</td>
                        <td><input type="text" name="dis_name_0" class="form-control"></td>
                      </tr>
                      <tr>
                        <td><span>* </span>현장확인</td>
                        <td><input type="radio" name="check_0" class="form-control" value="Y">Y</td>
                        <td><input type="radio" name="check_0" class="form-control" value="N">N</td>
                        <td><input type="radio" name="check_0" class="form-control" value="YN">YN</td>
                      </tr>
                      <tr>
                        <td><span>* </span>할인정보</td> 
                        <td><textarea name="dis_info_0" rows="4" cols="50"></textarea></td>
                      </tr>
                      <tr>
                        <td><span>* </span>할인율(%)</td>
                        <td><input type="number" name="dis_rate_0" class="form-control"></td>
                      </tr>
                      <tr>
                        <td><span>* </span>좌석등급</td>
                        <td><input type="text" name="range_0" class="form-control"></td>
                      </tr>
                      <tr>
                        <td><span>* </span>적용 시작일시</td>
                        <td><input type="datetime-local" name="dis_start_0" class="form-control"></td>
                      </tr>
                      <tr>
                        <td><span>* </span>적용 종료일시</td>
                        <td><input type="datetime-local" name="dis_end_0" class="form-control"></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <hr><br>

                <input type="submit" value="공연 등록" class="btn btn-default" style="background-color: white; color: black;">
                <br><br><br><br><br>
            </form>
           </div>
		</div>
	    <%@ include file="../footer.jsp" %>
    </body>
</html>
