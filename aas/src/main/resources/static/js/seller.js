/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 공연 등록 모달
function hallSearch() {
    let modal = document.getElementById('hallSearchModal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'hallSearchModal';
        modal.className = 'modal';
        document.body.appendChild(modal);
    }

    let modalContent = document.createElement('div');
    modalContent.className = 'modal-content';
    modal.innerHTML = '';
    modal.appendChild(modalContent);

    // 초기 검색 폼 로드
    fetch('/seller/hallSearch')
        .then(response => response.text())
        .then(data => {
            modalContent.innerHTML = data;
            modal.style.display = 'block';

            // 모달 내부에서 페이징 링크 초기화
            setupPagination();
        })
        .catch(error => {
            console.error('오류 발생:', error);
            modalContent.innerHTML = '<p>오류가 발생했습니다: ' + error.message + '</p>';
            modal.style.display = 'block';
        });
}

// hallSearch.jsp -> hallList.jsp
function performSearch() {
    let h_name = document.getElementById("h_name").value; // 검색어 조회
    let page = 0; // 초기 페이지 값
    loadSearchResults(h_name, page); // 검색결과 로드
    return false;
}


// 페이징 관련
function setupPagination() {
	document.querySelectorAll('.pagination a').forEach(link => {
		link.addEventListener('click', function(e) {
			e.preventDefault(); // 페이지 이동 막음
			let h_name = document.getElementById("h_name").value;
			let page = this.getAttribute('data-page'); // 클릭된 페이지의 data-page의 값을 가져옴
			loadSearchResults(h_name, page);
		});
	});
}

function loadSearchResults(h_name, page) {
    fetch(`/seller/hallList?h_name=${encodeURIComponent(h_name)}&page=${page}`) // encodeURIComponent : 문자열 인코딩
        .then(response => response.text()) // 응답을 텍스트로 변환
        .then(data => {
            document.getElementById('searchResults').innerHTML = data;
            setupPagination();
        })
        .catch(error => {
            console.error('오류 발생:', error);
        });
}


function selectHall() {
    let selectedRadio = document.querySelector('input[name="selected_hall"]:checked');
    if (selectedRadio) {
        let hallId = selectedRadio.value;
        window.parent.document.querySelector('input[name="hall_id"]').value = hallId;
        window.parent.closeModal();
    } else {
        alert("공연장을 선택해 주세요.");
    }
}

function closeModal() {
    let modal = document.getElementById('hallSearchModal');
    if (modal) {
        modal.style.display = 'none';
    } else {
        let parentModal = window.parent.document.getElementById('hallSearchModal');
        if (parentModal) {
            parentModal.style.display = 'none';
        }
    }
    let iframe = document.querySelector('iframe');
    if (iframe) {
        iframe.parentNode.removeChild(iframe);
    }
}


// 공연상세 - 할인 적용금액 모달창
function priceList(show_id) {
    let modal = document.getElementById('priceListModal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'priceListModal';
        modal.className = 'modal';
        document.body.appendChild(modal);
    }

    let modalContent = document.createElement('div');
    modalContent.className = 'modal-content';
    modal.innerHTML = '';
    modal.appendChild(modalContent);

    // 초기 검색 폼 로드
    fetch(`/seller/detail/allPrice?show_id=${show_id}`)
        .then(response => response.text())
        .then(data => {
            modalContent.innerHTML = data;
            modal.style.display = 'block';

            // 모달 내부에서 페이징 링크 초기화
            setupPagination();
        })
        .catch(error => {
            console.error('오류 발생:', error);
            modalContent.innerHTML = '<p>오류가 발생했습니다: ' + error.message + '</p>';
            modal.style.display = 'block';
        });
}


function priceList2(show_id) {
    let modal = document.getElementById('priceListModal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'priceListModal';
        modal.className = 'modal';
        document.body.appendChild(modal);
    }

    let modalContent = document.createElement('div');
    modalContent.className = 'modal-content';
    modal.innerHTML = '';
    modal.appendChild(modalContent);

    // 초기 검색 폼 로드
    fetch(`/allPrice?show_id=${show_id}`)
        .then(response => response.text())
        .then(data => {
            modalContent.innerHTML = data;
            modal.style.display = 'block';

            // 모달 내부에서 페이징 링크 초기화
            setupPagination();
        })
        .catch(error => {
            console.error('오류 발생:', error);
            modalContent.innerHTML = '<p>오류가 발생했습니다: ' + error.message + '</p>';
            modal.style.display = 'block';
        });
}



function closePrice() {
    let modal = document.getElementById('priceListModal');
    if (modal) {
        modal.style.display = 'none';
    } else {
        let parentModal = window.parent.document.getElementById('priceListModal');
        if (parentModal) {
            parentModal.style.display = 'none';
        }
    }
    let iframe = document.querySelector('iframe');
    if (iframe) {
        iframe.parentNode.removeChild(iframe);
    }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function actorSearch() {
    let modal = document.getElementById('actorSearchModal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'actorSearchModal';
        modal.className = 'modal';
        modal.style.display = 'none'; // 기본적으로 모달을 숨김
        document.body.appendChild(modal);
    }

    let modalContent = document.createElement('div');
    modalContent.className = 'modal-content';
    modal.innerHTML = '';
    modal.appendChild(modalContent);

    fetch('/seller/actorSearch')
        .then(response => response.text())
        .then(data => {
            modalContent.innerHTML = data;
            modal.style.display = 'block';
            actSetupPagination();
        })
        .catch(error => {
        console.error('오류 발생:', error);
        modalContent.innerHTML = '<p>오류가 발생했습니다: ' + error.message + '</p>';
        modal.style.display = 'block';
    })
    .finally(() => {
        reapplyStyles(); // 모달 열린 후 스타일 재적용
    });
}

// actorSearch.jsp -> actorList.jsp
function actPerformSearch() {
    let h_name = document.getElementById("a_name").value.trim(); // 검색어 조회
    let page = 0; // 초기 페이지 값
    actLoadSearchResults(h_name, page); // 검색결과 로드
    return false;
}

// 페이징 관련
function actSetupPagination() {
    document.querySelectorAll('.pagination a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            let h_name = document.getElementById("a_name").value.trim();
            let page = this.getAttribute('data-page');
            actLoadSearchResults(h_name, page);
        });
    });
}

function actLoadSearchResults(a_name, page) {
    fetch(`/seller/actorList?a_name=${encodeURIComponent(a_name)}&page=${page}`)
        .then(response => response.text())
        .then(data => {
            document.getElementById('actSearchResults').innerHTML = data;
            actSetupPagination();
            reapplyStyles(); // 스타일을 다시 적용
        })
        .catch(error => {
            console.error('오류 발생:', error);
        });
}

// 스타일을 다시 적용하는 새로운 함수
function reapplyStyles() {
    document.querySelectorAll('.role-choice').forEach(el => {
        el.style.cssText = 'display: inline-block !important; width: 100px !important; height: 30px !important; vertical-align: middle !important;';
    });

    document.querySelectorAll('.role-radio').forEach(el => {
        el.style.cssText = 'width: 10px !important; height: 10px !important; margin-right: 5px !important;';
    });
}

function selectActor() {
    let selectedRadio = document.querySelector('input[name="selected_actor"]:checked');
    if (selectedRadio) {
        let actorId = selectedRadio.value;
        let parentDocument = window.parent.document;
        let actorInput = parentDocument.querySelector('input[name="actorId"]');
        if (actorInput) {
            actorInput.value = actorId;
        }
        closeActModal(); // 모달을 닫기
        setTimeout(reapplyStyles, 100); // 약간의 지연 후 스타일 재적용
    } else {
        alert("배우를 선택해 주세요.");
    }
}

function closeActModal() {
    let modal = document.getElementById('actorSearchModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

function roleCheck() {
    const form = document.forms['rolefrm'];

    // 배역 선택 확인
    const castingRadio = form['casting'];
    let roleSelected = false;
    if (castingRadio.length) {
        for (let i = 0; i < castingRadio.length; i++) {
            if (castingRadio[i].checked) {
                roleSelected = true;
                break;
            }
        }
    } else if (castingRadio.checked) {
        roleSelected = true;
    }
    if (!roleSelected) {
        alert('배역을 선택해 주세요.');
        return false;
    }

    // 배우 입력 확인
    const actorId2 = form['actorId'];
    if (actorId2.value.trim() === '') {
        alert('배우를 선택해 주세요.');
        actorId2.focus();
        return false;
    }

    return true;
}


// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    let hallModal = document.getElementById('hallSearchModal');
    let priceModal = document.getElementById('priceListModal');
    let actModal = document.getElementById('actorSearchModal');

    // hallSearchModal 외부 클릭 시 닫기
    if (hallModal && event.target === hallModal) {
        closeModal();
    }

    // priceListModal 외부 클릭 시 닫기
    if (priceModal && event.target === priceModal) {
        closePrice();
    }

    // actorSearchModal 외부 클릭 시 닫기
    if (actModal && event.target === actModal) {
        closeActModal();
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 공연정보 입력 검증
function validateShow() {
	const form = document.forms['showfrm'];
	const requiredFields = ['title', 'hall_id', 'start_day', 'end_day', 'runningtime', 'viewing_age', 'c_role'];
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
	return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function priceCheck() {
    const form = document.forms['prifrm'];

    // 좌석등급
    const seatLevel = form['seat_level'];
    if (seatLevel.value.trim() === '') {
        alert('좌석등급을 입력해 주세요.');
        seatLevel.focus();
        return false;
    }
    
    // 좌석금액
    const price = form['price'];
	if (price.value.trim() === '') {
		alert('좌석금액을 입력해 주세요.');
		price.focus();
		return false;
	}
    
    return true;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function discount2() {
    var checkboxes = document.querySelectorAll('input[name="dis_range_checkbox"]:checked');
    var values = [];
    checkboxes.forEach(function(checkbox) {
        values.push(checkbox.value);
    });
    document.getElementById('dis_range').value = values.join(',');
    return true; // 폼 제출을 계속하기 위해 true를 반환
}

function discount() {
    const form = document.forms['disfrm'];

    // 할인명
    const disName = form['dis_name'];
    if (disName.value.trim() === '') {
        alert('할인명을 입력해 주세요.');
        disName.focus();
        return false;
    }

    discount2();
    const range = form['dis_range'];
    if (range.value.trim() === '') {
        alert('좌석등급을 입력해 주세요.');
        return false;
    }

    // 할인율
    const disRate = form['dis_rate'];
    if (disRate.value.trim() === '') {
        alert('할인율을 입력해 주세요.');
        disRate.focus();
        return false;
    }

    // 할인정보
    const disInfo = form['dis_info'];
    if (disInfo.value.trim() === '') {
        alert('할인정보를 입력해 주세요.');
        disInfo.focus();
        return false;
    }

    // 적용 시작일시
    const disStart = form['dis_start'];
    if (disStart.value.trim() === '') {
        alert('적용 시작일시를 선택해 주세요.');
        disStart.focus();
        return false;
    }

    // 적용 종료일시
    const disEnd = form['dis_end'];
    if (disEnd.value.trim() === '') {
        alert('적용 종료일시를 선택해 주세요.');
        disEnd.focus();
        return false;
    }

    // 현장확인
    const checkSelect = form['dis_check'];
    if (checkSelect.value.trim() === '') {
        alert('현장확인 여부를 선택해 주세요.');
        checkSelect.focus();
        return false;
    }

    // 날짜 및 시간 유효성 검증
    const startDateTime = new Date(disStart.value);
    const endDateTime = new Date(disEnd.value);

    if (endDateTime < startDateTime) {
        alert('종료일시는 시작일시 이후로 설정해야 합니다.');
        disEnd.focus();
        return false;
    }

    return true;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 할인정보 삭제
function deleteDiscount(dis_id) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		$.ajax({
			type: "POST",
			url: "../" + dis_id + "/disDelete", // 컨트롤러 매핑 주소
			success: function(data) {
				location.reload();
			},
			error: function() {
				alert('삭제 실패');
			}
		});
	}
}

// 좌석금액 삭제
function deletePrice(price_id) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		$.ajax({
			type: "POST",
			url: "../" + price_id + "/priDelete", // 컨트롤러 매핑 주소
			success: function(data) {
				location.reload();
			},
			error: function() {
				alert('삭제 실패');
			}
		});
	}
}

// 배역-배우 삭제
function deleteRole(actor_id, show_id) {
    if (confirm("정말로 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
        $.ajax({
            type: "POST",
            url: "/seller/detail/" + show_id + "/roleDelete",
            data: { actor_id: actor_id }, // actor_id를 데이터로 포함
            success: function(data) {
                location.reload();
            },
            error: function() {
                alert('삭제 실패');
            }
        });
    }
}

// 공연 삭제
function showDelete(show_id) {
    if (confirm("정말로 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
        $.ajax({
            type: "POST",
            url: "/seller/detail/" + show_id + "/showDelete",
            data: {},
            success: function(response) {
                // 서버 응답에 따라 적절히 처리
                location.reload(); // 페이지를 새로 고쳐서 삭제된 내용을 반영
            },
            error: function() {
                alert('삭제 실패');
            }
        });
    }
}
