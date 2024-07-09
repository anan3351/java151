<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.jsp" %>

  <div style="font-size: 30px; font-weight: bold; text-align: center;">
    HOT&#128293;
  </div><br>
  
<%@ include file="../footer.jsp" %>
<link rel="stylesheet" href="/css/seller.css">
<script src="../js/show.js"></script>

<div style="font-size: 30px; font-weight: bold; text-align: center;">
  공연 등록
</div><br>
  
<form name="showfrm" id="showfrm" method="post" action="show_insert" enctype="multipart/form-data" onsubmit="return validateForm();">
  <div class="container" style="text-align: left; color: red; font-size:13px">* 은 필수 입력 항목입니다</div>
  <table class="table table-hover">
    <tbody style="text-align: left;">
      <tr>
        <td><span>* </span>공연명</td>
        <td><input type="text" name="title" class="form-control"></td>
      </tr>
      <tr>
        <td><span>* </span>공연장</td> <!-- 검색창 만들어서 검색해서 정보 받아오는걸로 수정 -->
        <td><input type="text" name="hall_id" class="form-control"></td>
      </tr>
      <tr>
        <td><span>* </span>공연 시작일</td>
        <td><input type="date" name="start_day" class="form-control"></td>
      </tr>
      <tr>
        <td><span>* </span>공연 종료일</td>
        <td><input type="date" name="end_day" class="form-control"></td>
      </tr>
      <tr>
        <td><span>* </span>러닝타임</td>
        <td><input type="number" name="runningtime" class="form-control"></td>
      </tr>
      <tr>
        <td><span>* </span>관람가</td>
        <td><input type="text" name="viewing_age" class="form-control"></td>
      </tr>
      <tr>
        <td>시놉시스</td>
        <td>
          <textarea rows="5" name="synopsis" class="form-control"></textarea>
        </td>
      </tr>
      <tr>
        <td>공지</td>
        <td><input type="file" name="notice_img" class="form-control"></td>
      </tr>
      <tr>
        <td>할인정보</td>
        <td><input type="file" name="dis_img" class="form-control"></td>
      </tr>
      <tr>
        <td>캐스팅</td>
        <td><input type="file" name="casting_img" class="form-control"></td>
      </tr>
      <tr>
        <td>이벤트</td>
        <td><input type="file" name="event_img" class="form-control"></td>
      </tr>
      <tr>
        <td>상세정보</td>
        <td><input type="file" name="detail_img" class="form-control"></td>
      </tr>
      <tr>
        <td>포스터</td>
        <td><input type="file" name="poster" class="form-control"></td>
      </tr>
    </tbody>
  </table>
  <hr><br><br>

  <div style="font-size: 30px; font-weight: bold; text-align: center;">
    좌석 금액
  </div>

  <div class="container">
    <div class="btn-container">
      <button type="button" class="btn btn-success add-button" onclick="addSeat()">+</button>
    </div>

    <div class="table-container">
      <table class="table table-hover">
        <tbody id="input-container1">
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
    </div>
  </div>
  <hr><br><br>

  <input type="submit" value="공연 등록" class="btn btn-default" style="background-color: white; color: black;">
  <br><br><br><br><br>
</form>

<%-- <%@ include file="../footer.jsp" %> --%>

