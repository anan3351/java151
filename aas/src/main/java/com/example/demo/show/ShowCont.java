package com.example.demo.show;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ShowCont {
	
	@GetMapping("/")
	public String main() {
		return "main";
	}
	
	// 뮤지컬 목록
	@GetMapping("/musical")
	public ModelAndView musical() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("show/musical");
		return mav;
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



	
	/*
    @GetMapping("/searchShows")
    @ResponseBody
    public List<ShowDTO> searchShows(@RequestParam("keyword") String keyword) {
        return showDAO.searchShows(keyword);
    } 
*/

}
