package com.example.demo.ticket;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TicketMapper {
    
    @Select("SELECT * FROM tb_ticket")
    List<TicketDTO> findAll();
}
