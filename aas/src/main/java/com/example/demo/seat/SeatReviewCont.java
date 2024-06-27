package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

@Controller
public class SeatReviewCont {

    @Autowired
    private SeatReviewServ seatReviewService;

    @GetMapping("/seatReviews")
    public String getAllReviews(Model model) {
        List<SeatReviewDTO> reviews = seatReviewService.getAllReviews();
        model.addAttribute("reviews", reviews);
        return "/seat/seatReview";
    }
}
