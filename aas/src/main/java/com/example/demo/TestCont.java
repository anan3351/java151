package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestCont {
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	@GetMapping("/tem")
	public String tem() {
		return "template";
	}

}//class end
