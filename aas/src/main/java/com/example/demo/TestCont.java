package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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

}//class end
