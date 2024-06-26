package com.example.demo.show;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/show")
public class ShowCont {
	@GetMapping("/")
	public String show() {
		return "Show";
	}
}
