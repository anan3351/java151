package com.example.demo.seat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatReviewDAO {
    private Connection getConnection() throws Exception {
        String jdbcUrl = "jdbc:mariadb://192.168.14.14:3306/aas"; // 수정 필요
        String dbUser = "team"; // 수정 필요
        String dbPass = "1234"; // 수정 필요
        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
    }

    public List<SeatReviewDTO> getAllReviews() {
        List<SeatReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM tb_seatreview";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                SeatReviewDTO review = new SeatReviewDTO();
                review.setSeatviewId(rs.getInt("seatview_id"));
                review.setUserId(rs.getString("user_id"));
                review.setDate(rs.getString("seat_date"));
                review.setDetail(rs.getString("detail"));
                review.setSeatRank(rs.getInt("seat_rank"));
                review.setSeatId(rs.getInt("seat_id"));
                reviews.add(review);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reviews;
    }
}
