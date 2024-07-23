package com.example.demo.hall;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    	 List<HallOrderDTO> hallIdOrderCart = hallOrderDao.getLatestOrderCart();
        model.addAttribute("orders", latestOrder);
        model.addAttribute("get", hallIdOrder);
        model.addAttribute("Carts", hallIdOrderCart);
        
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
	//결제 완료 정보 넘어오면 데이터 테이블 결제완료로 업데이트
	@PostMapping("/updateOrderStatus")
	@ResponseBody
    public Map<String, Object> updateOrderStatus(@RequestBody Map<String, Object> request) {
        String hallOrderId = (String) request.get("hallOrderId");
        String payDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String payStatus = (String) request.get("pay_status");

        int updateSuccess = hallOrderDao.updateOrderStatus(hallOrderId, payDate, payStatus);

        Map<String, Object> response = new HashMap<>();
        response.put("update_success", updateSuccess);
        return response;
    }
	
	//결제 정보 로직 정상결과 확인
	@PostMapping("/complete")
    public Map<String, Object> completePayment(@RequestBody Map<String, Object> request) {
        String impUid = (String) request.get("imp_uid");

        // 여기에 결제 정보 확인 로직을 추가합니다.

        Map<String, Object> response = new HashMap<>();
        response.put("everythings_fine", true); // 결제 정보가 정상인지 확인하는 로직 추가

        return response;
    }
   
}//end HallCont
