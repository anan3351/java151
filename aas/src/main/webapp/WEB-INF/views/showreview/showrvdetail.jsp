<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/template.css">
<%@ include file="../header.jsp" %>
<head>
    <title>공연 관람 후기</title>
    <meta charset="UTF-8">
    <style>
    .header {
        margin-bottom: 0; /* 기존 margin-bottom 값을 0으로 설정 */
        position: fixed; /* 헤더를 고정 위치로 설정 */
        top: 50; /* 상단에 고정 */
        width: 100%; /* 전체 너비를 사용 */
        z-index: 1000; /* 다른 요소보다 위에 위치 */
    }

    body {
        padding-top: 230px; /* 헤더 높이만큼 상단 패딩을 추가 */
        background-color: #f0f0f0;
        font-family: Arial, sans-serif;
        color: #333;
    }    
        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .review-header {
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
            padding-bottom: 10px;
        }
        .review-title {
            font-size: 1.8em;
            font-weight: bold;
            color: #4CAF50;
        }
        .review-content {
            margin-top: 20px;
            line-height: 1.6;
        }
        .review-actions {
            margin-top: 20px;
            display: flex;
            justify-content: flex-start;
            gap: 10px;
        }
        .review-actions button {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #4CAF50;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .review-actions .edit-button {
            background-color: #007bff;
        }
        .review-actions .edit-button:hover {
            background-color: #0056b3;
        }
        .review-actions .delete-button {
            background-color: #ff4d4d;
        }
        .review-actions .delete-button:hover {
            background-color: #ff1a1a;
        }
        .comments {
            margin-top: 20px;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }
        .comments h3 {
            color: #4CAF50;
        }
        .comment {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        .comment-header {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .comment-actions {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }
        .comment-actions button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .comment-actions .edit-button {
            background-color: #007bff;
        }
        .comment-actions .edit-button:hover {
            background-color: #0056b3;
        }
        .comment-actions .delete-button {
            background-color: #ff4d4d;
        }
        .comment-actions .delete-button:hover {
            background-color: #ff1a1a;
        }
        .comment-form {
            margin-top: 20px;
        }
        .comment-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            resize: vertical;
        }
        .comment-form button {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #4CAF50;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .comment-form button:hover {
            background-color: #45a049;
        }
        #editReviewForm, #editReplyForm {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        #editReviewForm input[type="text"],
        #editReviewForm textarea,
        #editReplyForm textarea {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            resize: vertical;
        }
        #editReviewForm button,
        #editReplyForm button {
            margin-top: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #4CAF50;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        #editReviewForm button:hover,
        #editReplyForm button:hover {
            background-color: #45a049;
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
        <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.user_id == review.user_id}">
            <button class="edit-button" onclick="showEditReviewForm(${review.rev_id}, '${review.retitle}', '${review.content}')">수정</button>
            <button class="delete-button" onclick="deleteReview(${review.rev_id})">삭제</button>
        </c:if>
        <button onclick="likeReview('${sessionScope.loggedInUser.user_id}', ${review.rev_id != null ? review.rev_id : '0'})"
            ${sessionScope.loggedInUser == null || review.rev_id == null ? 'disabled' : ''}>
            공감하기
        </button> 공감수: ${review.empcnt != null ? review.empcnt : '0'}
    </div>
    
    <!-- 리뷰 수정 폼 (숨김 상태로 시작) -->
    <div id="editReviewForm">
        <form method="post" action="${pageContext.request.contextPath}/showreview/updateReview">
            <input type="hidden" name="rev_id" id="editReviewId">
            <input type="text" name="retitle" id="editReviewTitle" placeholder="제목">
            <textarea name="content" id="editReviewContent" placeholder="내용"></textarea>
            <button type="submit">수정하기</button>
            <button type="button" onclick="cancelEditReview()">취소</button>
        </form>
    </div>
    
    <div class="comments">
        <h3>댓글</h3>
        <c:forEach var="reply" items="${replies}">
            <div class="comment">
                <div class="comment-header">${reply.user_id} | ${reply.r_date}</div>
                <div class="comment-content">${reply.content}</div>
                <c:if test="${sessionScope.loggedInUser != null && sessionScope.loggedInUser.user_id == reply.user_id}">
                    <div class="comment-actions">
                        <button class="edit-button" onclick="editReply(${reply.reply_id}, '${reply.content}')">수정</button>
                        <button class="delete-button" onclick="deleteReply(${reply.reply_id}, ${review.rev_id})">삭제</button>
                    </div>
                </c:if>
            </div>
        </c:forEach>

        <!-- 댓글 수정 폼 (숨김 상태로 시작) -->
        <div id="editReplyForm">
            <form method="post" action="${pageContext.request.contextPath}/showreview/updateReply">
                <input type="hidden" name="reply_id" id="editReplyId">
                <input type="hidden" name="rev_id" value="${review.rev_id}">
                <textarea name="content" id="editReplyContent" placeholder="내용"></textarea>
                <button type="submit">수정하기</button>
                <button type="button" onclick="cancelEditReply()">취소</button>
            </form>
        </div>
        
        <!-- 댓글 작성 폼 -->
        <c:if test="${sessionScope.loggedInUser != null}">
            <div class="comment-form">
                <form id="replyForm" method="post" action="${pageContext.request.contextPath}/showreview/addReply">
                    <input type="hidden" name="user_id" value="${sessionScope.loggedInUser.user_id}">
                    <input type="hidden" name="rev_id" value="${review.rev_id}">
                    <textarea name="content" placeholder="댓글을 입력하세요"></textarea>
                    <button type="submit">댓글달기</button>
                </form>
            </div>
        </c:if>
        <c:if test="${sessionScope.loggedInUser == null}">
            <p>로그인 후 댓글을 작성할 수 있습니다.</p>
        </c:if>
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

function showEditReviewForm(rev_id, retitle, content) {
    document.getElementById('editReviewId').value = rev_id;
    document.getElementById('editReviewTitle').value = retitle;
    document.getElementById('editReviewContent').value = content;
    document.getElementById('editReviewForm').style.display = 'block';
}

function cancelEditReview() {
    document.getElementById('editReviewForm').style.display = 'none';
}

function deleteReview(rev_id) {
    if (confirm('정말 삭제하시겠습니까?')) {
        fetch(`${pageContext.request.contextPath}/showreview/deleteReview`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ rev_id: rev_id })
        }).then(response => response.text()).then(result => {
            if (result === 'success') {
            	alert('삭제에 성공하였습니다.')
                location.href = `${pageContext.request.contextPath}/showreview`;
            } else if (result === 'unauthorized') {
                alert('리뷰를 삭제할 권한이 없습니다.');
            } else {
                alert('삭제에 실패했습니다.');
            }
        });
    }
}

function editReply(reply_id, content) {
    document.getElementById('editReplyId').value = reply_id;
    document.getElementById('editReplyContent').value = content;
    document.getElementById('editReplyForm').style.display = 'block';
}

function cancelEditReply() {
    document.getElementById('editReplyForm').style.display = 'none';
}

function deleteReply(reply_id, rev_id) {
    if (confirm('정말 삭제하시겠습니까?')) {
        fetch(`${pageContext.request.contextPath}/showreview/deleteReply`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ reply_id: reply_id, rev_id: rev_id })
        }).then(response => {
            if (response.ok) {
                location.reload();
            } else {
                alert('삭제에 실패했습니다.');
            }
        });
    }
}
</script>
</body>
<%@ include file="../footer.jsp" %>
</html>
