package com.example.demo.acsch;

import com.example.demo.ticket.TicketDTO;
import com.example.demo.showcasting.ShowCastingDTO;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AcschMapper {

    // TicketMapper Methods
    void insertTicket(TicketDTO ticketDTO);

    // ActorMapper Methods
    Integer findActorIdByRecentWork(@Param("params") Map<String, Object> params);

    // ShowCastingMapper Methods
    void insertShowCasting(ShowCastingDTO showCastingDTO);

    // AcschMapper Methods
    void insertAcsch(AcschDTO acschDTO);

    // Check for duplicate casting
    Integer checkDuplicateCasting(@Param("show_id") String show_id, @Param("actor_id") Integer actor_id, @Param("casting") String casting);

    // Check for duplicate ticket
    Integer checkDuplicateTicket(@Param("show_id") String show_id, @Param("ticket_date") Date ticket_date);

    // Check for duplicate acsch
    Integer checkDuplicateAcsch(@Param("casting_id") Integer casting_id, @Param("ticket_id") Integer ticket_id);
}
