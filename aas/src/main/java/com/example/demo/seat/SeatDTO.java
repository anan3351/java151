package com.example.demo.seat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatDTO {
    private int seat_id;
    private String s_section;
    private int s_floor;
    private String s_row;
    private int s_number;
    private String hall_id;
    private String seat_level;

    // getters and setters
}
