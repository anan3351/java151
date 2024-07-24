package com.example.demo.seat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("")
public class SeatCont {

    @Autowired
    private SeatDAO seatDAO;

    @GetMapping("/seat")
    public ModelAndView getSeats(@RequestParam(value = "hall_id", required = false, defaultValue = "1") String hallId, 
                                 @RequestParam(value = "floor", required = false, defaultValue = "1층") String floor) {
        ModelAndView mav = new ModelAndView();
        List<SeatDTO> seatInfo = seatDAO.getSeatsByHallIdAndFloor(hallId, floor);
        Set<String> floors = seatDAO.getAllFloorsByHallId(hallId);
        mav.addObject("seatInfo", seatInfo);
        mav.addObject("floors", floors);
        mav.addObject("currentFloor", floor);
        mav.setViewName("seat/seat");
        return mav;
    }
}
