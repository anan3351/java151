package com.example.demo.seat;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SeatDAO {
    
    @Select("SELECT * FROM tb_seat")
    List<SeatDTO> findAll();
}
