package com.example.demo.hall;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;


@Controller
@RequestMapping("/hall")
public class HallOrderCont {
	
	private static final Logger log = LoggerFactory.getLogger(HallOrderCont.class);
	
	
	public HallOrderCont() {
		System.out.println("----------HallCont 객체생성완료");
	}
	
	@Autowired
	private HallOrderDAO hallOrderDao;
	
	
	@Transactional
	@PostMapping("/order")
    @ResponseBody
    public String createOrder(@RequestBody HallOrderDTO hallOrderDto) {
        try {
        	hallOrderDao.insertOrder(hallOrderDto);
            return "success";
        } catch (Exception e) {
        	 e.printStackTrace();
             return "error: " + e.getMessage();
        }
    }
	
    @GetMapping("/hallOrder")
    public String showOrderDetails(Model model) {
        HallOrderDTO latestOrder = hallOrderDao.getLatestOrder();
        HallOrderDTO hallIdOrder = hallOrderDao.gethallIdOrder();
        model.addAttribute("order", latestOrder);
        model.addAttribute("get", hallIdOrder);
        
        return "hall/hallOrder";
    }
    
   
   
}//end HallCont
