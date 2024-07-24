<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
          <!DOCTYPE html>
          <html>

          <head>
            <meta charset="UTF-8">
            <title>main</title>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
            <link rel="stylesheet" href="/css/template.css">
            <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
            <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> -->
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

                <title>My Page</title>
                <style>
                  body {

                    margin: 0;
                    padding: 0;
                    background-color: #f0f0f0;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                    padding-top: 130px;
                    /* 헤더의 높이만큼 상단 패딩 추가 */
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
                    /* 사이드바를 상단에 맞춤 */
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
                    /* 검정색으로 변경 */
                    text-decoration: none;
                    display: block;
                    padding: 5px 0;
                    transition: color 0.3s ease;
                  }

                  .menu-title a:hover {
                    color: #333;
                    /* 호버 시 약간 밝은 검정색으로 변경 */
                  }

                  .menu-title a::before {
                    margin-right: 5px;
                    color: #000;
                    /* 불릿 포인트 색상도 검정색으로 변경 */
                  }

                  main {
                    flex-grow: 1;
                    padding: 20px;
                    background-color: white;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                  }

                  header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 10px 20px;
                    background-color: white;
                  }

                  .logo {
                    color: #0066cc;
                    font-weight: bold;
                    font-size: 24px;
                  }

                  .login {
                    color: #666;
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

                  .user-options a {
                    color: #666;
                    margin-left: 10px;
                  }

                  .user-options a:hover {
                    color: #000;
                  }

                  .search-bar input {
                    padding: 5px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                  }

                  @media (max-width: 768px) {
                    body {
                      flex-direction: column;
                      /* 화면이 좁아지면 세로로 배치 */
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

                  }
                </style>

                <style>
                  body {
                    font-family: 'Pretendard';
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
                    /* 상단 여백 추가 */
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

                  eader .logo img {
                    display: inline-block;
                    background-color: #413f3f;
                    width: 250px;
                    max-width: 100%;
                    /* 반응형을 위해 추가 */
                    height: auto;
                    /* 이미지 비율 유지 */
                    object-fit: contain;
                    /* 이미지가 영역 내에 맞게 조정 */
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
                    list-style-type: none;
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

                  /*content*/
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

                  /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
                  .row.content {
                    height: 450px
                  }

                  /* Set gray background color and 100% height */
                  .sidenav {
                    padding-top: 20px;
                    background-color: #f1f1f1;
                    height: 100%;
                  }

                  /* Set black background color, white text and some padding */
                  /* 푸터 스타일 추가 */
                  footer {
                    background-color: #413f3f;
                    color: white;
                    padding: 15px;
                    width: 100%;
                  }

                  .centerBox {
                    width: 450;
                    margin-left: auto;
                    margin-right: auto;
                  }


                  /* 반응형 스타일 */

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
                      /* 여백 조정 */
                    }
                  }

                  .membership-table th,
                  .membership-table td {
                    text-align: center;
                  }

                  .membership-table th {
                    background-color: #f9f9f9;
                  }

                  .membership-table td {
                    vertical-align: middle;
                  }

                  .selected-row {
                    background-color: #dcdcdc;
                  }

                  .button-container {
                    text-align: center;
                    margin-top: 20px;
                  }

                  .memberlogo {
                    text-align: center;
                    margin-bottom: 30px;
                  }

                  .modal {
                    display: none;
                    position: fixed;
                    z-index: 1000;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    overflow: auto;
                    background-color: rgba(0, 0, 0, 0.6);
                  }

                  .modal-content {
                    background-color: #fefefe;
                    margin: 5% auto;
                    padding: 30px;
                    border: none;
                    width: 90%;
                    max-width: 800px;
                    border-radius: 8px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                  }

                  .close {
                    color: #aaa;
                    float: right;
                    font-size: 28px;
                    font-weight: bold;
                    transition: color 0.3s ease;
                  }

                  .close:hover,
                  .close:focus {
                    color: #333;
                    text-decoration: none;
                    cursor: pointer;
                  }

                  .modal h2 {
                    margin-top: 0;
                    color: #333;
                    font-size: 24px;
                    margin-bottom: 20px;
                  }

                  .modal table {
                    width: 100%;
                    border-collapse: separate;
                    border-spacing: 0;
                    background-color: #fff;
                    border-radius: 6px;
                    overflow: hidden;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                  }

                  .modal th,
                  .modal td {
                    padding: 15px;
                    text-align: left;
                    border-bottom: 1px solid #e0e0e0;
                  }

                  .modal th {
                    background-color: #f5f5f5;
                    font-weight: bold;
                    color: #333;
                    text-transform: uppercase;
                    font-size: 14px;
                  }

                  .modal tr:last-child td {
                    border-bottom: none;
                  }

                  .modal tr:nth-child(even) {
                    background-color: #f9f9f9;
                  }

                  .modal tr:hover {
                    background-color: #f0f0f0;
                  }

                  .modal td:first-child {
                    font-weight: bold;
                    color: #0066cc;
                  }

                  @media (max-width: 768px) {
                    .modal-content {
                      width: 95%;
                      margin: 10% auto;
                      padding: 20px;
                    }

                    .modal table {
                      font-size: 14px;
                    }

                    .modal th,
                    .modal td {
                      padding: 10px;
                    }
                  }
                </style>

                <script>
                  // document.addEventListener('DOMContentLoaded', function () {
                  //   var modal = document.getElementById("rankModal");
                  //   var btn = document.querySelector(".rank-btn");
                  //   var span = document.getElementsByClassName("close")[0];

                  //   btn.onclick = function () {
                  //     modal.style.display = "block";
                  //   }

                  //   span.onclick = function () {
                  //     modal.style.display = "none";
                  //   }

                  //   window.onclick = function (event) {
                  //     if (event.target == modal) {
                  //       modal.style.display = "none";
                  //     }
                  //   }

                  // var selectedAmount = 0;

                  // // 라디오 버튼 선택 시 금액 업데이트
                  // $('input[name="membership"]').on('change', function () {
                  //   selectedMember = $(this).closest('tr').find('td').eq(1).text().replace(',', '')
                  //   selectedAmount = $(this).closest('tr').find('td').eq(4).text().replace(',', '').replace('원', '');
                  //   selectedAmount = parseInt(selectedAmount, 10); // 문자열을 숫자로 변환


                  //   // 멤버십에 따른 주문번호 설정
                  //   switch (selectedMember) {
                  //     case 'BRONZE':
                  //       orderNo = "order_no_bronze";
                  //       break;
                  //     case 'SILVER':
                  //       orderNo = "order_no_silver";
                  //       break;
                  //     case 'GOLD':
                  //       orderNo = "order_no_gold";
                  //       break;
                  //     case 'DIAMOND':
                  //       orderNo = "order_no_diamond";
                  //       break;
                  //     default:
                  //       orderNo = "order_no_default";
                  //       break;
                  //   }

                  //   console.log('Order No:', orderNo);
                  //   console.log('Selected amount:', selectedAmount);
                  // });

                  // // Payment request script
                  // $("#check_order").click(function () {
                  //   if (selectedAmount <= 0) {
                  //     alert('멤버십을 선택해주세요.');
                  //     return;
                  //   }

                  //   IMP.init('imp81610215');
                  //   IMP.request_pay({
                  //     pg: 'html5_inicis',
                  //     pay_method: 'card',
                  //     merchant_uid: orderNo, // 상점에서 관리하는 주문 번호를 전달
                  //     name: '주문명:결제테스트',
                  //     amount: selectedAmount, // 결제금액
                  //     //limitDate : selectedLimitDate, // 멤버십 유지기간
                  //     //userPoint: selectedUserPoint,  // 회원 포인트 추가
                  //     //revCoiunt: selectedrevCount,   // 예매대기 횟수
                  //     membership: selectedMember,   // 멤버십 이름
                  //     m_redirect_url: '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile
                  //   }, function (rsp) { // callback 로직
                  //     if (rsp.success) {
                  //       // 서버단에서 결제정보 조회를 위해 Fetch API로 imp_uid 전달하기
                  //       fetch("/payments/complete", {
                  //         method: 'POST',
                  //         headers: {
                  //           'Content-Type': 'application/json'
                  //         },
                  //         body: JSON.stringify({
                  //           //imp_uid: rsp.imp_uid,
                  //           membership: selectedMember
                  //           // 기타 필요한 데이터가 있으면 추가 전달
                  //         })
                  //       })
                  //         .then(response => response.json())
                  //         .then(data => {
                  //           // 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                  //           if (data.everythings_fine) {
                  //             var msg = '결제가 완료되었습니다.';
                  //             msg += '\n고유ID : ' + rsp.imp_uid;
                  //             msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                  //             msg += '\n결제 금액 : ' + rsp.paid_amount;
                  //             msg += '카드 승인번호 : ' + rsp.apply_num;

                  //             alert(msg);

                  //             // 결제 완료 후 서버에 멤버십 가입 요청
                  //             fetch("/membership/join", {
                  //               method: 'POST',
                  //               headers: {
                  //                 'Content-Type': 'application/json'
                  //               },
                  //               body: JSON.stringify({
                  //                 userId: '${sessionScope.loggedInUser.user_id}', // 세션에서 사용자 ID 가져오기
                  //                 membership: selectedMember
                  //               })
                  //             })
                  //               .then(response => response.json())
                  //               .then(data => {
                  //                 if (data.success) {
                  //                   // 멤버십 가입 성공 시 새로운 페이지로 이동
                  //                   window.location.href = '/membership/membershipComplete';
                  //                 } else {
                  //                   alert('멤버십 가입 중 오류가 발생했습니다. 고객센터에 문의해주세요.');
                  //                 }
                  //               })
                  //               .catch(error => {
                  //                 console.error('Error:', error);
                  //                 alert('서버와의 통신에 실패하였습니다. 다시 시도해 주세요.');
                  //               });
                  //           } else {
                  //             alert('결제 정보가 확인되지 않았습니다. 다시 시도해 주세요.');
                  //           }
                  //         })
                  //         .catch(error => {
                  //           console.error('Error:', error);
                  //           alert('서버와의 통신에 실패하였습니다. 다시 시도해 주세요.');
                  //         });
                  //     } else {
                  //       var msg = '결제에 실패하였습니다.';
                  //       msg += '에러내용 : ' + rsp.error_msg;

                  //       alert(msg);
                  //     }
                  //   });
                  // });
                  // // 하위 멤버십 비활성화 함수
                  // function disableLowerMemberships(selectedMember) {
                  //   switch (selectedMember) {
                  //     case 'DIAMOND':
                  //       $('input[value="GOLD"]').prop('disabled', true);
                  //       $('input[value="SILVER"]').prop('disabled', true);
                  //       $('input[value="BRONZE"]').prop('disabled', true);
                  //       break;
                  //     case 'GOLD':
                  //       $('input[value="SILVER"]').prop('disabled', true);
                  //       $('input[value="BRONZE"]').prop('disabled', true);
                  //       break;
                  //     case 'SILVER':
                  //       $('input[value="BRONZE"]').prop('disabled', true);
                  //       break;
                  //   }
                  // }
                  //});



                </script>

                <script>
                  document.addEventListener('DOMContentLoaded', function () {
                    var modal = document.getElementById("rankModal");
                    var btn = document.querySelector(".rank-btn");
                    var span = document.getElementsByClassName("close")[0];

                    btn.onclick = function () {
                      modal.style.display = "block";
                    };

                    span.onclick = function () {
                      modal.style.display = "none";
                    };

                    window.onclick = function (event) {
                      if (event.target == modal) {
                        modal.style.display = "none";
                      }
                    };

                    function getQueryParameter(name) {
                      const urlParams = new URLSearchParams(window.location.search);
                      return urlParams.get(name);
                    }

                    const userId = getQueryParameter('user_id');
                    console.log('User ID:', userId); // 디버깅을 위한 로그

                    $("#check_order").click(function () {
                      var selectedMembership = $('input[name="membership"]:checked').val();
                      console.log("선택된 멤버십: ", selectedMembership); // 디버깅 로그

                      if (!selectedMembership) {
                        alert('멤버십을 선택해주세요.');
                        return;
                      }

                      if (!userId) {
                        alert('사용자 정보가 없습니다. URL을 확인해주세요.');
                        return;
                      }

                      var membershipData = {
                        user_id: userId,
                        mb_name: selectedMembership
                      };

                      // 이미 가입된 멤버십이 있는지 확인
                      $.ajax({
                        url: '/membership/check-membership',
                        type: 'POST',
                        data: JSON.stringify(membershipData),
                        contentType: 'application/json',
                        success: function (response) {
                          console.log("서버 응답: ", response);
                          if (response) {
                            alert('이미 가입한 멤버십이 있습니다.');
                          } else {
                            var confirmation = confirm('가입하시겠습니까?');
                            if (!confirmation) {
                              return;
                            }

                            // 멤버십 가입 처리
                            $.ajax({
                              url: '/membership/join-membership',
                              type: 'POST',
                              data: JSON.stringify(membershipData),
                              contentType: 'application/json',
                              success: function (response) {
                                console.log("서버 응답: ", response);
                                alert('가입이 성공적으로 완료되었습니다.');
                                // 필요한 경우 페이지 리로드 또는 다른 작업 수행
                              },
                              error: function (xhr, status, error) {
                                console.error('AJAX 요청 오류: ', status, error);
                                console.error('서버 응답: ', xhr.responseText);
                                alert('가입 중 오류가 발생했습니다.');
                              }
                            });
                          }
                        },
                        error: function (xhr, status, error) {
                          console.error('AJAX 요청 오류: ', status, error);
                          console.error('서버 응답: ', xhr.responseText);
                          alert('가입 상태 확인 중 오류가 발생했습니다.');
                        }
                      });
                    });
                  });

                </script>
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
                      <div class="menu-title">예매 티켓</div>
                      <ul class="menu-items">
                        <li><a href="#">예매 티켓 조회</a></li>
                        <li><a href="#">예매 취소/체매매</a></li>
                        <li><a href="#">예매대기</a></li>
                      </ul>
                    </div>
                    <div class="menu-section">
                      <div class="menu-title">내 스케줄</div>
                      <ul class="menu-items">
                        <li><a href="#">스케줄 작성</a></li>
                        <li><a href="#">스케줄 수정/삭제</a></li>
                      </ul>
                    </div>
                    <div class="menu-section">
                      <div class="menu-title">즐겨찾기</div>
                      <ul class="menu-items">
                        <li><a href="#">관심배우</a></li>
                        <li><a href="#">관심공연</a></li>
                      </ul>
                    </div>
                    <div class="menu-section">
                      <div class="menu-title">나의 후기</div>
                      <ul class="menu-items">
                        <li><a href="#">좌석 후기</a></li>
                        <c:choose>
                          <c:when test="${not empty sessionScope.loggedInUser}">
                            <li><a
                                href="${pageContext.request.contextPath}/showreview/showreviewForm?user_id=${sessionScope.loggedInUser.user_id}">공연
                                후기</a></li>
                          </c:when>
                        </c:choose>
                      </ul>
                    </div>
                    <div class="menu-section">
                      <div class="menu-title"><a
                          href="${pageContext.request.contextPath}/user/mypage/hallMypage?user_id=${sessionScope.loggedInUser.user_id}">공연장
                          대관</a></div>
                    </div>
                    <div class="menu-title"><a
                        href="${pageContext.request.contextPath}/user/mypage/membership?user_id=${sessionScope.loggedInUser.user_id}">멤버십</a>
                    </div>
                    <div class="menu-section">
                      <div class="menu-title"><a
                          href="${pageContext.request.contextPath}/user/mypage/coupon?user_id=${sessionScope.loggedInUser.user_id}">보유쿠폰</a>
                      </div>
                    </div>
                    <c:if test="${userInfo.auth == 'S'}">
                      <div class="menu-section">
                        <div class="menu-title"><a href="./sellerpage">* 판매자 전용 *</a></div>
                      </div>
                    </c:if>
                  </div>

                  <main>
                    <div class="welcome-box">
                      <div class="heart-icon">❤</div>
                      <p>${userInfo.user_name}님은 현재 ${userInfo.level_name} Level입니다.</p>
                      <c:if test="${not empty mbName.mb_name}">
                        <p>${mbName.mb_name} 멤버십을 이용 중입니다.</p>
                      </c:if>
                      <button class="rank-btn">등급별 혜택보기</button>
                    </div>
                    <div class="membership">
                      <div class="memberlogo" style="align-items: center; ">
                        <img src="/images/membership.png">
                      </div>
                      <form>
                        <table class="table membership-table">
                          <thead>
                            <tr>
                              <th></th>
                              <th>멤버십명</th>
                              <th>혜택</th>
                              <th>예매대기 횟수</th>
                              <th>가입액</th>
                              <th>유지기간</th>
                              <th>포인트</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td><input type="radio" name="membership" value="BRONZE"></td>
                              <td>BRONZE</td>
                              <td>공연할인, 선예매, 티켓포장, 예매대기</td>
                              <td>5</td>
                              <td>10</td>
                              <td>365</td>
                              <td>0</td>
                            </tr>
                            <tr>
                              <td><input type="radio" name="membership" value="SILVER"></td>
                              <td>SILVER</td>
                              <td>공연할인, 선예매, 티켓포장, 예매대기, 5천원 할인쿠폰 1매</td>
                              <td>6</td>
                              <td>20</td>
                              <td>365</td>
                              <td>0</td>
                            </tr>
                            <tr>
                              <td><input type="radio" name="membership" value="GOLD"></td>
                              <td>GOLD</td>
                              <td>공연할인, 선예매, 티켓포장, 예매대기, 1만원 할인쿠폰 2매, 1만 포인트</td>
                              <td>7</td>
                              <td>30</td>
                              <td>365</td>
                              <td>10,000</td>
                            </tr>
                            <tr>
                              <td><input type="radio" name="membership" value="DIAMOND"></td>
                              <td>DIAMOND</td>
                              <td>공연할인, 선예매, 티켓포장, 예매대기, 5만원 할인쿠폰 3매, 25만 포인트</td>
                              <td>8</td>
                              <td>10</td>
                              <td>365</td>
                              <td>250,000</td>
                            </tr>
                          </tbody>
                        </table>
                        <div class="button-container">
                          <button id="check_order" type="button" class="btn btn-success btn-lg" data-toggle="modal"
                            data-target="#paymentModal">가입하기</button>
                        </div>
                      </form>
                    </div>
                    <div id="rankModal" class="modal">
                      <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>등급별 혜택</h2>
                        <table>
                          <tr>
                            <th>등급</th>
                            <th>주문 건수</th>
                            <th>주문금액</th>
                            <th>포인트 적립</th>
                          </tr>
                          <tr>
                            <td>WELCOME</td>
                            <td>0건</td>
                            <td>신규회원</td>
                            <td>-</td>
                          </tr>
                          <tr>
                            <td>FAMILY</td>
                            <td>1건 ↑</td>
                            <td>3만원 ↑</td>
                            <td>-</td>
                          </tr>
                          <tr>
                            <td>VIP</td>
                            <td>3건 ↑</td>
                            <td>30만원 ↑</td>
                            <td>1프로</td>
                          </tr>
                          <tr>
                            <td>VVIP</td>
                            <td>20건 ↑</td>
                            <td>100만원 ↑</td>
                            <td>3프로</td>
                          </tr>
                        </table>
                      </div>
                    </div>
                  </main>
                </div>
                <%@ include file="../footer.jsp" %>
          </body>

          </html>