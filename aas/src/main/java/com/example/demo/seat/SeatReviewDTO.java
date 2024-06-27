package com.example.demo.seat;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatReviewDTO {
    private int seatviewId;
    private String userId;
    private Timestamp date;
    private String detail;
    private int seatRank;
    private int seatId;
}
