package com.example.demo.actor;

import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("")
public class ActorCont {
    public ActorCont() {
        System.out.println("-----ActorCont 객체 생성");
    }

    @Autowired
    private ActorDAO actorDao;

    @RequestMapping("/actor")
    public ModelAndView actorlist(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("actor/list");

        int totalRowCount = actorDao.totalRowCount(); // 총 글갯수

        // 페이징
        int numPerPage = 5; // 한 페이지당 레코드 갯수
        int pagePerBlock = 10; // 페이지 리스트

        String pageNum = req.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage;
        int endRow = numPerPage; // LIMIT 절에서 필요한 값으로 수정

        // 페이지 수
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);

        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int) Math.ceil(d_page) - 1;
        int startPage = Pages * pagePerBlock + 1;
        int endPage = startPage + pagePerBlock - 1;
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        List<ActorDTO> list = null;
        if (totalRowCount > 0) {
            list = actorDao.list2(startRow, endRow);
        } else {
            list = Collections.emptyList();
        }

        mav.addObject("currentPage", currentPage);
        mav.addObject("totalPages", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.addObject("list", list);
        mav.addObject("pageNum", currentPage); // 추가
        mav.addObject("count", totalRowCount); // 추가

        return mav;
    }// list end


    @RequestMapping("/actor/list")
    public ModelAndView alllist(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("actor/alllist");

        int totalRowCount = actorDao.totalRowCount(); // 총 글갯수

        // 페이징
        int numPerPage = 20; // 한 페이지당 레코드 갯수
        int pagePerBlock = 10; // 페이지 리스트

        String pageNum = req.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }

        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * numPerPage;
        int endRow = numPerPage; // LIMIT 절에서 필요한 값으로 수정

        // 페이지 수
        double totcnt = (double) totalRowCount / numPerPage;
        int totalPage = (int) Math.ceil(totcnt);

        double d_page = (double) currentPage / pagePerBlock;
        int Pages = (int) Math.ceil(d_page) - 1;
        int startPage = Pages * pagePerBlock + 1;
        int endPage = startPage + pagePerBlock - 1;
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        List<ActorDTO> list = null;
        if (totalRowCount > 0) {
            list = actorDao.list2(startRow, endRow);
        } else {
            list = Collections.emptyList();
        }

        mav.addObject("currentPage", currentPage);
        mav.addObject("totalPages", totalPage);
        mav.addObject("startPage", startPage);
        mav.addObject("endPage", endPage);
        mav.addObject("list", list);
        mav.addObject("pageNum", currentPage); // 추가
        mav.addObject("count", totalRowCount); // 추가


        return mav;
    }

    @RequestMapping("/actordetail")
    public ModelAndView actordetail(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("actor/actordetail");
      
        int actorId = Integer.parseInt(req.getParameter("id"));
        ActorDTO actor = actorDao.getActorById(actorId);
        mav.addObject("actor", actor);
        
        return mav;
    }//actordetail end
    
    @GetMapping("/actor/search")
    public String search(@RequestParam("search") String search, Model model) {
        List<ActorDTO> list = actorDao.searchActors(search);
        model.addAttribute("list", list);
        return "actor/alllist";
    }
    
    
    
}//class end