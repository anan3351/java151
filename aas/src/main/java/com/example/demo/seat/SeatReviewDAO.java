package com.example.demo.seat;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface SeatReviewDAO {
    List<SeatReviewDTO> getAllReviews();
    void addReview(SeatReviewDTO review);
}//end
