<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../header.jsp" %>

<style>
  .input-group {
    margin-bottom: 10px;
    text-align: left;
  }

  .add-button {
    float: right; /* 오른쪽으로 정렬 */
    margin-left: 10px; /* 버튼 간 간격 조정 */
  }

  .table-container {
    margin-top: 20px; /* 테이블과의 간격 조정 */
  }

  .btn-container {
    display: flex;
    align-items: center;
  }
</style>

<script>
  function addInput() {
    let newRow = `
      <tr>
        <td>좌석 등급</td>
        <td><input type="text" name="seat_level" class="form-control"></td>
        <td colspan="2"><button type="button" class="btn btn-danger" onclick="removeInput(this)">-</button></td>
      </tr>
      <tr>
        <td>좌석 금액</td>
        <td><input type="number" name="price" class="form-control"></td>
      </tr>
    `;
    document.getElementById('input-container').insertAdjacentHTML('beforeend', newRow);
  }

  function removeInput(button) {
    let row = button.parentNode.parentNode; // 클릭된 버튼의 부모(tr)
    let tbody = row.parentNode; // tbody 요소

    let rowsCount = tbody.getElementsByTagName('tr').length;

    // 만약 삭제하려는 행이 마지막 두 행이 아니라면 삭제하지 않음
    if (rowsCount > 2) {
      let nextRow = row.nextElementSibling;
      tbody.removeChild(row);
      if (nextRow) {
        tbody.removeChild(nextRow);
      }
    } else {
      alert('하나 이상의 좌석 등급과 금액이 필요합니다.');
    }
  }
</script>

<div style="font-size: 30px; font-weight: bold; text-align: center;">
    공연 등록
  </div><br>
  
  <form name="showfrm" id="showfrm" method="post" action="insert" enctype="multipart/form-data">
	<table class="table table-hover">
    	<tbody style="text-align: left;">
	        <tr>
	        	<td>공연명</td>
	            <td> <input type="text" name="title" class="form-control"> </td>
			</tr>
	        <tr>
	        	<td>공연장</td> <!-- 검색창 만들어서 검색해서 정보 받아오는걸로 수정 -->
	            <td> <input type="text" name="hall_id" class="form-control"> </td>
			</tr>
			<tr>
	        	<td>공연 시작일</td>
	            <td> <input type="date" name="start_day" class="form-control"> </td>
			</tr>
			<tr>
	        	<td>공연 종료일</td>
	            <td> <input type="date" name="end_day" class="form-control"> </td>
			</tr>
			<tr>
	        	<td>러닝타임</td>
	            <td> <input type="number" name="runningtime" class="form-control"> </td>
			</tr>
			<tr>
	        	<td>관람가</td>
	            <td> <input type="text" name="viewing_age" class="form-control"> </td>
			</tr>
	        <tr>
	        	<td>시놉시스</td>
	            <td> 
	            	<textarea rows="5" name="synopsis" class="form-control"></textarea>     
	            </td>
	        </tr>
	        <tr>
				<td>공지</td>
	            <td> <input type="file" name="notice_img" class="form-control"> </td>
	        </tr>
	        <tr>
				<td>할인정보</td>
	            <td> <input type="file" name="dis_img" class="form-control"> </td>
	        </tr>
	        <tr>
				<td>캐스팅</td>
	            <td> <input type="file" name="casting_img" class="form-control"> </td>
	        </tr>
	        <tr>
				<td>이벤트</td>
	            <td> <input type="file" name="event_img" class="form-control"> </td>
	        </tr>
	        <tr>
				<td>상세정보</td>
	            <td> <input type="file" name="detail_img" class="form-control"> </td>
	        </tr>
	        <tr>
				<td>포스터</td>
	            <td> <input type="file" name="poster" class="form-control"> </td>
	        </tr>
    	</tbody>
	</table><hr><br><br><br>
	
	<div style="font-size: 30px; font-weight: bold; text-align: center;">
	  좌석 금액
	</div><br>
	
	<div class="container">
	  <div class="btn-container">
	    <button type="button" class="btn btn-success add-button" onclick="addInput()">+</button>
	  </div>
	
	  <div class="table-container">
	    <table class="table table-hover">
	      <tbody id="input-container">
	        <tr>
	          <td>좌석 등급</td>
	          <td><input type="text" name="seat_level" class="form-control"></td>
	        </tr>
	        <tr>
	          <td>좌석 금액</td>
	          <td><input type="number" name="price" class="form-control"></td>
	        </tr>
	      </tbody>
	    </table>
	  </div>
	</div><hr><br>

	<tr>
		<td colspan="2" align="center">
	    	<input type="submit" value="공연 등록" class="btn btn-default" style="background-color: white; color: black;"> 
		</td>
	</tr><br><br><br><br><br>
<%-- <%@ include file="../footer.jsp" %> --%>
