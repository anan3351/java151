package com.example.demo.seat;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SeatReviewCont {

    @Autowired
    private SeatReviewServ seatReviewServ;
    
    @Autowired
    private SeatService seatService;

    @GetMapping("/seatReview")
    public String getSeatReviews(@RequestParam(value = "seat_id", required = false) Integer seat_id, Model model) {
        if (seat_id == null) {
            seat_id = 1; // 기본값 설정
        }
        List<SeatReviewDTO> reviews = seatReviewServ.getReviewsBySeatId(seat_id);
        SeatDTO seat = seatService.getSeatById(seat_id); // Seat 정보를 가져옵니다.
        
        model.addAttribute("reviews", reviews);
        model.addAttribute("seat", seat); // Seat 정보를 Model에 추가합니다.
        model.addAttribute("seat_id", seat_id);
        return "seat/seatReview"; // seatReview.jsp로 매핑되는지 확인
    }
}
