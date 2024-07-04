<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<head>
    <title>공연 관람 후기 작성</title>
    <meta charset="UTF-8">
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .table-container {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .table-container th, .table-container td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .button {
            padding: 10px 20px;
            border: none;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }
        .button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>공연 관람 후기 작성</h2>
    <form action="${pageContext.request.contextPath}/insert" method="post">
        <table class="table-container">
            <tr>
                <th>공연명</th>
                <td>
                    <input type="hidden" id="showId" name="show_id" />
                    <input type="text" id="showTitle" name="title" readonly value="공연 테이블 조인" />
                    <button type="button" class="button" onclick="openModal()">검색</button>
                </td>
            </tr>
            <tr>
                <th>관람일시</th>
                <td>
                    <input type="text" name="viewingDate" value="예매내역 테이블 조인" readonly />
                    <button type="button" class="button">검색</button>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="retitle" /></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" rows="10" cols="50"></textarea></td>
            </tr>
        </table>
        <div>
            <p style="color: red;">⚠ 꼭 읽어주세요</p>
            <p>게시판 운영 규정에 어긋난다고 판단되는 게시글은 사전 통보없이 블라인드 처리될 수 있습니다.</p>
            <p>티켓 매매 및 양도인 글, 기타 부적절한 글은 등록이 불가능합니다.</p>
            <p>전화번호, 이메일 등의 개인정보를 암호화 우회하여 올리지 마시기 바랍니다.</p>
        </div>
        <div>
            <button type="submit" class="button">확인</button>
            <button type="reset" class="button">취소</button>
        </div>
    </form>
</div>

<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>공연 검색</h2>
        <!-- 검색 기능 제거 -->
    </div>
</div>

<script>
    function openModal() {
        document.getElementById("myModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }

    function selectShow(showId, showTitle) {
        document.getElementById("showId").value = showId;
        document.getElementById("showTitle").value = showTitle;
        closeModal();
    }
</script>
</body>
</html>

