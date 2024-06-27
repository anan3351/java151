<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<%@ include file="./../header.jsp" %>

<!-- 본문 -->

<h3>공연장 목록</h3>
<table class="table table-hover">
	<thead>
		<tr>
			<th>공연장명</th>
			<th>공연관</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>URL</th>
			<th>좌석수</th>
		</tr>
	</thead>
	<tbody>
	<tr>
	<c:forEach items="${list}" var="hallDto" varStatus="vs">
		<td>${hallDto.h_name}</td>
		<td>miniHall</td>
		<td>addr</td>
		<td>h_call</td>
		<td>url</td>
		<td>seat</td>
	</c:forEach>
	</tr>
		<tr>
		<td colspan="6">1</td>
		</tr>
	</tbody>

</table>



<%@ include file="./../footer.jsp" %>