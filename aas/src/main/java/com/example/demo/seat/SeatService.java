package com.example.demo.seat;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SeatService {

    @Autowired
    private SeatMapper seatMapper;

    public List<SeatDTO> getAllSeats() {
        return seatMapper.findAll();
    }
}
