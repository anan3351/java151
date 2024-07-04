package com.example.demo.seat;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SeatController {

    @Autowired
    private SeatService seatService;

    @GetMapping("/seats")
    public String getSeats(Model model) {
        List<SeatDTO> seats = seatService.getAllSeats();
        model.addAttribute("seats", seats);
        return "seat/seat";
    }
}
