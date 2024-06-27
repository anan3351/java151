package com.example.demo.seat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SeatCont {
	
	@GetMapping("/seat")
	public String seatReview() {
		return "seatReview";
	}//end
	
}//class end
