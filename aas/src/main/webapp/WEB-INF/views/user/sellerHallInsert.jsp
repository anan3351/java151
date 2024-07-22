<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

          <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/css/select2.min.css" rel="stylesheet" />
          <link rel="stylesheet" href="/css/template.css">

          <title>seller Page</title>
          <style>
            body {
              font-family: 'Pretendard';
              margin: 0;
              padding: 0;
              background-color: #f0f0f0;
              display: flex;
              flex-direction: column;
              min-height: 100vh;
              padding-top: 130px;
            }

            .inner-content {
              margin: 0 auto;
              width: 1170px;
              padding-block: 40px;
            }

            .header-wrap {
              width: 100%;
              position: fixed;
              z-index: 999;
              background-color: #fff;
              top: 0;
            }

            .main-container {
              display: flex;
              flex-grow: 1;
              padding: 20px;
              margin-top: 20px;
            }

            header {
              margin: 0 auto;
              width: 1600px;
              display: flex;
              justify-content: space-between;
              align-items: center;
              padding: 10px 20px;
              background-color: #fff;
              transition: all 0.3s;
            }

            header .logo img {
              display: inline-block;
              background-color: #413f3f;
              width: 250px;
              max-width: 100%;
              height: auto;
              object-fit: contain;
            }

            header .search-bar {
              position: relative;
            }

            header .search-bar input {
              border-radius: 25px;
              width: 600px;
              padding: 5px 20px;
              height: 50px;
              border: 1px solid #c5c5c5;
            }

            header .search-bar .btn-search {
              position: absolute;
              width: 20px;
              height: 20px;
              border: none;
              right: 20px;
              top: 50%;
              transform: translateY(-50%);
              background: url(/images/search.svg);
              background-repeat: no-repeat;
            }

            header .user-options a {
              margin: 0 10px;
              text-decoration: none;
              color: #000;
            }

            header .language img {
              height: 20px;
            }

            nav {
              width: 100%;
              border-top: 1px solid #ccc;
              border-bottom: 1px solid #ccc;
              padding: 10px 20px;
              display: flex;
              justify-content: center;
            }

            nav ul {
              list-style: none;
              display: flex;
              flex-direction: row;
              align-items: center;
              height: 39px;
              padding: 0;
              gap: 40px;
              border-radius: 6px;
              white-space: nowrap;
              margin: 0;
            }

            nav ul li {
              display: flex;
              align-items: center;
              height: 39px;
              font-style: normal;
              font-weight: 700;
              font-size: 16px;
              line-height: 19px;
              border-bottom: 2px solid transparent;
            }

            nav ul li a {
              text-decoration: none;
              color: #111;
              display: flex;
              align-items: center;
              justify-content: center;
              font-size: 16px;
            }

            nav ul li a:hover {
              text-decoration: none;
            }

            .swiper-container {
              max-width: 1600px;
              height: 300px;
              margin-bottom: 50px;
              padding-block: 300px;
            }

            .slider1 {
              position: relative;
              max-width: 1507px;
            }

            .slider2 {
              position: relative;
            }

            .swiper-slide {
              background: #fff;
              display: flex;
              align-items: center;
              justify-content: center;
              text-align: center;
              border: 1px solid #ccc;
              cursor: pointer;
            }

            .slider1 .swiper-slide {
              align-items: start;
            }

            .slider1 .swiper-slide img {
              max-width: 100%;
              height: 450px;
              box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
              border-radius: 10px;
            }

            .navbar-nav {
              display: flex;
              justify-content: center;
              width: 100%;
            }

            .navbar-nav>li {
              display: flex;
              align-items: center;
            }

            th {
              text-align: center;
            }

            .row.content {
              height: 450px;
            }

            .sidenav {
              padding-top: 20px;
              background-color: #f1f1f1;
              height: 100%;
            }

            footer {
              background-color: #413f3f;
              color: white;
              padding: 15px;
              width: 100%;
            }

            .centerBox {
              width: 450px;
              margin-left: auto;
              margin-right: auto;
            }

            .sidebar {
              width: 250px;
              background-color: white;
              padding: 20px;
              box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
              margin-right: 20px;
              border-radius: 10px;
              flex-shrink: 0;
              align-self: flex-start;
            }

            .profile {
              text-align: center;
              margin-bottom: 20px;
            }

            .profile-image {
              width: 80px;
              height: 80px;
              border-radius: 50%;
              background-color: #ddd;
              margin: 0 auto 10px;
            }

            .points {
              font-weight: bold;
              color: #0066cc;
            }

            .menu-section {
              margin-bottom: 20px;
            }

            .menu-title {
              font-weight: bold;
              margin-bottom: 10px;
            }

            .menu-items {
              list-style-type: none;
              padding: 0;
            }

            .menu-items li {
              margin-bottom: 5px;
            }

            .menu-items a {
              color: #666;
              text-decoration: none;
            }

            .menu-items a:hover {
              color: #0066cc;
            }

            .menu-title a {
              color: #000;
              text-decoration: none;
              display: block;
              padding: 5px 0;
              transition: color 0.3s ease;
            }

            .menu-title a:hover {
              color: #333;
            }

            .menu-title a::before {
              margin-right: 5px;
              color: #000;
            }

            main {
              flex-grow: 1;
              padding: 20px;
              background-color: white;
              border-radius: 10px;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .welcome-box {
              background-color: white;
              padding: 20px;
              text-align: center;
              border-radius: 10px;
              margin-bottom: 20px;
            }

            .heart-icon {
              font-size: 24px;
              color: #ff6b6b;
            }

            .rank-btn {
              background-color: #0066cc;
              color: white;
              border: none;
              padding: 10px 20px;
              border-radius: 5px;
              cursor: pointer;
              margin-top: 10px;
            }

            .menu-grid {
              display: grid;
              grid-template-columns: repeat(3, 1fr);
              gap: 20px;
            }

            .menu-item {
              background-color: white;
              padding: 20px;
              border-radius: 10px;
              text-align: center;
              cursor: pointer;
              border: none;
              font-size: 16px;
            }

            .icon {
              font-size: 24px;
              margin-bottom: 10px;
            }

            .menu-item p {
              margin: 5px 0;
              font-weight: bold;
            }

            .menu-item small {
              color: #666;
              font-size: 12px;
            }

            @media (max-width: 1600px) {
              header {
                width: 100%;
              }
            }

            @media (max-width: 1200px) {
              header {
                width: 100%;
                align-items: center;
                flex-direction: column;
              }

              header .search-bar {
                max-width: none;
                margin: 10px 0;
              }

              header .user-options {
                justify-content: flex-end;
              }
            }

            @media (max-width: 768px) {
              body {
                flex-direction: column;
              }

              .sidebar {
                width: auto;
                margin-right: 0;
                margin-bottom: 20px;
              }

              main {
                max-width: 100%;
              }

              .main-container {
                flex-direction: column;
              }

              header {
                padding: 10px;
              }

              header .search-bar input {
                width: 100%;
                padding: 5px 30px 5px 10px;
              }

              header .user-options {
                justify-content: center;
              }

              header .user-options a {
                margin: 5px 10px;
              }
            }

            @media (max-width: 480px) {
              header .search-bar input {
                width: 95%;
                padding: 5px 25px 5px 5px;
              }

              header .user-options {
                justify-content: center;
              }

              header .user-options a {
                margin: 5px;
              }
            }

            .select2-container--default .select2-selection--single {
              height: 38px;
              border: 1px solid #ced4da;
              border-radius: 4px;
            }

            .select2-container--default .select2-selection--single .select2-selection__rendered {
              line-height: 38px;
            }

            .select2-container--default .select2-selection--single .select2-selection__arrow {
              height: 36px;
            }

            /* 폼 스타일 */
            #sub-halls-form {
              margin-top: 20px;
              background-color: #f8f9fa;
              padding: 20px;
              border-radius: 8px;
              box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            #sub-halls-form .form-group {
              margin-bottom: 15px;
            }

            #sub-halls-form label {
              display: block;
              margin-bottom: 5px;
              font-weight: bold;
              color: #495057;
            }

            #sub-halls-form input[type="number"] {
              width: 100%;
              padding: 8px 12px;
              border: 1px solid #ced4da;
              border-radius: 4px;
              font-size: 14px;
            }

            #sub-halls-form button {
              margin-right: 10px;
              padding: 10px 20px;
              font-size: 14px;
              border-radius: 4px;
              cursor: pointer;
              transition: background-color 0.3s;
            }

            #sub-halls-form button.btn-primary {
              background-color: #007bff;
              border: none;
              color: white;
            }

            #sub-halls-form button.btn-primary:hover {
              background-color: #0056b3;
            }

            #sub-halls-form button.btn-secondary {
              background-color: #6c757d;
              border: none;
              color: white;
            }

            #sub-halls-form button.btn-secondary:hover {
              background-color: #545b62;
            }

            select#halls {
              width: 100%;
              max-width: 400px;
              padding: 10px 15px;
              font-size: 16px;
              border: 1px solid #ced4da;
              border-radius: 4px;
              background-color: #fff;
              color: #495057;
              appearance: none;
              -webkit-appearance: none;
              -moz-appearance: none;
              background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23343a40' d='M10.293 3.293L6 7.586 1.707 3.293A1 1 0 00.293 4.707l5 5a1 1 0 001.414 0l5-5a1 1 0 10-1.414-1.414z'/%3E%3C/svg%3E");
              background-repeat: no-repeat;
              background-position: right 15px center;
              background-size: 12px;
              cursor: pointer;
              transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }

            select#halls:focus {
              border-color: #80bdff;
              outline: 0;
              box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            select#halls:hover {
              border-color: #b8daff;
            }

            /* Select2와 함께 사용할 경우의 추가 스타일 */
            .select2-container--default .select2-selection--single {
              height: 44px;
              border: 1px solid #ced4da;
              border-radius: 4px;
            }

            .select2-container--default .select2-selection--single .select2-selection__rendered {
              line-height: 44px;
              padding-left: 15px;
              color: #495057;
            }

            .select2-container--default .select2-selection--single .select2-selection__arrow {
              height: 42px;
              width: 30px;
            }

            .select2-container--default .select2-results__option--highlighted[aria-selected] {
              background-color: #007bff;
            }

            .select2-container--default .select2-search--dropdown .select2-search__field {
              border: 1px solid #ced4da;
              border-radius: 4px;
            }

            .select2-dropdown {
              border: 1px solid #ced4da;
              border-radius: 4px;
            }

            .halls-select-container {
              margin-bottom: 20px;
            }

            .halls-select-container label {
              display: block;
              margin-bottom: 5px;
              font-weight: bold;
              color: #495057;
            }
          </style>
        </head>

        <body>
          <%@ include file="../header.jsp" %>
            <div class="main-container">
              <div class="sidebar">
                <div class="profile">
                  <div class="profile-image"></div>
                  <p>${userInfo.user_id} 님</p>
                  <p>회원등급 - ${userInfo.auth}</p>
                  <p>${userInfo.level_name} Level</p>
                  <p class="points">내 포인트 -
                    <fmt:formatNumber value="${userInfo.u_point}" pattern="#,###" />p
                  </p>
                </div>
                <div class="menu-section">
                  <div class="menu-title">공연</div>
                  <ul class="menu-items">
                    <li><a href="/seller/list">공연 목록</a></li>
                    <li><a href="/seller/create">공연 등록</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">공연장</div>
                  <ul class="menu-items">
                    <li><a href="/user/sellerHallInsert">공연장 등록</a></li>
                    <li><a href="#">공연장 수정</a></li>
                    <li><a href="#">대관비 관리</a></li>
                  </ul>
                </div>
                <div class="menu-section">
                  <div class="menu-title">공연장대관</div>
                  <ul class="menu-items">
                    <li><a href="#">대관 관리</a></li>
                  </ul>
                </div>
              </div>

              <main>
                <h1>공연관 대관료 등록</h1>
                <div class="form-group halls-select-container">
                  <label for="halls">공연장 선택</label>
                  <select name="halls" id="halls">
                    <c:forEach var="hall" items="${hallList}">
                      <option value="${hall.hall_id}">${hall.h_name}</option>
                    </c:forEach>
                  </select>
                </div>
                <div id="sub-options-container"></div>

              </main>
            </div>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/js/select2.min.js"></script>
            <script>
              $(document).ready(function () {
                $('#halls').select2();

                $('#halls').on('change', function () {
                  var hall_id = $(this).val();

                  // 서버로 AJAX 요청을 보내서 하위 관 정보를 가져옵니다.
                  $.ajax({
                    url: '/user/sellerHallInsert/getSubHalls',
                    type: 'GET',
                    data: { hall_id: hall_id },
                    success: function (data) {
                      // 기존의 sub-options-container를 비웁니다.
                      $('#sub-options-container').empty();

                      // 폼을 생성합니다.
                      var form = $('<form></form>').attr('id', 'sub-halls-form');

                      // 사용자 ID를 hidden input으로 추가합니다.
                      var userId = "${userInfo.user_id}";
                      form.append($('<input>').attr('type', 'hidden').attr('name', 'user_id').val(userId));

                      $.each(data, function (index, value) {
                        var formGroup = $('<div></div>').addClass('form-group');
                        formGroup.append($('<label></label>').text(value.miniHall));
                        formGroup.append($('<input>').attr('type', 'number').addClass('form-control').attr('name', 'price_' + value.hall_id).val(value.price || ''));
                        form.append(formGroup);
                      });

                      // 제출 버튼을 추가합니다.
                      form.append($('<button></button>').attr('type', 'button').addClass('btn btn-primary').text('가격등록').on('click', function () {
                        submitForm('insert');
                      }));

                      // 수정 버튼을 추가합니다.
                      form.append($('<button></button>').attr('type', 'button').addClass('btn btn-secondary').text('수정').on('click', function () {
                        submitForm('update');
                      }));

                      // sub-options-container에 폼을 추가합니다.
                      $('#sub-options-container').append(form);
                    },
                    error: function (xhr, status, error) {
                      console.error("AJAX Error: ", status, error);
                    }
                  });
                });

                function submitForm(action) {
                  var formData = $('#sub-halls-form').serializeArray();
                  var data = {
                    user_id: "${userInfo.user_id}", // 세션에서 사용자 ID를 가져옵니다.
                    halls: []
                  };

                  formData.forEach(function (item) {
                    if (item.name.startsWith('price_')) {
                      var hallId = item.name.split('_')[1]; // hall_id
                      var price = item.value;
                      if (price) {
                        data.halls.push({
                          hall_id: hallId,
                          h_day: price
                        });
                      }
                    }
                  });

                  var url = action === 'insert' ? '/user/sellerHallInsert/saveHallPrices' : '/user/sellerHallInsert/updateHallPrices';

                  $.ajax({
                    url: url,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function (response) {
                      alert(action === 'insert' ? '가격이 성공적으로 저장되었습니다.' : '가격이 성공적으로 수정되었습니다.');
                      console.log('Sending data:', JSON.stringify(data));
                    },
                    error: function (xhr, status, error) {
                      console.error("AJAX Error: ", status, error);
                      alert(action === 'insert' ? '가격 저장에 실패했습니다.' : '가격 수정에 실패했습니다.');
                      console.log('Sending data:', JSON.stringify(data));
                    }
                  });
                }

              });

            </script>
            <%@ include file="../footer.jsp" %>
        </body>

        </html>