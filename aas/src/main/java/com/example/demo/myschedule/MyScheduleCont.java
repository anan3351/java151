package com.example.demo.myschedule;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.orderdetail.OrderDetailDAO;
import com.example.demo.orderdetail.OrderDetailDTO;
import com.example.demo.user.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/myschedule")
public class MyScheduleCont {
	
    // Constructor
    public MyScheduleCont() {
        System.out.println("-----MyScheduleCont 객체 생성");
    }
    @Autowired
    OrderDetailDAO orderDetailDao;
    @Autowired 
    MyScheduleDAO myScheduleDao;

    // 사용자 ID에 따른 전체 스케줄 조회
    @GetMapping("/list")
    public String getAllSchedules(HttpSession session, Model model) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            System.out.println("User is not logged in."); // 디버깅용 로그
            return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
        }
        String user_id = loggedInUser.getUser_id();
        List<MyScheduleDTO> schedules = myScheduleDao.getAllSchedules(user_id);
        model.addAttribute("schedules", schedules);
        return "myschedule/list";
    }

    // 새로운 스케줄 작성 폼을 표시
    @GetMapping("/new")
    public String showCreateForm(Model model, HttpSession session) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }
        String user_id = loggedInUser.getUser_id();
        List<OrderDetailDTO> orderDetails = orderDetailDao.getOrderDetailsByUserId(user_id);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("schedule", new MyScheduleDTO());
        return "myschedule/form";
    }

    // 새로운 스케줄 저장
    @PostMapping("/save")
    public String saveSchedule(@ModelAttribute MyScheduleDTO schedule, @RequestParam(required = false) Integer order_id, HttpSession session) {
        UserDTO loggedInUser = (UserDTO) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/user/login";
        }
        String userId = loggedInUser.getUser_id();
        schedule.setUser_id(userId);

        // 주문 내역을 선택하지 않은 경우도 처리
        if (order_id != null) {
            // order_id가 제공된 경우, 해당 주문 내역을 가져와서 스케줄 필드에 설정
            OrderDetailDTO orderDetail = orderDetailDao.getOrderDetailById(order_id);
            schedule.setOrder_id(order_id);
            schedule.setSeat(orderDetail.getSeat_id() + ""); // seat_id를 seat로 설정 (필요에 따라 수정)
            schedule.setFair(orderDetail.getTotal_amount() + ""); // total_amount를 fair로 설정 (필요에 따라 수정)
            schedule.setTitle(orderDetail.getOrder_info()); // order_info를 title로 설정 (필요에 따라 수정)
            // 필요한 다른 필드를 설정
        } else {
            schedule.setOrder_id(null); // 직접 입력 시 order_id를 null로 설정
        }

        myScheduleDao.saveSchedule(schedule);
        return "redirect:/myschedule/list";
    }

  
    // 스케줄 수정 폼을 표시
    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") int mysch_id, Model model) {
        MyScheduleDTO schedule = myScheduleDao.getScheduleById(mysch_id);
        model.addAttribute("schedule", schedule);
        return "myschedule/form";
    }

    // 스케줄 업데이트
    @PostMapping("/update")
    public String updateSchedule(@ModelAttribute("schedule") MyScheduleDTO schedule) {
        myScheduleDao.updateSchedule(schedule);
        return "redirect:/myschedule/list";  // 경로를 /myschedule/list로 변경
    }

    // 스케줄 삭제
    @GetMapping("/delete")
    public String deleteSchedule(@RequestParam("id") int mysch_id) {
        myScheduleDao.deleteSchedule(mysch_id);
        return "redirect:/myschedule/list";  // 경로를 /myschedule/list로 변경
    }
}
