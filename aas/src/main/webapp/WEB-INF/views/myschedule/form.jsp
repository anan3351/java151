<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Form</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../view/template.css">
    <link rel="stylesheet" href="/css/template.css">
    <style>
        .header {
            margin-bottom: 0;
            position: fixed;
            top: -10;
            width: 100%;
            z-index: 1000;
        }
        body {
            padding-top: 200px;
        }
    </style>
    <script>
        function populateFields(orderDetails, selectedOrderId) {
            if (!selectedOrderId) {
                document.getElementById('title').value = '';
                document.getElementById('showdate').value = '';
                document.getElementById('seat').value = '';
                document.getElementById('fair').value = '';
                document.getElementById('poster').value = '';
                document.getElementById('sale').value = '';
                return;
            }

            var selectedOrder = orderDetails.find(order => order.order_id == selectedOrderId);

            document.getElementById('title').value = selectedOrder.order_info;
            document.getElementById('showdate').value = selectedOrder.order_date;
            document.getElementById('seat').value = selectedOrder.seat_id;
            document.getElementById('fair').value = selectedOrder.total_amount;
            document.getElementById('poster').value = ''; // This field needs to be mapped appropriately
            document.getElementById('sale').value = ''; // This field needs to be mapped appropriately
        }
    </script>
</head>
<body>
    <%@ include file="../header.jsp" %>
    <div class="main-container">
        <h1>${schedule.mysch_id == 0 ? 'New Schedule' : 'Edit Schedule'}</h1>
        <c:set var="formAction" value="${schedule.mysch_id == 0 ? '/myschedule/save' : '/myschedule/update'}" />
        <form action="${pageContext.request.contextPath}${formAction}" method="post" enctype="multipart/form-data">
            <input type="hidden" name="mysch_id" value="${schedule.mysch_id}">

            <div class="form-group">
                <label for="order_id">Order Details:</label>
                <select class="form-control" id="order_id" name="order_id" onchange="populateFields(${orderDetails}, this.value)">
                    <option value="">Select an Order</option>
                    <c:forEach var="order" items="${orderDetails}">
                        <option value="${order.order_id}">${order.order_info}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" class="form-control" id="title" name="title" value="${schedule.title}" required>
            </div>
            <div class="form-group">
                <label for="showdate">Show Date & Time:</label>
                <input type="datetime-local" class="form-control" id="showdate" name="showdate" value="${schedule.showdate}" required>
            </div>
            <div class="form-group">
                <label for="seat">Seat:</label>
                <input type="text" class="form-control" id="seat" name="seat" value="${schedule.seat}" required>
            </div>
            <div class="form-group">
                <label for="fair">Fair:</label>
                <input type="text" class="form-control" id="fair" name="fair" value="${schedule.fair}" required>
            </div>
			<div class="form-group">
			    <label for="posterFile">Poster:</label>
			    <input type="file" class="form-control" id="posterFile" name="posterFile" ${schedule.mysch_id == 0 ? 'required' : ''}>
			</div>
            <div class="form-group">
                <label for="sale">Sale:</label>
                <input type="text" class="form-control" id="sale" name="sale" value="${schedule.sale}" required>
            </div>
            <button type="submit" class="btn btn-success">${schedule.mysch_id == 0 ? 'Create' : 'Update'}</button>
        </form>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
