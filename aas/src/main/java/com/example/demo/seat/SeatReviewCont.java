package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SeatReviewCont {

    @Autowired
    private SeatReviewServ seatReviewServ;

    @GetMapping("/seatReview")
    public String getSeatReviews(@RequestParam("seat_id") int seat_id, Model model) {
        List<SeatReviewDTO> reviews = seatReviewServ.getReviewsBySeatId(seat_id);
        SeatDTO seat = seatReviewServ.getSeatById(seat_id);

        model.addAttribute("seat", seat);
        model.addAttribute("reviews", reviews);

        return "seat/seatReview";
    }
}
