package com.example.demo.hall;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import java.util.Collections;
import java.util.List;

@Controller
public class HallCont {
	
	public HallCont() {
		System.out.println("----------HallCont 객체생성완료");
	}

    @Autowired
    private HallDAO hallDao;
    
    
    //결과확인
    //->http://localhost:9095/list
    
    @RequestMapping("/list")
    public ModelAndView list() {
        ModelAndView mav=new ModelAndView();
        mav.setViewName("hall/hallList");
        mav.addObject("list", hallDao.list());
        return mav;
    }//list() end
    

}//end HallCont
