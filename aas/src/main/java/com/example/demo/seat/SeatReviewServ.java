package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SeatReviewServ {

    @Autowired
    private SeatReviewDAO seatReviewDAO;

    public List<SeatReviewDTO> getAllReviews() {
        return seatReviewDAO.getAllReviews();
    }

    public void addReview(SeatReviewDTO review) {
        seatReviewDAO.addReview(review);
    }
}
