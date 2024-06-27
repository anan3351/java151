<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div class="header-info">
    <h3>공연제목(프랑켄슈타인)</h3>
    <br>
    <h3>좌석위치(1층1행1번)</h3>
</div>

<div class="content">
    <div class="rating">
        <label for="rating">평점:</label>
        <div class="stars">
            <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
            <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
            <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
            <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
            <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
        </div>
    </div>

    <div class="textarea-container">
        <label for="comment">댓글 내용:</label>
        <textarea id="comment" name="comment" rows="10" cols="50"></textarea>
    </div>
</div>

<div class="button-container">
    <button onclick="submitComment()">댓글 작성 완료</button>
</div>

<script>
function submitComment() {
    var rating = document.querySelector('input[name="rating"]:checked');
    var comment = document.getElementById('comment').value;

    if (rating && comment) {
        if (confirm("후기를 정말로 남기시겠습니까?")) {
            // 여기서 서버로 데이터를 전송하는 로직을 추가할 수 있습니다.
            // 예: fetch API를 사용하여 서버에 데이터 전송

            // 임시로 seatReview.jsp로 이동
            location.href = 'seatReview.jsp';
        }
    } else {
        alert("평점과 댓글을 모두 입력해주세요.");
    }
}
</script>

<%@ include file="../footer.jsp" %>
