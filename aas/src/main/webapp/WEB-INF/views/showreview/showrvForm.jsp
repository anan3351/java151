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
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>공연 관람 후기 작성</h2>
    <form id="reviewForm" action="${pageContext.request.contextPath}/showreview/insert" method="post" onsubmit="return validateForm()">
        <table class="table-container">
            <tr>
                <th>공연명</th>
                <td>
                    <input type="hidden" id="show_id" name="show_id" />
                    <input type="text" id="showTitle" name="title" readonly value="공연 테이블 조인" />
                    <button type="button" class="button" onclick="openModal()">검색</button>
                </td>
            </tr>
            <tr>
                <th>관람일시</th>
                <td>
                    <input type="text" id="viewingDate" name="viewingDate" value="예매내역 테이블 조인" readonly />
                    <button type="button" class="button">검색</button>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" id="retitle" name="retitle" /></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="content" id="content" rows="10" cols="50"></textarea></td>
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
        <input type="text" id="searchInput" placeholder="공연 제목을 입력하세요" onkeyup="searchShow()">
        <table id="searchResults" class="table-container">
            <thead>
                <tr>
                    <th>공연명</th>
                    <th>장르</th>
                    <th>시작일</th>
                    <th>종료일</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
                <!-- 검색 결과가 여기 표시됨 -->
            </tbody>
        </table>
    </div>
</div>

<script>
function searchShow() {
    var keyword = document.getElementById("searchInput").value;
    if (keyword.length < 2) {
        document.getElementById("searchResults").getElementsByTagName('tbody')[0].innerHTML = "";
        return;
    }
    fetch('/searchShows?keyword=' + keyword)
        .then(response => response.json())
        .then(data => {
            var tbody = document.getElementById("searchResults").getElementsByTagName('tbody')[0];
            tbody.innerHTML = "";
            data.forEach(show => {
                var row = tbody.insertRow();
                row.innerHTML = `
                    <td>${show.title}</td>
                    <td>${show.genre}</td>
                    <td>${show.start_day}</td>
                    <td>${show.end_day}</td>
                    <td><button type="button" class="button" onclick="selectShow('${show.show_id}', '${show.title}')">선택</button></td>
                `;
            });
        });
    }

    function openModal() {
        document.getElementById("myModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }

    function selectShow(show_Id, showTitle) {
        document.getElementById("show_id").value = show_id;
        document.getElementById("showTitle").value = showTitle;
        closeModal();
    }
    
    function validateForm() {
        var show_id = document.getElementById("show_id").value;
        var viewingDate = document.getElementById("viewingDate").value;
        var retitle = document.getElementById("retitle").value;
        var content = document.getElementById("content").value;

        if (!show_id) {
            alert("공연명을 입력해주세요.");
            return false;
        }

        if (!viewingDate) {
            alert("관람일시를 입력해주세요.");
            return false;
        }

        if (!retitle) {
            alert("제목을 입력해주세요.");
            return false;
        }

        if (!content) {
            alert("내용을 입력해주세요.");
            return false;
        }


        return true;
    }
    
    
    
</script>
</body>
</html>