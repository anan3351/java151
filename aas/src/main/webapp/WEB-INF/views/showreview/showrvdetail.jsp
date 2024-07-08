<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>공연 관람 후기</title>
    <meta charset="UTF-8">
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .review-header {
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }
        .review-title {
            font-size: 1.5em;
            font-weight: bold;
        }
        .review-content {
            margin-top: 20px;
        }
        .review-actions {
            margin-top: 20px;
        }
        .comments {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
        .comment {
            margin-bottom: 10px;
        }
        .comment-header {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="review-header">  
        <h2 class="review-title">제목 : ${review.retitle}</h2>
        <p>작성자: ${review.user_id} | 작성일: ${review.r_date} | 조회수: ${review.viewcnt}</p>
    </div>
    <div class="review-content">
        <p>${review.content}</p>
    </div>
    <div class="review-actions">
	<button onclick="likeReview('${sessionScope.loggedInUser.user_id}', ${review.rev_id != null ? review.rev_id : '0'})"
	    ${sessionScope.loggedInUser == null || review.rev_id == null ? 'disabled' : ''}>
	    공감하기
	</button>공감수: ${review.empcnt != null ? review.empcnt : '0'}
    </div>
    <div class="comments">
        <h3>댓글</h3>
        <c:forEach var="reply" items="${replies}">
            <div class="comment">
                <div class="comment-header">${reply.user_id} | ${reply.r_date}</div>
                <div class="comment-content">${reply.content}</div>
            </div>
        </c:forEach>

		<form id="replyForm" method="post" action="${pageContext.request.contextPath}/showreview/addReply">
		    <input type="hidden" name="user_id" value="${sessionScope.loggedInUser.user_id}">
		    <input type="hidden" name="rev_id" value="${review.rev_id}">
		    <textarea name="content" placeholder="댓글을 입력하세요"></textarea>
		    <button type="submit">댓글달기</button>
		</form>
</form>
    </div>
</div>
<script>

function likeReview(user_id, rev_id) {
    if (!rev_id) {
        alert('유효하지 않은 리뷰 ID입니다.');
        return;
    }
    const params = new URLSearchParams();
    params.append('user_id', user_id);
    params.append('rev_id', rev_id);

    fetch(`${pageContext.request.contextPath}/showreview/likeReview`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    }).then(response => response.text()).then(result => {
        if (result === 'liked') {
            alert('공감했습니다!');
            location.reload();
        } else if (result === 'already_liked') {
            alert('이미 공감하셨습니다.');
        } else if (result === 'invalid_rev_id') {
            alert('유효하지 않은 리뷰 ID입니다.');
        }
    });
}

</script>

</script>
</body>
</html>