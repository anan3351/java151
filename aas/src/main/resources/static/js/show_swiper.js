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