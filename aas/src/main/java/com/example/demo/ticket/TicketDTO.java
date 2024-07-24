package com.example.demo.ticket;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class TicketDTO {
    private int ticket_id;
    private String show_id;
    private Date ticket_Date;

    // 필요한 getter 메서드 추가
    public Date getTicket_date() {
        return ticket_Date;
    }
}
