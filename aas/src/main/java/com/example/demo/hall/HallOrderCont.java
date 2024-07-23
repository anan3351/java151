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

import com.example.demo.user.UserDAO;
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
	
	@Autowired
	private UserDAO userDao;
	
	
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
    	 List<HallOrderDTO> latestOrder = hallOrderDao.getLatestOrder();
    	 List<HallOrderDTO> hallIdOrder = hallOrderDao.gethallIdOrder();
        model.addAttribute("orders", latestOrder);
        model.addAttribute("get", hallIdOrder);
        
        return "hall/hallOrder";
    }
    

	@PostMapping("/requestApproval")
	@ResponseBody
	public ResponseEntity<?> requestApproval(@RequestParam String hallOrder_id) {
		hallOrderDao.updatePayStatus(hallOrder_id, "승인대기진행중");
		return ResponseEntity.ok().build();
	}


	@PostMapping("/approveRequest")
	@ResponseBody
	public ResponseEntity<?> approveRequest(@RequestParam String hallOrderId) {
		hallOrderDao.updatePayStatus(hallOrderId, "승인완료");
		return ResponseEntity.ok().build();
	}
	
	@PostMapping("/requestDel")
	@ResponseBody
	public int hallOrderDel(@RequestParam String hallOrder_id) {
	    return hallOrderDao.hallOrderDel(hallOrder_id);
	}
	
	@PostMapping("/deleteOrder")
	@ResponseBody
	public int hallDeleteOrder(@RequestParam String hallOrder_id) {
	    return hallOrderDao.hallDeleteOrder(hallOrder_id);
	}
	
		
	@GetMapping("/cartCount")
	@ResponseBody
	public int countHallOrder(@RequestParam String userId) {
		return hallOrderDao.getCartCount(userId);
		
	}
	
   
}//end HallCont
