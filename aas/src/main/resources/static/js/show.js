document.addEventListener('DOMContentLoaded', function() {
	//이미지 4개
	var swiper1 = new Swiper('.slider1', {
		slidesPerView: 4,
		spaceBetween: 30,
		pagination: {
			el: '.swiper-pagination1',
			clickable: true,
		},
		navigation: {
			nextEl: '.swiper-button-next1',
			prevEl: '.swiper-button-prev1',
		},
		autoplay: {
			delay: 2000,
			disableOnInteraction: false,
		},
	});

	//이미지 6개
	var swiper2 = new Swiper('.slider2', {
		slidesPerView: 6,
		spaceBetween: 30,
		pagination: {
			el: '.swiper-pagination2',
			clickable: true,
		},
		navigation: {
			nextEl: '.swiper-button-next2',
			prevEl: '.swiper-button-prev2',
		},

	});
});

$(window).on('load', function () {
  slider();
})

function slider() {
  let swiper = undefined;
  let slideNum = $('.slider .swiper-slide').length // 슬라이드 총 개수
  let slideInx = 0; // 현재 슬라이드 index

  // 디바이스 체크
  let oldWChk = window.innerWidth > 767 ? 'pc' : 'mo';
  sliderAct();

  let resizeTimer;
  $(window).on('resize', function () {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(function () {
      let newWChk = window.innerWidth > 767 ? 'pc' : 'mo';
      if (newWChk != oldWChk) {
        oldWChk = newWChk;
        sliderAct();
      }
    }, 300);
  })

  // 슬라이드 실행
  function sliderAct() {
    // 슬라이드 초기화
    if (swiper != undefined) {
      swiper.destroy();
      swiper = undefined;
    }

    // slidesPerView 옵션 설정
    let viewNum = oldWChk == 'pc' ? 4 : 2;
    // loop 옵션 체크
    let loopChk = slideNum > viewNum;

    swiper = new Swiper(".slider .inner", {
      slidesPerView: "auto",
      initialSlide: slideInx,
      loop: loopChk,
      centeredSlides: true,
      autoplay: {
        delay: 3000,
        disableOnInteraction: false
      },
      navigation: {
        nextEl: '.slider .btn_next',
        prevEl: '.slider .btn_prev',
      },
      on: {
        activeIndexChange: function () {
          slideInx = this.realIndex; // 현재 슬라이드 index 갱신
        }
      },
    });
  }
}



// 공연정보 - 좌석 등급별 금액 항목 추가
let seatIndex = 0;
function addSeat() {
  seatIndex++;
  let newRow = `
    <tr>
      <td><span>* </span>좌석등급</td>
      <td><input type="text" name="seat_level_${seatIndex}" class="form-control"></td>
      <td colspan="2"><button type="button" class="btn btn-danger" onclick="removeSeat(this)">-</button></td>
    </tr>
    <tr>
      <td><span>* </span>좌석금액</td>
      <td><input type="number" name="seat_price_${seatIndex}" class="form-control"></td>
    </tr>
  `;
  document.getElementById('input-container1').insertAdjacentHTML('beforeend', newRow);
}

function removeSeat(button) {
  let row = button.parentNode.parentNode; // 클릭된 버튼의 부모(tr)
  let tbody = row.parentNode; // tbody 요소

  let nextRow = row.nextElementSibling;
  tbody.removeChild(row);
  if (nextRow) {
    tbody.removeChild(nextRow);
  }
}



// 공연정보 입력 검증
function validateForm() {
  const form = document.forms['showfrm'];
  const requiredFields = ['title', 'hall_id', 'start_day', 'end_day', 'runningtime', 'viewing_age'];
  for (let field of requiredFields) {
    if (form[field].value.trim() === '') {
      alert('필수 입력 항목을 모두 작성해 주세요.');
      form[field].focus();
      return false;
    }
  }
  
  // 날짜 검증
  const today = new Date();
  today.setHours(0, 0, 0, 0); // 오늘 날짜를 자정으로 설정하여 시간 비교에서 오류가 발생하지 않도록 함

  const startDate = new Date(form['start_day'].value);
  startDate.setHours(0, 0, 0, 0); // 공연 시작일을 자정으로 설정

  const endDate = new Date(form['end_day'].value);
  endDate.setHours(0, 0, 0, 0); // 공연 종료일을 자정으로 설정
  if (startDate <= today) {
    alert('공연 시작일은 내일 이후여야 합니다.');
    form['start_day'].focus();
    return false;
  }

  if (endDate < startDate) {
    alert('공연 종료일은 공연 시작일 이후여야 합니다.');
    form['end_day'].focus();
    return false;
  }

  // 좌석 등급과 금액 검증
  for (let i = 0; i <= seatIndex; i++) {
    const seatLevel = form[`seat_level_${i}`];
    const seatPrice = form[`seat_price_${i}`];
    if (seatLevel && seatPrice) {
      if (seatLevel.value.trim() === '' || seatPrice.value.trim() === '') {
        alert('좌석 등급과 금액을 모두 작성해 주세요.');
        if (seatLevel.value.trim() === '') {
          seatLevel.focus();
        } else {
          seatPrice.focus();
        }
        return false;
      }
    }
  }

  return true;
}


let priceIndex = 0;

function addPrice() {
  priceIndex++;
  let newRow = `
    <tr>
      <td><span>* </span>할인명</td>
      <td><input type="text" name="dis_name_${priceIndex}" class="form-control"></td>
      <td colspan="7"><button type="button" class="btn btn-danger" onclick="removePrice(this)">-</button></td>
    </tr>
    <tr>
      <td><span>* </span>현장확인</td>
      <td><input type="radio" name="check_${priceIndex}" class="form-control" value="Y">Y</td>
      <td><input type="radio" name="check_${priceIndex}" class="form-control" value="N">N</td>
      <td><input type="radio" name="check_${priceIndex}" class="form-control" value="YN">YN</td>
    </tr>
    <tr>
      <td><span>* </span>할인정보</td>
      <td><textarea name="dis_info_${priceIndex}" rows="4" cols="50"></textarea></td>
    </tr>
    <tr>
      <td><span>* </span>할인율(%)</td>
      <td><input type="number" name="dis_rate_${priceIndex}" class="form-control"></td>
    </tr>
    <tr>
      <td><span>* </span>좌석등급</td>
      <td><input type="text" name="range_${priceIndex}" class="form-control"></td>
    </tr>
    <tr>
      <td><span>* </span>적용 시작일</td>
      <td><input type="datetime-local" name="dis_start_${priceIndex}" class="form-control"></td>
    </tr>
    <tr>
      <td><span>* </span>적용 종료일</td>
      <td><input type="datetime-local" name="dis_end_${priceIndex}" class="form-control"></td>
    </tr>
  `;

  let container = document.getElementById('input-container2');
  container.insertAdjacentHTML('beforeend', `<br><br>${newRow}`);
}

function removePrice(button) {
  let row = button.parentNode.parentNode; // 클릭된 버튼의 부모(tr)
  let tbody = row.parentNode; // tbody 요소

  // 이전에 추가된 모든 <br><br> 태그를 삭제
  let prevSibling = row.previousSibling;
  while (prevSibling && prevSibling.tagName !== 'TR') {
    let toRemove = prevSibling;
    prevSibling = prevSibling.previousSibling;

    if (toRemove.tagName === 'BR') {
      tbody.removeChild(toRemove);
    }
  }

  // 현재 행(row) 및 그 다음 6개의 행 삭제 (총 7개의 행 삭제)
  for (let i = 0; i < 7; i++) {
    if (row) {
      let nextRow = row.nextElementSibling; // 다음 tr 요소
      tbody.removeChild(row); // 현재 tr 요소 삭제
      row = nextRow; // 다음 tr 요소를 현재 줄로 설정
    }
  }
}


function discount() {
	const form = document.forms['disfrm'];
	// 할인 정보 검증
	for (let i = 0; i <= priceIndex; i++) {
	  const disName = form[`dis_name_${i}`];
	  const checkRadio = form[`check_${i}`];
	  const disInfo = form[`dis_info_${i}`];
	  const disRate = form[`dis_rate_${i}`];
	  const range = form[`range_${i}`];
	  const disStart = form[`dis_start_${i}`];
	  const disEnd = form[`dis_end_${i}`];
	
	  if (
	    disName.value.trim() === '' ||
	    (!checkRadio[0].checked && !checkRadio[1].checked && !checkRadio[2].checked) ||
	    disInfo.value.trim() === '' ||
	    disRate.value.trim() === '' ||
	    range.value.trim() === '' ||
	    disStart.value.trim() === '' ||
	    disEnd.value.trim() === ''
	  ) {
	    alert('할인 정보를 모두 작성해 주세요.');
	    if (disName.value.trim() === '') {
	      disName.focus();
	    } else if (!checkRadio[0].checked && !checkRadio[1].checked && !checkRadio[2].checked) {
	      checkRadio[0].focus(); // 라디오 버튼 중 하나에 포커스
	    } else if (disInfo.value.trim() === '') {
	      disInfo.focus();
	    } else if (disRate.value.trim() === '') {
	      disRate.focus();
	    } else if (range.value.trim() === '') {
	      range.focus();
	    } else if (disStart.value.trim() === '') {
	      disStart.focus();
	    } else {
	      disEnd.focus();
	    }
	    return false;
	  }
	}
	
	
	// 할인 정보 검증
	for (let i = 0; i <= priceIndex; i++) {
	  const disStart = form[`dis_start_${i}`];
	  const disEnd = form[`dis_end_${i}`];
	
	  // 현재 날짜
	  const today = new Date();
	
	  // 할인 적용 시작일 유효성 검증
	  const startDateTime = new Date(disStart.value);
	  if (startDateTime < today) {
	    alert('시작일시는 현 시간 이후로 설정해야 합니다.');
	    disStart.focus();
	    return false;
	  }
	
	  // 할인 적용 종료일 유효성 검증
	  const endDateTime = new Date(disEnd.value);
	  if (endDateTime < startDateTime) {
	    alert('종료일시는 시작일시 이후로 설정해야 합니다.');
	    disEnd.focus();
	    return false;
	  }
	}
	
	return true;
}