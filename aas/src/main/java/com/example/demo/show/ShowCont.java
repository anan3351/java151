package com.example.demo.show;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ShowCont {
	
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	// 뮤지컬 목록
	@GetMapping("/musical")
	public String musical() {
		return "show/musical";
	}
	
	
	// 뮤지컬 상세페이지
	@GetMapping("/musical/detail")
	public String musical_detail() {
		return "";
	}
	
	
	
	// 연극 목록
	@GetMapping("/play")
	public String play() {
		return "show/play";
	}
		
	// 연극 상세페이지
	@GetMapping("/play/detail")
	public String play_detail() {
		return "";
	}
}
