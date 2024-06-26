package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class TestCont {
	@GetMapping("/")
	public String hello() {
		return "Main";
	}
	
	@GetMapping("/tem")
	public String tem() {
		return "Template";
	}
	
	@GetMapping("/seat_review")
	public String seat_review() {
		return "Seat_review";
	}
	
	
}//class end
