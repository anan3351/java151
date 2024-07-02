<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="/css/seller.css">
<script src="../js/show.js"></script>

<div style="font-size: 30px; font-weight: bold; text-align: center;">
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
  </div>
  <hr><br>

  <input type="submit" value="공연 등록" class="btn btn-default" style="background-color: white; color: black;">
  <br><br><br><br><br>
</form>

<%-- <%@ include file="../footer.jsp" %> --%>
