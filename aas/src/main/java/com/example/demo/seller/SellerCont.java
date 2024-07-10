package com.example.demo.seller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SellerCont {
	@GetMapping("/user/sellerpage/create")
	public String mypage() {
		return "seller/showForm";
	}
	
	@GetMapping("/user/sellerpage/discount")
	public String mypage2() {
		return "seller/discountForm";
	}
	
}