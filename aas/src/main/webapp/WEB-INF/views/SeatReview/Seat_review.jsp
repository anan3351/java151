<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

    <div class="container">
      <div class="performance-name">공연의 이름</div>
      <hr>
      <div class="seat-location">좌석 위치</div>
      <form id="reviewForm" action="reviewResult.jsp" method="post">
      <table class="rating-table">
        <tr>
            <th>시야</th>
            <th>좌석</th>
            <th>조명</th>
            <th>음향</th>
        </tr>
        <tr>
            <td>
                <div class="stars">
                    <input type="radio" id="view5" name="view" value="5"><label for="view5">★</label>
                    <input type="radio" id="view4" name="view" value="4"><label for="view4">★</label>
                    <input type="radio" id="view3" name="view" value="3"><label for="view3">★</label>
                    <input type="radio" id="view2" name="view" value="2"><label for="view2">★</label>
                    <input type="radio" id="view1" name="view" value="1"><label for="view1">★</label>
                </div>
            </td>
            <td>
                <div class="stars">
                    <input type="radio" id="seat5" name="seat" value="5"><label for="seat5">★</label>
                    <input type="radio" id="seat4" name="seat" value="4"><label for="seat4">★</label>
                    <input type="radio" id="seat3" name="seat" value="3"><label for="seat3">★</label>
                    <input type="radio" id="seat2" name="seat" value="2"><label for="seat2">★</label>
                    <input type="radio" id="seat1" name="seat" value="1"><label for="seat1">★</label>
                </div>
            </td>
            <td>
                <div class="stars">
                    <input type="radio" id="light5" name="light" value="5"><label for="light5">★</label>
                    <input type="radio" id="light4" name="light" value="4"><label for="light4">★</label>
                    <input type="radio" id="light3" name="light" value="3"><label for="light3">★</label>
                    <input type="radio" id="light2" name="light" value="2"><label for="light2">★</label>
                    <input type="radio" id="light1" name="light" value="1"><label for="light1">★</label>
                </div>
            </td>
            <td>
                <div class="stars">
                    <input type="radio" id="sound5" name="sound" value="5"><label for="sound5">★</label>
                    <input type="radio" id="sound4" name="sound" value="4"><label for="sound4">★</label>
                    <input type="radio" id="sound3" name="sound" value="3"><label for="sound3">★</label>
                    <input type="radio" id="sound2" name="sound" value="2"><label for="sound2">★</label>
                    <input type="radio" id="sound1" name="sound" value="1"><label for="sound1">★</label>
                </div>
            </td>
        </tr>
    </table>
      <table class="review-table">
          <tr>
              <th>좌석 후기</th>
          </tr>
          <tr>
              <td><textarea rows="10"></textarea></td>
          </tr>
      </table>
      <div class="submit-button">
        <button onclick="submitReview()">후기 작성</button>
    </div>
    <input type="hidden" name="performanceName" value="공연의 이름">
      <input type="hidden" name="seatLocation" value="1층 1열 1번">
    </form>
  </div>
  
<%@ include file="../footer.jsp" %>