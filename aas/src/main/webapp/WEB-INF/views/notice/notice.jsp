<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #ffffff;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 {
            color: black;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .write-btn {
            display: block;
            width: 100px;
            padding: 10px;
            background-color: #007bff;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            float: right;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>공지사항</h1>
        <table>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>등록일</th>
            </tr>
            <tr>
                <td>61</td>
                <td>[마지막공지사항]</td>
                <td>admin01</td>
                <td>2022-11-06</td>
            </tr>
            <tr>
                <td>41</td>
                <td>하이</td>
                <td>admin01</td>
                <td>2022-10-17</td>
            </tr>
            <tr>
                <td>23</td>
                <td>안녕하소 글보이소</td>
                <td>admin01</td>
                <td>2022-10-17</td>
            </tr>
            <tr>
                <td>22</td>
                <td>[공지사항]테스트합니다</td>
                <td>admin01</td>
                <td>2022-10-16</td>
            </tr>
            <tr>
                <td>21</td>
                <td>관리자 테스트22</td>
                <td>admin01</td>
                <td>2022-10-16</td>
            </tr>
        </table>
        <a href="#" class="write-btn">작성하기</a>
    </div>
</body>
</html>