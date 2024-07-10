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


