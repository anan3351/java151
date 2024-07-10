package com.example.demo.ticket;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class TicketDTO {
    private int ticketId;
    private String showId;
    private Date ticketDate;
}
