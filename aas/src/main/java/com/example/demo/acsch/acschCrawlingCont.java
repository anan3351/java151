package com.example.demo.acsch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class acschCrawlingCont {

    @Autowired
    private  acschCrawiling acschCrawiling;

    @GetMapping("/showTitle")
    public String getShowTitle() {
        return acschCrawiling.getShowTitle();
    }

    @GetMapping("/showSchedule")
    public List<String> getShowSchedule() {
        return acschCrawiling.getShowSchedule();
    }
}
