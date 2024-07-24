package com.example.demo.order;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderCont {

    @RequestMapping("/order")
    public String order() {
        return "order/order";
    }

    @RequestMapping("/seatSelection")
    public String seatSelection() {
        return "order/seatSelection";
    }

    @RequestMapping("/priceSelection")
    public String priceSelection() {
        return "order/priceSelection";
    }

    @RequestMapping("/deliveryConfirmation")
    public String deliveryConfirmation() {
        return "order/deliveryConfirmation";
    }
}