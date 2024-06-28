package com.example.demo.join;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/join")
public class JoinCont {

	public JoinCont() {
		System.out.println("-----JoinCont() 객체생성됨");
	}//JoinCont() end
	
	@RequestMapping("/form")
	public ModelAndView joinform() {      
	        ModelAndView mav=new ModelAndView();
	        mav.setViewName("join/form");
	        return mav;        
	    }//joinform() end
	
	@RequestMapping("/login")
	public ModelAndView loginform() {      
	        ModelAndView mav=new ModelAndView();
	        mav.setViewName("join/login");
	        return mav;        
	    }//list() end
	
	
	
}//class end
