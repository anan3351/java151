package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SeatReviewDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<SeatReviewDTO> getAllReviews() {
        String sql = "SELECT * FROM tb_seatreview ORDER BY seat_date DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            SeatReviewDTO review = new SeatReviewDTO();
            review.setSeatviewId(rs.getInt("seatview_id"));
            review.setUserId(rs.getString("user_id"));
            review.setDate(rs.getTimestamp("seat_date"));
            review.setDetail(rs.getString("detail"));
            review.setSeatRank(rs.getInt("seat_rank"));
            review.setSeatId(rs.getInt("seat_id"));
            return review;
        });
    }

    public void addReview(SeatReviewDTO review) {
        String sql = "INSERT INTO tb_seatreview (user_id, detail, seat_rank, seat_id) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, review.getUserId(), review.getDetail(), review.getSeatRank(), review.getSeatId());
    }
}
