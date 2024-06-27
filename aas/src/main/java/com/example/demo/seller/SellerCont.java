package com.example.demo.seller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SellerCont {
	@GetMapping("/{user_id}")
	public String mypage() {
		return "show/showUpdate";
	}
}
