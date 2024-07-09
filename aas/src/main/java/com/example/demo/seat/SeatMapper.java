package com.example.demo.seat;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SeatMapper {
    List<SeatDTO> findAll();

    @Select("SELECT * FROM tb_seat WHERE seat_id = #{seat_id}")
    SeatDTO findById(int seat_id);
}
