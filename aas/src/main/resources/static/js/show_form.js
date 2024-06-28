let seatIndex = 0;

function addInput() {
  seatIndex++;
  let newRow = `
    <tr>
      <td><span>* </span>좌석 등급</td>
      <td><input type="text" name="seat_level_${seatIndex}" class="form-control"></td>
      <td colspan="2"><button type="button" class="btn btn-danger" onclick="removeInput(this)">-</button></td>
    </tr>
    <tr>
      <td><span>* </span>좌석 금액</td>
      <td><input type="number" name="seat_price_${seatIndex}" class="form-control"></td>
    </tr>
  `;
  document.getElementById('input-container').insertAdjacentHTML('beforeend', newRow);
}

function removeInput(button) {
  let row = button.parentNode.parentNode; // 클릭된 버튼의 부모(tr)
  let tbody = row.parentNode; // tbody 요소

  let nextRow = row.nextElementSibling;
  tbody.removeChild(row);
  if (nextRow) {
    tbody.removeChild(nextRow);
  }
}

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