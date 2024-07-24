package com.example.demo.seat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatDTO {
    private int seat_id;
    private String s_floor;
    private String s_number;
    private String hall_id;
    private String seat_level;
}
