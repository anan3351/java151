package com.example.demo.seat;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatReviewDTO {
    private int seatview_id;
    private String user_id;
    private Timestamp date;
    private String detail;
    private int seat_rank;
    private int seat_id;
}//end
