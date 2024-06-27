package com.example.demo.actor;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/actor")
public class ActorCont {
    public ActorCont() {
        System.out.println("-----ActorCont객체생성");
    }

    @Autowired
    private ActorDAO actorDao;

    @RequestMapping("/list")
    public ModelAndView actorlist() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("actor/list");
        mav.addObject("list", actorDao.list());
        return mav;
    }
}