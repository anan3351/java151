package com.example.demo.actor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/actor")
public class ActorCont {
	
	public ActorCont() {
		System.out.println("-----ActorCont객체생성");
	}
	
	@GetMapping("/list")	
	public String actorlist() {
		return "actor/list";
	}//actorlist end
	
}//class end
