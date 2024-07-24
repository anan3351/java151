package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

@Repository
public class SeatDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<SeatDTO> getSeatsByHallIdAndFloor(String hallId, String floor) {
        String sql = "SELECT * FROM tb_seat WHERE hall_id = ? AND s_floor = ?";
        return jdbcTemplate.query(sql, new Object[]{hallId, floor}, new SeatRowMapper());
    }

    public Set<String> getAllFloorsByHallId(String hallId) {
        String sql = "SELECT DISTINCT s_floor FROM tb_seat WHERE hall_id = ? ORDER BY s_floor ASC";
        List<String> floors = jdbcTemplate.queryForList(sql, new Object[]{hallId}, String.class);
        return new TreeSet<>(floors);
    }

    public SeatDTO getSeatById(int seatId) {
        String sql = "SELECT * FROM tb_seat WHERE seat_id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{seatId}, new SeatRowMapper());
    }

    private static final class SeatRowMapper implements RowMapper<SeatDTO> {
        @Override
        public SeatDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            SeatDTO seat = new SeatDTO();
            seat.setSeat_id(rs.getInt("seat_id"));
            seat.setS_floor(rs.getString("s_floor"));
            seat.setS_number(rs.getString("s_number"));
            seat.setHall_id(rs.getString("hall_id"));
            seat.setSeat_level(rs.getString("seat_level"));
            return seat;
        }
    }
}
