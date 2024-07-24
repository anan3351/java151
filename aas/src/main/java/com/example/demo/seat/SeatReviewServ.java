package com.example.demo.seat;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SeatReviewServ {

    @Autowired
    private SeatReviewDAO seatReviewDAO;

    @Autowired
    private SeatDAO seatDAO;

    public List<SeatReviewDTO> getReviewsBySeatId(int seat_id) {
        return seatReviewDAO.findBySeatId(seat_id);
    }

    public void addReview(SeatReviewDTO review) {
        seatReviewDAO.addReview(review);
    }

    public SeatDTO getSeatById(int seat_id) {
        return seatDAO.getSeatById(seat_id);
    }
}
