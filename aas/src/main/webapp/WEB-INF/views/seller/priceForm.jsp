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
            <div class="container">
                <div style="font-size: 30px; font-weight: bold; text-align: center;">
                    좌석 금액
                  </div>
                <div class="btn-container">
                  <button type="button" class="btn btn-success add-button" onclick="addSeat()">+</button>
                </div>
                <div class="table-container">
                  <table class="table table-hover">
                    <tbody id="input-container1">
                      <tr>
                        <td>주말차등가</td>
                        <td><input type="text" name="add_p" class="form-control"></td>
                      </tr>
                      <tr>
                        <td><span>* </span>좌석등급</td>
                        <td><input type="text" name="seat_level_0" class="form-control"></td>
                      </tr>
                      <tr>
                        <td><span>* </span>좌석금액</td>
                        <td><input type="number" name="seat_price_0" class="form-control"></td>
                      </tr>
                    </tbody>
                  </table>
                </div><hr><br><br>
                <input type="submit" value="공연 등록" class="btn btn-default" style="background-color: white; color: black;">
              </div>
              <br><br><br><br><br>
            </form>
        </div>
		<%@ include file="../footer.jsp" %>
	</body>
</html>
