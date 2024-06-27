package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class test {
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	@GetMapping("/tem")
	public String tem() {
		return "template";
	}
	
	@GetMapping("/SeatReviewForm")
	public String seatreviewfrom() {
		return "SeatReviewForm";
	}
	
	
}//class end
