package com.example.join;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/join")
public class JoinCont {

	public JoinCont() {
		System.out.println("-----JoinCont() 객체생성됨");
	}//JoinCont() end
	
	
	
}//class end
