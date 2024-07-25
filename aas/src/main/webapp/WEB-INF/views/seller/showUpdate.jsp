<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/css/template.css">
    <link rel="stylesheet" href="/css/seller.css">
    <script src="/js/seller.js"></script>
    <title>공연 수정</title>
    <script>
    function deleteFile(inputId, fileName, showId, fileType) {
        var input = document.getElementById(inputId);
        var fileNameElement = document.getElementById(fileName);

        // 파일 입력 필드를 초기화
        input.value = '';

        // 파일 삭제 요청을 위한 URL 생성
        var deleteUrl = `/seller/detail/${showId}/fileDelete`;

        // POST 요청을 위한 데이터 설정
        var data = new FormData();
        data.append('fileType', fileType); // 컬럼명
        data.append('fileName', fileName); // 데이터
        alert(fileType)
        alert(fileName)

        // 파일 삭제 요청
        fetch(deleteUrl, {
            method: 'POST',
            body: data
        })
        .then(response => {
            if (response.ok) {
                // 페이지 새로 고침 또는 적절한 조치
                window.location.href = `/seller/detail/${showId}/showUpdate`;
            } else {
                if (fileNameElement) fileNameElement.style.display = 'block';
                alert('파일 삭제에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('파일 삭제 중 오류 발생:', error);
            if (fileNameElement) fileNameElement.style.display = 'block';
            alert('파일 삭제 중 오류가 발생했습니다.');
        });
    }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <%@ include file="./sidebar.jsp" %>
        <main>
            <br>
            <div style="font-size: 20px; font-weight: bold; text-align: center;">
                공연 수정
            </div><br><br>
            <form name="showfrm" id="showfrm" method="post" action="showUpdate" enctype="multipart/form-data" onsubmit="return validateShow();">
                <div style="text-align: left; color: red; font-size:13px">
                    &nbsp;&nbsp;* 은 필수 입력 항목입니다<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;공연 등록 후, 목록에서 상세정보를 추가하세요. (배역, 할인율, 좌석별 금액..)
                </div>
                <table class="table table-hover" style="width:100%">
                    <tbody style="text-align: left;">
                        <tr>
                            <td><span class="sp">* </span>공연명</td>
                            <td><input type="text" name="title" class="form-control" value="${data.title}"></td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>장르</td>
                            <td><input type="text" name="genre" class="form-control" placeholder="연극/뮤지컬" value="${data.genre}"></td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>공연장</td>
                            <td><input type="text" name="hall_id" class="form-control" value="${data.hall_id}" readonly></td>
                            <td><input type="button" class="btn btn-default" id="hall_search" value="검색" onclick="hallSearch()"></td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>공연 시작일</td>
                            <td>
                                <input type="date" name="start_day" class="form-control"
                                       value="${empty data.start_day ? now : fn:substring(data.start_day, 0, 10)}">
                            </td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>공연 종료일</td>
                            <td>
                                <input type="date" name="end_day" class="form-control"
                                       value="${empty data.end_day ? now : fn:substring(data.end_day, 0, 10)}">
                            </td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>러닝타임</td>
                            <td><input type="text" name="runningtime" class="form-control" placeholder="~시간 ~분" value="${data.runningtime}"></td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>관람가</td>
                            <td><input type="text" name="viewing_age" class="form-control" placeholder="만 ~세 이상" value="${data.viewing_age}"></td>
                        </tr>
                        <tr>
                            <td><span class="sp">* </span>배역</td>
                            <td><input type="text" name="c_role" class="form-control" placeholder="지킬, 하이드, 엠마, ..." value="${data.c_role}"></td>
                        </tr>

                        <!-- 이미지 관련 부분 반복 출력 -->
                        <c:forEach var="entry" items="${imgMap}">
                            <tr>
                                <td>${fn:replace(entry.key, "_", " ")}</td>
                                <td>
                                    <input type="file" id="${entry.key}" name="${entry.key}" class="form-control">
                                    <c:choose>
                                        <c:when test="${not empty entry.value}">
                                            <c:forEach var="fileName" items="${entry.value}">
                                                <p id="${entry.key}">현재 파일: ${fileName}
                                                    <span style="color: red; cursor: pointer;"
                                                          onclick="deleteFile('${entry.key}', '${fileName}', '${data.show_id}', '${entry.key}')">x</span>
                                                </p>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <p id="${entry.key}">현재 파일 없음</p>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>


                    </tbody>
                </table>
                <hr>
                <input type="submit" value="공연 수정" class="btn btn-default">
            </form>
            <br>
        </main>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
