package com.example.demo.hall;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HallCont {
	public HallCont() {
		System.out.println("------HallCont 객체 생성 완료");
	}
		    
    //결과확인
    //->http://localhost:9095/product/list
    
    @RequestMapping("/list")
    public ModelAndView list() {
        ModelAndView mav=new ModelAndView();
        mav.setViewName("hall/hallList");
        //mav.addObject("list", hallDao.list());
        return mav;
    }//list() end
	
}
