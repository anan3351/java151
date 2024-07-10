package com.example.demo.seat;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SeatReviewDAO {
    List<SeatReviewDTO> findBySeatId(int seat_id);
    List<SeatReviewDTO> getAllReviews();
    void addReview(SeatReviewDTO review);
}
