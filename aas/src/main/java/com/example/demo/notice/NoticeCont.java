package com.example.demo.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/notice")
public class NoticeCont {
	public NoticeCont() {
		System.out.println("-----NoticeCont() 객체생성됨");
	}//NoticeCont() end

	@RequestMapping("/notice")
	public ModelAndView notice() {      
	        ModelAndView mav=new ModelAndView();
	        mav.setViewName("notice/notice");
	        return mav;        
	    }//notice() end
	
	@RequestMapping("/noticeform")
	public ModelAndView noticeform() {      
	        ModelAndView mav=new ModelAndView();
	        mav.setViewName("notice/noticeform");
	        return mav;        
	    }//noticeform() end
}//class end
