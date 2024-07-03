package com.example.demo.showreview;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("")
public class ShowreviewCont {
	public ShowreviewCont() {
		System.out.println("-----ShowreviewCont 객체 생성");
	}
	
	@RequestMapping("/showreview")
	public ModelAndView showrvForm () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("showreview/showrvForm");
		return mav;
	}
}//class end
