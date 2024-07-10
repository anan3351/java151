package com.example.demo.seat;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SeatReviewServ {

    @Autowired
    private SeatReviewDAO seatReviewDAO;

    public List<SeatReviewDTO> getReviewsBySeatId(int seat_id) {
        return seatReviewDAO.findBySeatId(seat_id);
    }

    public void addReview(SeatReviewDTO review) {
        seatReviewDAO.addReview(review);
    }
}
