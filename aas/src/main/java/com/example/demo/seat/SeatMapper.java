package com.example.demo.seat;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SeatMapper {
    List<SeatDTO> findAll();
}
