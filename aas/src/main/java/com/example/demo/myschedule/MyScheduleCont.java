package com.example.demo.myschedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class MyScheduleCont {

	public MyScheduleCont() {
		System.out.println("-----MyScheduleCont 객체 생성");
	}
	
	@Autowired MyScheduleDAO myScheduleDao;
	
    @GetMapping("/myschedule")
    public String getAllSchedules(HttpSession session ,Model model) {
    	 String user_id = (String) session.getAttribute("user_id");
        List<MyScheduleDTO> schedules = myScheduleDao.getAllSchedules(user_id);
        model.addAttribute("schedules", schedules);
        return "myschedule/list";
    }
	
}//class end
